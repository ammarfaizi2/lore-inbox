Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264338AbTCXQtG>; Mon, 24 Mar 2003 11:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264280AbTCXQay>; Mon, 24 Mar 2003 11:30:54 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:29674 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264261AbTCXQar>; Mon, 24 Mar 2003 11:30:47 -0500
Message-Id: <200303241641.h2OGfu35008192@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:43 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Update K6 bug URL.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/amd.c linux-2.5/arch/i386/kernel/cpu/amd.c
--- bk-linus/arch/i386/kernel/cpu/amd.c	2003-03-08 09:56:26.000000000 +0000
+++ linux-2.5/arch/i386/kernel/cpu/amd.c	2003-03-22 12:49:09.000000000 +0000
@@ -90,14 +90,13 @@ static void __init init_amd(struct cpuin
 				d = d2-d;
 				
 				/* Knock these two lines out if it debugs out ok */
-				printk(KERN_INFO "K6 BUG %ld %d (Report these if test report is incorrect)\n", d, 20*K6_BUG_LOOP);
 				printk(KERN_INFO "AMD K6 stepping B detected - ");
 				/* -- cut here -- */
 				if (d > 20*K6_BUG_LOOP) 
 					printk("system stability may be impaired when more than 32 MB are used.\n");
 				else 
 					printk("probably OK (after B9730xxxx).\n");
-				printk(KERN_INFO "Please see http://www.mygale.com/~poulot/k6bug.html\n");
+				printk(KERN_INFO "Please see http://membres.lycos.fr/poulot/k6bug.html\n");
 			}
 
 			/* K6 with old style WHCR */
