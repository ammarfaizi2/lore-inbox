Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbULZOts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbULZOts (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 09:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbULZOts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 09:49:48 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:35020 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S261661AbULZOtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 09:49:46 -0500
From: James Nelson <james4765@verizon.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, roms@lievin.net, James Nelson <james4765@verizon.net>
Message-Id: <20041226145007.15694.53257.33859@localhost.localdomain>
Subject: [PATCH] tipar: Document driver options
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.220.243] at Sun, 26 Dec 2004 08:49:46 -0600
Date: Sun, 26 Dec 2004 08:49:46 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document kernel parameters for tipar driver.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-original/Documentation/kernel-parameters.txt linux-2.6.10/Documentation/kernel-parameters.txt
--- linux-2.6.10-original/Documentation/kernel-parameters.txt	2004-12-24 16:35:50.000000000 -0500
+++ linux-2.6.10/Documentation/kernel-parameters.txt	2004-12-26 09:06:00.024093651 -0500
@@ -1319,8 +1319,12 @@
 	thash_entries=	[KNL,NET]
 			Set number of hash buckets for TCP connection
 
-	tipar=		[HW]
-			See header of drivers/char/tipar.c.
+	tipar.timeout=	[HW,PPT]
+			Set communications timeout in tenths of a second
+			(default 15).
+
+	tipar.delay=	[HW,PPT]
+			Set inter-bit delay in microseconds (default 10).
 
 	tiusb=		[HW,USB] Texas Instruments' USB GraphLink (aka SilverLink)
 			Format: <timeout>
