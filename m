Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWAXWeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWAXWeL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 17:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWAXWeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 17:34:11 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:64658 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750793AbWAXWeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 17:34:09 -0500
Message-Id: <200601242326.k0ONQ2JM008908@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/2] UML - Fix some typos
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Jan 2006 18:26:02 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a couple of typos.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/drivers/mcast_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/drivers/mcast_kern.c	2006-01-24 17:04:22.000000000 -0500
+++ linux-2.6.15-mm/arch/um/drivers/mcast_kern.c	2006-01-24 17:05:38.000000000 -0500
@@ -40,7 +40,7 @@ static void mcast_init(struct net_device
 	dpri->dev = dev;
 
 	printk("mcast backend ");
-	printk("multicast adddress: %s:%u, TTL:%u ",
+	printk("multicast address: %s:%u, TTL:%u ",
 	       dpri->addr, dpri->port, dpri->ttl);
 
 	printk("\n");
Index: linux-2.6.15-mm/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/drivers/mconsole_kern.c	2006-01-24 17:04:31.000000000 -0500
+++ linux-2.6.15-mm/arch/um/drivers/mconsole_kern.c	2006-01-24 17:05:38.000000000 -0500
@@ -273,7 +273,7 @@ void mconsole_proc(struct mc_request *re
     config <dev> - Query the configuration of a device \n\
     remove <dev> - Remove a device from UML \n\
     sysrq <letter> - Performs the SysRq action controlled by the letter \n\
-    cad - invoke the Ctl-Alt-Del handler \n\
+    cad - invoke the Ctrl-Alt-Del handler \n\
     stop - pause the UML; it will do nothing until it receives a 'go' \n\
     go - continue the UML after a 'stop' \n\
     log <string> - make UML enter <string> into the kernel log\n\

