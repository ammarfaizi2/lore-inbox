Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312408AbSCURV4>; Thu, 21 Mar 2002 12:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312411AbSCURVj>; Thu, 21 Mar 2002 12:21:39 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:6531 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S312400AbSCURVU>; Thu, 21 Mar 2002 12:21:20 -0500
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
cc: linux-alpha@vger.kernel.org
Subject: [PATCH] Needed to get 2.5.7 to compile and link on Alpha [2/10]
Message-Id: <E16o6CB-0005O1-00@lightning.hereintown.net>
Date: Thu, 21 Mar 2002 12:17:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple one liner that is Obviously correct.  Should have been done by 
whom ever updated the i386 arch.

-Chris


--- linux-2.5.7/include/asm-alpha/mman.h~	Mon Mar 18 15:37:03 2002
+++ linux-2.5.7/include/asm-alpha/mman.h	Wed Mar 20 08:04:42 2002
@@ -4,6 +4,7 @@
 #define PROT_READ	0x1		/* page can be read */
 #define PROT_WRITE	0x2		/* page can be written */
 #define PROT_EXEC	0x4		/* page can be executed */
+#define PROT_SEM	0x8		/* page may be used for atomic ops */
 #define PROT_NONE	0x0		/* page can not be accessed */
 
 #define MAP_SHARED	0x01		/* Share changes */
