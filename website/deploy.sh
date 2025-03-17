#!/bin/sh

# if [ "`git status -s`" ]
# then
#     echo "The working directory is dirty. Please commit any pending changes."
#     exit 1;
# fi

echo "Deleting old publication"
rm -rf public

echo "Generating site"
hugo

echo "Updating master branch"
cd public
git init

git config --global push.default simple
git config user.email "${GitHubEMail}"
git config user.name "${GitHubUser}"

git add --all .
git commit -m "Publishing to master (deploy.sh)"

echo "Pushing to github"
git push --quiet --force https://${GitHubKEY}@github.com/${GitHubUser}/${GitHubRepo}.git master
echo "push done"