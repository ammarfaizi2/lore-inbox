Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVGITEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVGITEX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 15:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVGITEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 15:04:23 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34317 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261695AbVGITEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 15:04:21 -0400
Date: Sat, 9 Jul 2005 21:04:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: chas@cmf.nrl.navy.mil, linux-atm-general@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       Jesper Juhl <juhl-lkml@dif.dk>
Subject: [2.6 patch] net/Kconfig: two ATM-related spelling fixes
Message-ID: <20050709190417.GJ28243@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial spelling fix patch for net/Kconfig

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Jesper Juhl on:
- 16 Mar 2005

--- linux-2.6.11-mm4-orig/net/Kconfig	2005-03-16 15:45:41.000000000 +0100
+++ linux-2.6.11-mm4/net/Kconfig	2005-03-16 20:54:23.000000000 +0100
@@ -281,7 +281,7 @@
 	tristate "RFC1483/2684 Bridged protocols"
 	depends on ATM && INET
 	help
-	  ATM PVCs can carry ethernet PDUs according to rfc2684 (formerly 1483)
+	  ATM PVCs can carry ethernet PDUs according to RFC2684 (formerly 1483)
 	  This device will act like an ethernet from the kernels point of view,
 	  with the traffic being carried by ATM PVCs (currently 1 PVC/device).
 	  This is sometimes used over DSL lines.  If in doubt, say N.
@@ -290,7 +290,7 @@
 	bool "Per-VC IP filter kludge"
 	depends on ATM_BR2684
 	help
-	  This is an experimental mechanism for users who need to terminating a
+	  This is an experimental mechanism for users who need to terminate a
 	  large number of IP-only vcc's.  Do not enable this unless you are sure
 	  you know what you are doing.
 


