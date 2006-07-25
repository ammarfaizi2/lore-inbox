Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWGYDxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWGYDxb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 23:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWGYDxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 23:53:31 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:40398 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932159AbWGYDxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 23:53:30 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.4.1.1
cc: linux-kernel@vger.kernel.org
Date: Mon, 24 Jul 2006 20:53:29 -0700
Message-ID: <7vejwae3wm.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.4.1.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.1.1.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.1.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.1.1.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.1.1-1.$arch.rpm	(RPM)

The primary purpose of this release is to fix the breakage
people reported while cloning large quantity of data via git
protocol, and the server side incorrectly timing out.  I am very
sorry for the breakage.

A big thanks goes to Matthias Lederhofer who fixed the breakage
for us.  The fix was cherry-picked from the "master" branch.

The "master" branch has the same fix already and we will have an
1.4.2-rc2 sometime this week, hopefully soon.

----------------------------------------------------------------

Changes since v1.4.1 are as follows:

Junio C Hamano:
      Makefile: tighten git-http-{fetch,push} dependencies

Linus Torvalds:
      revision.c: fix "dense" under --remove-empty

Matthias Lederhofer:
      upload-pack: fix timeout in create_pack_file

Robin Rosenberg:
      Empty author may be presented by svn as an empty string or a null value.


