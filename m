Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWAIBU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWAIBU6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 20:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWAIBU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 20:20:58 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:10745 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751502AbWAIBU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 20:20:56 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.0.8
cc: linux-kernel@vger.kernel.org
Date: Sun, 08 Jan 2006 17:20:53 -0800
Message-ID: <7vy81qtcwa.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.0.8 is available at the usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.0.8.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.0.8-1.$arch.rpm	(RPM)

This is mostly "small fixes" release.

Changes since v1.0.7 are as follows:

Joe English:
      Substitute "/" with $opt_s in tag names as well as branch names

Junio C Hamano:
      unpack-objects: default to quiet if stderr is not a tty.
      Retire debian/ directory.
      prune: do not show error from pack-redundant when no packs are found.
      Compilation: zero-length array declaration.
      tar-tree: finish honoring extractor's umask in git-tar-tree.
      revert/cherry-pick: handle single quote in author name.
      mailsplit: allow empty input from stdin
      GIT 1.0.8

Yann Dirson:
      Teach cvsexportcommit to add new files
      Fix typo in debug stanza of t2001
      Fix git-format-patch usage string wrt output modes.


