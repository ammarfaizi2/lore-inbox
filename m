Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbUKDXX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbUKDXX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbUKDXUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:20:41 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:31116 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262466AbUKDXTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:19:04 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041104231903.4434.36881.91354@localhost.localdomain>
Subject: [PATCH] ramdisk: Correction to Documentation/kernel-parameters.txt
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [68.238.31.6] at Thu, 4 Nov 2004 17:19:03 -0600
Date: Thu, 4 Nov 2004 17:19:04 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove deleted module option in Documentation/kernel-parameters.txt

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/Documentation/kernel-parameters.txt linux-2.6.9/Documentation/kernel-parameters.txt
--- linux-2.6.9-original/Documentation/kernel-parameters.txt	2004-10-18 17:55:36.000000000 -0400
+++ linux-2.6.9/Documentation/kernel-parameters.txt	2004-11-04 18:09:49.507580831 -0500
@@ -1001,10 +1001,6 @@
 			New name for the ramdisk parameter.
 			See Documentation/ramdisk.txt.
 
-	ramdisk_start=	[RAM] Starting block of RAM disk image (so you can
-			place it after the kernel image on a boot floppy).
-			See Documentation/ramdisk.txt.
-
 	reboot=		[BUGS=IA-32,BUGS=ARM,BUGS=IA-64] Rebooting mode
 			Format: <reboot_mode>[,<reboot_mode2>[,...]]
 			See arch/*/kernel/reboot.c.
