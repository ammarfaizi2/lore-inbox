Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266085AbUHFDWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUHFDWk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 23:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUHFDWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 23:22:40 -0400
Received: from [12.177.129.25] ([12.177.129.25]:16580 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S266085AbUHFDWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 23:22:39 -0400
Message-Id: <200408060421.i764LtCi005625@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Matt Mackall <mpm@selenic.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.8-rc3-mm1 - Fix missing backslash in asm-generic/bug.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Aug 2004 00:21:55 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: 2.6.8-rc3-mm1/include/asm-generic/bug.h
===================================================================
--- 2.6.8-rc3-mm1.orig/include/asm-generic/bug.h	2004-08-05 23:07:01.000000000 -0400
+++ 2.6.8-rc3-mm1/include/asm-generic/bug.h	2004-08-05 23:15:11.000000000 -0400
@@ -7,7 +7,7 @@
 #ifndef HAVE_ARCH_BUG
 #define BUG() do { \
 	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-	panic("BUG!");
+	panic("BUG!"); \
 } while (0)
 #endif
 


