Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVCPUBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVCPUBz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 15:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbVCPUBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 15:01:55 -0500
Received: from mail.dif.dk ([193.138.115.101]:32477 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261419AbVCPUBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 15:01:53 -0500
Date: Wed, 16 Mar 2005 21:03:23 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-atm-general@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] Spelling fix in net/Kconfig
Message-ID: <Pine.LNX.4.62.0503162100490.2558@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(please CC me on replies from linux-atm-general as I'm not subscribed to that list)

Trivial spelling fix patch for net/Kconfig

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.11-mm4-orig/net/Kconfig linux-2.6.11-mm4/net/Kconfig
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
 


