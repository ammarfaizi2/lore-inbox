Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbUL2Kr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbUL2Kr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 05:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbUL2Kr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 05:47:27 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:28610 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S261445AbUL2KrX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 05:47:23 -0500
From: James Nelson <james4765@verizon.net>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, marcelo.tosatti@cyclades.com,
       James Nelson <james4765@verizon.net>
Message-Id: <20041229104743.24177.82288.68966@localhost.localdomain>
Subject: [PATCH] cyclades: Put README.cycladeZ in Documentation/serial
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.220.243] at Wed, 29 Dec 2004 04:47:22 -0600
Date: Wed, 29 Dec 2004 04:47:22 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Put README.cycladesZ in Documentation/serial.

Firmware is still needed, but the README file shouldn't be in drivers/char.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-original/Documentation/serial/README.cycladesZ linux-2.6.10/Documentation/serial/README.cycladesZ
--- linux-2.6.10-original/Documentation/serial/README.cycladesZ	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10/Documentation/serial/README.cycladesZ	2004-12-24 16:34:58.000000000 -0500
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
