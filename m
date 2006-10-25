Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbWJYWpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbWJYWpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 18:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbWJYWpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 18:45:30 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:27792 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965248AbWJYWp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 18:45:29 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.4.3.3
cc: linux-kernel@vger.kernel.org
Date: Wed, 25 Oct 2006 15:45:27 -0700
Message-ID: <7v7iyokoag.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.4.3.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.3.3.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.3.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.3.3.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.3.3-1.$arch.rpm	(RPM)

Sorry to be doing three follow-up releases in a row.  This is
primarily fix the partitioning of programs in generated RPM.  If
you are installing all of git it does not matter, but by mistake
we were placing git-archive into git-arch subpackage, which
meant that you need to install tla only to use git-tar-tree and
git-archive --format=zip.

Thanks for Gerrit for noticing and reporting it, although he is
from Debian camp ;-).

----------------------------------------------------------------

Changes since v1.4.3.2 are as follows:

Eric Wong (1):
      git-svn: fix symlink-to-file changes when using command-line svn 1.4.0

Gerrit Pape (1):
      Set $HOME for selftests

Junio C Hamano (5):
      Documentation: note about contrib/.
      RPM package re-classification.
      Refer to git-rev-parse:Specifying Revisions from git.txt
      Update cherry documentation.
      Documentation/SubmittingPatches: 3+1 != 6

Petr Baudis (1):
      xdiff: Match GNU diff behaviour when deciding hunk comment worthiness of lines

Tuncer Ayaz (1):
      git-fetch.sh printed protocol fix


