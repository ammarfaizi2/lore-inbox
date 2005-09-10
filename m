Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVIJUCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVIJUCL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVIJUCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:02:11 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:60571 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932247AbVIJUCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:02:10 -0400
Date: Sat, 10 Sep 2005 22:03:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: [GIT PATCHES] final kbuild update before fix-only period
Message-ID: <20050910200347.GA3762@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Please pull from:
	rsync://sync.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

The updates are pushed to master.kernel.org - still waiting for
mirroring to pick them up.

This update contains a fix with make O= for generic asm-offsets.h, plus
additional patches from my queue.
This clears my queue of pending patches for 2.6.14.

I will try to follow-up with all patches.

	Sam


Jan Beulich:
  kbuild: adjust .version updating
  kbuild: fix split-include dependency

Roland McGrath:
  kbuild: ignore all debugging info sections in scripts/reference_discarded.pl

Sam Ravnborg:
  kbuild: add objectify
  kbuild: fix generic asm-offsets.h support

viro@ZenIV.linux.org.uk:
  kbuild: CF=<arguments> passes arguments to sparse

Zach Brown:
  kbuild: add kernelrelease to 'make help'


 Makefile                         |   23 ++++++++++++++++-------
 b/Kbuild                         |    5 +++--
 b/Makefile                       |    2 +-
 b/scripts/Kbuild.include         |    3 +++
 b/scripts/reference_discarded.pl |    7 +------
 5 files changed, 24 insertions(+), 16 deletions(-)
