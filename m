Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbUKCRyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbUKCRyj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 12:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbUKCRyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 12:54:38 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:56473 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S261746AbUKCRyT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 12:54:19 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, marcelo.tosatti@cyclades.com, james4765@verizon.net
Message-Id: <20041103175418.25125.77516.28696@localhost.localdomain>
Subject: [PATCH] cyclades: Put README.cycladeZ in Documentation/serial
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [68.238.31.6] at Wed, 3 Nov 2004 11:54:18 -0600
Date: Wed, 3 Nov 2004 11:54:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Put README.cycladesZ in Documentation/serial.

Firmware is still needed, but the README file shouldn't be in drivers/char.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/Documentation/README.cycladesZ linux-2.6.9/Documentation/README.cycladesZ
--- linux-2.6.9-original/Documentation/serial/README.cycladesZ	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.9/Documentation/serial/README.cycladesZ	2004-11-03 12:41:31.577414742 -0500
@@ -0,0 +1,8 @@
+
+The Cyclades-Z must have firmware loaded onto the card before it will
+operate.  This operation should be performed during system startup,
+
+The firmware, loader program and the latest device driver code are
+available from Cyclades at
+    ftp://ftp.cyclades.com/pub/cyclades/cyclades-z/linux/
+
