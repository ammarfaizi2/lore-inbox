Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUCCWQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbUCCWQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:16:43 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:28687 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261197AbUCCWQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:16:39 -0500
Date: Wed, 3 Mar 2004 22:16:33 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: New Permedia2 framebuffer driver.
Message-ID: <Pine.LNX.4.44.0403032214180.30666-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the permedia2 framebuffer driver. Currently it doesn't 
event compile. This patch only touches the current permedia driver. 
Regular patch is valiable at

http://phoenix.infradead.org/~jsimmons/pm2fb.diff

or you can grab the patch at:

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

<jsimmons@infradead.org> (04/02/17 1.1557.1.5)
   [PERMEDIA2 FBDEV] Updated to the new api.


