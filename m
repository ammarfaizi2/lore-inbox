Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312411AbSCURV5>; Thu, 21 Mar 2002 12:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312414AbSCURVm>; Thu, 21 Mar 2002 12:21:42 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:7811 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S312403AbSCURVU>; Thu, 21 Mar 2002 12:21:20 -0500
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
cc: linux-alpha@vger.kernel.org
Subject: [PATCH] Needed to get 2.5.7 to compile and link on Alpha [6/10]
Message-Id: <E16o6CB-0005OE-00@lightning.hereintown.net>
Date: Thu, 21 Mar 2002 12:17:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow, another one liner, should have been updated with the i386 header.

-Chris


--- linux-2.5.7/include/asm-alpha/siginfo.h~	Wed Mar 20 05:07:16 2002
+++ linux-2.5.7/include/asm-alpha/siginfo.h	Wed Mar 20 08:10:44 2002
@@ -108,6 +108,7 @@
 #define SI_ASYNCIO	-4		/* sent by AIO completion */
 #define SI_SIGIO	-5		/* sent by queued SIGIO */
 #define SI_TKILL	-6		/* sent by tkill system call */
+#define SI_DETHREAD	-7		/* sent by execve() killing subsidiary threads */
 
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
