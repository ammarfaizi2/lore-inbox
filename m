Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTHTICI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbTHTIAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:00:42 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:28621 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261775AbTHTIAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:00:17 -0400
Date: Wed, 20 Aug 2003 18:01:26 +1000
Message-Id: <200308200801.h7K81QQP011681@theirongiant.lochness.weebeastie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 6/16] C99: 2.6.0-t3-bk7/arch/h8300
Cc: Linus Torvalds <torvalds@osdl.org>
From: CaT <cat@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux.backup/arch/h8300/kernel/setup.c linux/arch/h8300/kernel/setup.c
--- linux.backup/arch/h8300/kernel/setup.c	Sat Aug 16 15:02:35 2003
+++ linux/arch/h8300/kernel/setup.c	Wed Aug 20 16:40:22 2003
@@ -91,12 +91,12 @@
 }
 
 static const struct console gdb_console = {
-	name:		"gdb_con",
-	write:		gdb_console_output,
-	device:		NULL,
-	setup:		gdb_console_setup,
-	flags:		CON_PRINTBUFFER,
-	index:		-1,
+	.name		= "gdb_con",
+	.write		= gdb_console_output,
+	.device		= NULL,
+	.setup		= gdb_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
 };
 #endif
 
@@ -260,8 +260,8 @@
 }
 
 struct seq_operations cpuinfo_op = {
-	start:	c_start,
-	next:	c_next,
-	stop:	c_stop,
-	show:	show_cpuinfo,
+	.start	= c_start,
+	.next	= c_next,
+	.stop	= c_stop,
+	.show	= show_cpuinfo,
 };
