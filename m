Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTHTICI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbTHTIAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:00:51 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:24781 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261764AbTHTH7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 03:59:46 -0400
Date: Wed, 20 Aug 2003 18:00:56 +1000
Message-Id: <200308200800.h7K80uvO011670@theirongiant.lochness.weebeastie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/16] C99: 2.6.0-t3-bk7/arch/cris
Cc: Linus Torvalds <torvalds@osdl.org>
From: CaT <cat@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux.backup/arch/cris/arch-v10/drivers/pcf8563.c linux/arch/cris/arch-v10/drivers/pcf8563.c
--- linux.backup/arch/cris/arch-v10/drivers/pcf8563.c	Sat Aug 16 15:02:35 2003
+++ linux/arch/cris/arch-v10/drivers/pcf8563.c	Wed Aug 20 16:40:22 2003
@@ -57,10 +57,10 @@
 int pcf8563_release(struct inode *, struct file *);
 
 static struct file_operations pcf8563_fops = {
-	owner: THIS_MODULE,
-	ioctl: pcf8563_ioctl,
-	open: pcf8563_open,
-	release: pcf8563_release,
+	.owner = THIS_MODULE,
+	.ioctl = pcf8563_ioctl,
+	.open = pcf8563_open,
+	.release = pcf8563_release,
 };
 
 unsigned char
