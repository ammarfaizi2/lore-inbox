Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbUKNUvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbUKNUvq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 15:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbUKNUu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 15:50:57 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:11268
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261368AbUKNUus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 15:50:48 -0500
Message-Id: <200411142304.iAEN4CbV013361@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] - UML - Remove unused declaration
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Nov 2004 18:04:12 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unused declaration of time_stamp().

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/include/kern_util.h
===================================================================
--- 2.6.9.orig/arch/um/include/kern_util.h	2004-11-14 15:31:25.000000000 -0500
+++ 2.6.9/arch/um/include/kern_util.h	2004-11-14 15:31:36.000000000 -0500
@@ -110,7 +110,6 @@
 extern void free_irq(unsigned int, void *);
 extern int um_in_interrupt(void);
 extern int cpu(void);
-extern unsigned long long time_stamp(void);
 
 #endif
 

