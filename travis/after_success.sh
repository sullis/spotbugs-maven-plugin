#!/bin/bash
#
# Licensed under the GPL License. You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   https://www.gnu.org/licenses/old-licenses/gpl-2.0.html
#
# THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
# WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR
# PURPOSE.
#

# We build for several JDKs on Travis.
# Some actions, like analyzing the code (Coveralls) and uploading
# artifacts on a Maven repository, should only be made for one version.
 
# If the version is 1.8, then perform the following actions.
# 1. Upload artifacts to Sonatype.
#    a. Use -q option to only display Maven errors and warnings.
#    b. Use --settings to force the usage of our "settings.xml" file.
# 2. Notify Coveralls.
# 3. Deploy site
#    a. Use -q option to only display Maven errors and warnings.

if [ $TRAVIS_REPO_SLUG == "spotbugs/spotbugs-maven-plugin" ] && [ $TRAVIS_PULL_REQUEST == "false" ] && [ $TRAVIS_BRANCH == "spotbugs" ] && [ "$TRAVIS_COMMIT_MESSAGE" != *"[maven-release-plugin]"* ]; then

  if [ $TRAVIS_JDK_VERSION == "oraclejdk8" ]; then

    # Deploy to site
    ./mvnw site -B -Ddownloader.tls.protocols=TLSv1.1,TLSv1.2,TLSv1.3
	echo -e "Successfully deployed site under Travis job ${TRAVIS_JOB_NUMBER}"
  fi

else
  echo "Travis build skipped"
fi
