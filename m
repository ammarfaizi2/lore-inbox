Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVFSSss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVFSSss (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 14:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVFSSss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 14:48:48 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:61865 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S261280AbVFSSsq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 14:48:46 -0400
Date: Sun, 19 Jun 2005 20:48:39 +0200
From: Lennert Buytenhek <buytenh+lkml@wantstofly.org>
To: linux-kernel@vger.kernel.org
Cc: dsaxena@plexity.net
Subject: [PATCH] ixp4xx/ixp2000 watchdog driver typo
Message-ID: <20050619184838.GA26072@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the same typo in the ixp4xx and ixp2000 watchdog drivers.

Signed-off-by: Lennert Buytenhek <buytenh+lkml@wantstofly.org>

diff -urN linux-2.6.12.orig/drivers/char/watchdog/ixp4xx_wdt.c linux-2.6.12/drivers/char/watchdog/ixp4xx_wdt.c
--- linux-2.6.12.orig/drivers/char/watchdog/ixp4xx_wdt.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/drivers/char/watchdog/ixp4xx_wdt.c	2005-06-19 20:40:15.796402087 +0200
@@ -156,7 +156,7 @@
 	if (test_bit(WDT_OK_TO_CLOSE, &wdt_status)) {
 		wdt_disable();
 	} else {
-		printk(KERN_CRIT "WATCHDOG: Device closed unexpectdly - "
+		printk(KERN_CRIT "WATCHDOG: Device closed unexpectedly - "
 					"timer will not stop\n");
 	}
 
diff -urN linux-2.6.12.orig/drivers/char/watchdog/ixp2000_wdt.c linux-2.6.12/drivers/char/watchdog/ixp2000_wdt.c
--- linux-2.6.12.orig/drivers/char/watchdog/ixp2000_wdt.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/drivers/char/watchdog/ixp2000_wdt.c	2005-06-19 20:40:22.176765156 +0200
@@ -162,7 +162,7 @@
 	if (test_bit(WDT_OK_TO_CLOSE, &wdt_status)) {
 		wdt_disable();
 	} else {
-		printk(KERN_CRIT "WATCHDOG: Device closed unexpectdly - "
+		printk(KERN_CRIT "WATCHDOG: Device closed unexpectedly - "
 					"timer will not stop\n");
 	}
 
