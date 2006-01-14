Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423062AbWANExd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423062AbWANExd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 23:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423060AbWANExd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 23:53:33 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:43427 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1423035AbWANExc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 23:53:32 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.1.2
Date: Fri, 13 Jan 2006 20:53:29 -0800
Message-ID: <7vd5ivwgty.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.1.2 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.1.2.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.1.2-1.$arch.rpm	(RPM)

----------------------------------------------------------------

Changes since v1.1.1 are as follows:

J. Bruce Fields:
      Documentation: clarify fetch parameter descriptions.

Junio C Hamano:
      update-index: work with c-quoted name
      describe: do not silently ignore indescribable commits
      name-rev: do not omit leading components of ref name.
      show-branch: handle [] globs as well.
      Documentation: git-commit -a
      Documentation: git-reset - interrupted workflow.

Tom Prince:
      Add git-describe to .gitignore.

----------------------------------------------------------------

These have been added to the "master" branch lately, in addition
to all of the above fixes:

      Makefile: add 'strip' target.
      octopus: allow criss-cross and clarify the message when it rejects.
      checkout: automerge local changes while switching branches.
      checkout: merge local modifications while switching branches.
      git-push: avoid falling back on pushing "matching" refs.
      Exec git programs without using PATH (Michal Ostrowski)
      Fix the installation location.

These are still waiting their turn in the proposed updates
("pu") branch:

      git-cvsimport: Add -A <author-conv-file> option (Andreas Ericsson)
      convert-packs: futureproofing.
      Require packfiles to follow the naming convention (preparation).
      format-patch: always --mbox and show sane Date:
      octopus: allow manual resolve on the last round.
      Documentation: show-branch.
      show-branch: make the current branch and merge commits stand out.
      Disable USE_SYMLINK_HEAD by default (Pavel Roskin)

