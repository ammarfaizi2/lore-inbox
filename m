Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUBSAnI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 19:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267280AbUBSAnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 19:43:08 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:50702 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267278AbUBSAnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 19:43:05 -0500
Date: Thu, 19 Feb 2004 00:42:56 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Permedia2 fbdev updates.
Message-ID: <Pine.LNX.4.44.0402190032430.10389-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

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

I also have the patch is anyone wants it. Its big tho.

  


