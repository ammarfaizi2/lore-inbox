Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757282AbWKWCtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757282AbWKWCtl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 21:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757280AbWKWCtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 21:49:41 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:20981 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1757278AbWKWCtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 21:49:40 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.4.4.1
cc: linux-kernel@vger.kernel.org
Date: Wed, 22 Nov 2006 18:49:28 -0800
Message-ID: <7v7ixmop1j.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.4.4.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.4.1.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.4.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.4.1.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.4.1-1.$arch.rpm	(RPM)

This contains mostly small post-release fixups.

----------------------------------------------------------------

Changes since v1.4.4 are as follows:

Alexandre Julliard (1):
      gitweb: Put back shortlog instead of graphiclog in the project list.

Chris Riddoch (1):
      Move --pretty options into Documentation/pretty-formats.txt

Jim Meyering (1):
      Run "git repack -a -d" once more at end, if there's 1MB or more of not-packed data.

Johannes Schindelin (1):
      Seek back to current filepos when mmap()ing with NO_MMAP

Junio C Hamano (7):
      git-checkout: do not allow -f and -m at the same time.
      git-checkout: allow pathspec to recover lost working tree directory
      convert-objects: set _XOPEN_SOURCE to 600
      git-fetch: follow lightweit tags as well.
      do_for_each_ref: perform the same sanity check for leftovers.
      trust-executable-bit: fix breakage for symlinks
      GIT 1.4.4.1

Linus Torvalds (2):
      git-pull: allow pulling into an empty repository
      "git fmt-merge-msg" SIGSEGV

Michal Rokos (1):
      archive: use setvbuf() instead of setlinebuf()

Paolo Ciarrocchi (2):
      Teach SubmittingPatches about git-commit -s
      Doc: Make comment about merging in tutorial.txt more clear

Petr Baudis (4):
      Fix git-for-each-refs broken for tags
      git-apply: Documentation typo fix
      Documentation: Define symref and update HEAD description
      Documentation: Correct alternates documentation, document http-alternates

Rene Scharfe (4):
      sparse fix: non-ANSI function declaration
      sparse fix: Using plain integer as NULL pointer
      git-apply: slightly clean up bitfield usage
      Document git-runstatus


