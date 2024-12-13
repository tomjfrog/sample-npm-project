# Use the official Node.js 18 image as the base image
FROM tomjfrog.jfrog.io/dockerhub-remote/node:18-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Inject Base64-encoded .npmrc content and decode it
ARG NPMRC_ENCODED
RUN echo "$NPMRC_ENCODED" | base64 -d > .npmrc

# Install dependencies
RUN npm install

# Clean up sensitive file
RUN rm .npmrc

# Copy the rest of the application source code to the container
COPY . ./

# Expose the application port
EXPOSE 3000

# Define the command to start the application
CMD ["node", "index.js"]