Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbTDGWxy (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263774AbTDGWxf (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:53:35 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45952
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263779AbTDGWxb (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:53:31 -0400
Date: Tue, 8 Apr 2003 01:12:26 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080012.h380CQ0G008987@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: makefile for pc9800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/block/Makefile linux-2.5.67-ac1/drivers/block/Makefile
--- linux-2.5.67/drivers/block/Makefile	2003-02-10 18:38:49.000000000 +0000
+++ linux-2.5.67-ac1/drivers/block/Makefile	2003-02-20 16:30:00.000000000 +0000
@@ -12,6 +12,7 @@
 
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
+obj-$(CONFIG_BLK_DEV_FD98)	+= floppy98.o
 obj-$(CONFIG_AMIGA_FLOPPY)	+= amiflop.o
 obj-$(CONFIG_ATARI_FLOPPY)	+= ataflop.o
 obj-$(CONFIG_BLK_DEV_SWIM_IOP)	+= swim_iop.o
