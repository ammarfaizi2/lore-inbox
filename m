Return-Path: <linux-kernel-owner+w=401wt.eu-S1756821AbWLIVNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821AbWLIVNh (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 16:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756982AbWLIVNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 16:13:37 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:51122 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344AbWLIVNg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 16:13:36 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.4.4.2
cc: linux-kernel@vger.kernel.org
Date: Sat, 09 Dec 2006 13:13:34 -0800
Message-ID: <7vu004ai2p.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.4.4.2 has been available at
the usual places for a few days, but vger seems to have eaten
the message I sent out, so here is a resend:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.4.2.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.4.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.4.2.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.4.2-1.$arch.rpm	(RPM)

This contains a handful fixes since 1.4.4.1; nothing earth
shattering.

----------------------------------------------------------------

Changes since v1.4.4.1 are as follows:

Alex Riesen (1):
      git-blame: fix rev parameter handling.

Andy Parkins (2):
      Increase length of function name buffer
      Document git-repo-config --bool/--int options.

Eric Wong (4):
      git-svn: error out from dcommit on a parent-less commit
      git-svn: correctly handle revision 0 in SVN repositories
      git-svn: preserve uncommitted changes after dcommit
      git-svn: avoid fetching files twice in the same revision

Johannes Schindelin (1):
      git-mv: search more precisely for source directory in index

Junio C Hamano (5):
      git blame -C: fix output format tweaks when crossing file boundary.
      tutorial: talk about user.name early and don't start with commit -a
      receive-pack: do not insist on fast-forward outside refs/heads/
      unpack-trees: make sure "df_conflict_entry.name" is NUL terminated.
      git-reset to remove "$GIT_DIR/MERGE_MSG"

René Scharfe (1):
      archive-zip: don't use sizeof(struct ...)

