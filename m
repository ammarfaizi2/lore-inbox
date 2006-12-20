Return-Path: <linux-kernel-owner+w=401wt.eu-S965149AbWLTUsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWLTUsq (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWLTUsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:48:46 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:33334 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964890AbWLTUso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:48:44 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: What's in git.git (stable), and Announcing GIT 1.4.4.3
cc: linux-kernel@vger.kernel.org
X-maint-at: 851a911024481f6759bce337b8dc50241070db81
X-master-at: 54851157acf707eb953eada2a84830897dde5c1d
Date: Wed, 20 Dec 2006 12:48:41 -0800
Message-ID: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.4.4.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.4.3.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.4.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.4.3.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.4.3-1.$arch.rpm	(RPM)

This release contains merge-recursive corner case fix; it also
fixes git-cvsserver (when used with newer Perl) and Mac OS build
(when you use config.mak), among other things.

To let people who only follow the 'maint' releases know what's
happening in the larger picture...

We have just started talking about the next feature release
v1.5.0 on the 'master' branch side.  If we are lucky we could do
a -rc1 around Christmas, emperor's birthday in Japan, or perhaps
emperor's birthday in the Penguin land, but in any case the real
release is not expected to happen by mid January.

The new release will have many end-user level changes since the
last feature release v1.4.4, both at the UI level and at the
documentation level, based on previous discussions on the list.

It is strongly encouraged and very much appreciated to review
and to fill gaps you would find in today's 'master' and what's
cooking in 'next', if you were involved in the discussions
and/or if you are interested in the theme of v1.5.0: "usability
and teachability".

Thanks.

-jc.

----------------------------------------------------------------
* The 'maint' branch is at v1.4.4.3 and has these fixes since
  v1.4.4.2:

   Alex Riesen (1):
      Clarify fetch error for missing objects.

   Brian Gernhardt (1):
      Move Fink and Ports check to after config file

   Chris Wright (1):
      no need to install manpages as executable

   Eric Wong (2):
      git-svn: exit with status 1 for test failures
      git-svn: correctly display fatal() error messages

   Jim Meyering (1):
      Don't use memcpy when source and dest. buffers may overlap

   Junio C Hamano (1):
      GIT 1.4.4.3

   Martin Langhoff (1):
      cvsserver: Avoid miscounting bytes in Perl v5.8.x

   Shawn Pearce (2):
      Make sure the empty tree exists when needed in merge-recursive.
      Bypass expensive content comparsion during rename detection.

* The 'master' branch has these since the last announcement.
  They are NOT in 1.4.4.3.

   Aneesh Kumar K.V (1):
      Add config example with respect to branch

   Brian Gernhardt (2):
      Add documentation for show-branch --topics
      Remove COLLISION_CHECK from Makefile since it's not used.

   Eric Wong (1):
      git-cvsserver: fix breakage when calling git merge-file

   Jeff King (1):
      vim syntax: follow recent changes to commit template

   Junio C Hamano (8):
      parse-remote::expand_refs_wildcard()
      show-ref: fix --exclude-existing
      racy-git: documentation updates.
      rerere: fix breakage of resolving.
      fix populate-filespec
      config_rename_section: fix FILE* leak
      simplify inclusion of system header files.
      GIT 1.4.4.3

   Nicolas Pitre (4):
      make patch_delta() error cases a bit more verbose
      make git a bit less cryptic on fetch errors
      index-pack usage of mmap() is unacceptably slower on many OSes
         other than Linux
      clarify some error messages wrt unknown object types

   Robert Fitzsimons (1):
      gitweb: Show '...' links in "summary" view only if there are more items


