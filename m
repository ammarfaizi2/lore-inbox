Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267484AbUBSSz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUBSSxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:53:39 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:17671 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267477AbUBSSw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:52:28 -0500
Date: Thu, 19 Feb 2004 18:52:24 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Permedia2 framebuffer update.
Message-ID: <Pine.LNX.4.44.0402191850370.26734-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

  Here is the new permedia2 framebuffer driver ported to the new api. Link 
to diff for viewing is at

http://phoenix.infradead.org:~/jsimmons/pm2fb.diff

Linus, please do a

	bk pull bk://fbdev.bkbits.net/fbdev-2.6

This will update the following files:

 drivers/video/cvisionppc.h |   51 
 include/video/pm2fb.h      |  222 ---
 drivers/video/Kconfig      |   18 
 drivers/video/Makefile     |    2 
 drivers/video/pm2fb.c      | 3014 +++++++++++++--------------------------------
 include/video/cvisionppc.h |   51 
 include/video/permedia2.h  |  222 +++
 7 files changed, 1210 insertions(+), 2370 deletions(-)

through these ChangeSets:

<jsimmons@infradead.org> (04/02/17 1.1562)
   [PERMEDIA2 FBDEV] Updated to the new api.


