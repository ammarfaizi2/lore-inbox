Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275900AbSIULRm>; Sat, 21 Sep 2002 07:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275901AbSIULRm>; Sat, 21 Sep 2002 07:17:42 -0400
Received: from adambe1.lnk.telstra.net ([139.130.12.177]:15307 "HELO unibar")
	by vger.kernel.org with SMTP id <S275900AbSIULRm>;
	Sat, 21 Sep 2002 07:17:42 -0400
Message-ID: <20020921112245.27021.qmail@unibar>
From: adam@skullslayer.rod.org
Subject: [PATCH] __KERNEL__ pasting in drivers/net/wan/cycx_x25.c
To: linux-kernel@vger.kernel.org
Date: Sat, 21 Sep 2002 21:22:45 +1000 (EST)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the __FUNCTION__ pasting to the new
standard.

    Adam


--- drivers/net/wan/cycx_x25.c.orig	Sat Sep 21 21:07:25 2002
+++ drivers/net/wan/cycx_x25.c	Sat Sep 21 21:08:28 2002
@@ -1446,7 +1446,7 @@
         unsigned char *ptr;
 
         if ((skb = dev_alloc_skb(1)) == NULL) {
-                printk(KERN_ERR __FUNCTION__ ": out of memory\n");
+                printk(KERN_ERR "%s: out of memory\n", __FUNCTION__);
                 return;
         }
 
