Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbULZNxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbULZNxD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 08:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbULZNxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 08:53:02 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:31458 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261653AbULZNwq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 08:52:46 -0500
From: James Nelson <james4765@verizon.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, marcelo.tosatti@cyclades.com,
       James Nelson <james4765@verizon.net>
Message-Id: <20041226135306.11762.53625.55036@localhost.localdomain>
Subject: [PATCH] cyclades: Put README.cycladeZ in Documentation/serial
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.220.243] at Sun, 26 Dec 2004 07:52:45 -0600
Date: Sun, 26 Dec 2004 07:52:46 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Put README.cycladesZ in Documentation/serial.

Firmware is still needed, but the README file shouldn't be in drivers/char.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-original/Documentation/README.cycladesZ linux-2.6.10/Documentation/README.cycladesZ
--- linux-2.6.10-original/Documentation/README.cycladesZ	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10/Documentation/README.cycladesZ	2004-12-24 16:34:58.000000000 -0500
@@ -0,0 +1,8 @@
+
+The Cyclades-Z must have firmware loaded onto the card before it will
+operate.  This operation should be performed during system startup,
+
+The firmware, loader program and the latest device driver code are
+available from Cyclades at
+    ftp://ftp.cyclades.com/pub/cyclades/cyclades-z/linux/
+
diff -urN --exclude='*~' linux-2.6.10-original/drivers/char/README.cycladesZ linux-2.6.10/drivers/char/README.cycladesZ
--- linux-2.6.10-original/drivers/char/README.cycladesZ	2004-12-24 16:34:58.000000000 -0500
+++ linux-2.6.10/drivers/char/README.cycladesZ	1969-12-31 19:00:00.000000000 -0500
@@ -1,8 +0,0 @@
-
-The Cyclades-Z must have firmware loaded onto the card before it will
-operate.  This operation should be performed during system startup,
-
-The firmware, loader program and the latest device driver code are
-available from Cyclades at
-    ftp://ftp.cyclades.com/pub/cyclades/cyclades-z/linux/
-
