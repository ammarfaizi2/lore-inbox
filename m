Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTHTIA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbTHTH7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 03:59:35 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:17357 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261764AbTHTH6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 03:58:47 -0400
Date: Wed, 20 Aug 2003 17:59:56 +1000
Message-Id: <200308200759.h7K7xuUW011632@theirongiant.lochness.weebeastie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/16] C99: 2.6.0-t3-bk7/arch/arm
Cc: Linus Torvalds <torvalds@osdl.org>
From: CaT <cat@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux.backup/arch/arm/kernel/apm.c linux/arch/arm/kernel/apm.c
--- linux.backup/arch/arm/kernel/apm.c	Thu Jun 26 23:44:05 2003
+++ linux/arch/arm/kernel/apm.c	Wed Aug 20 16:40:22 2003
@@ -388,18 +388,18 @@
 }
 
 static struct file_operations apm_bios_fops = {
-	owner:		THIS_MODULE,
-	read:		apm_read,
-	poll:		apm_poll,
-	ioctl:		apm_ioctl,
-	open:		apm_open,
-	release:	apm_release,
+	.owner		= THIS_MODULE,
+	.read		= apm_read,
+	.poll		= apm_poll,
+	.ioctl		= apm_ioctl,
+	.open		= apm_open,
+	.release	= apm_release,
 };
 
 static struct miscdevice apm_device = {
-	minor:		APM_MINOR_DEV,
-	name:		"apm_bios",
-	fops:		&apm_bios_fops
+	.minor		= APM_MINOR_DEV,
+	.name		= "apm_bios",
+	.fops		= &apm_bios_fops
 };
 
 
