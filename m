Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbVHYFZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVHYFZX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVHYFZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:25:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5324 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964814AbVHYFVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:21:51 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (15/22) Kconfig fix (82596)
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8AES-0005dY-Ia@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:24:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

driver is non-modular

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-oktagon/drivers/net/Kconfig RC13-rc7-82596/drivers/net/Kconfig
--- RC13-rc7-oktagon/drivers/net/Kconfig	2005-08-24 01:58:29.000000000 -0400
+++ RC13-rc7-82596/drivers/net/Kconfig	2005-08-25 00:54:15.000000000 -0400
@@ -395,7 +395,7 @@
 	  If you're not building a kernel for a Sun 3, say N.
 
 config SUN3_82586
-	tristate "Sun3 on-board Intel 82586 support"
+	bool "Sun3 on-board Intel 82586 support"
 	depends on NET_ETHERNET && SUN3
 	help
 	  This driver enables support for the on-board Intel 82586 based
