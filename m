Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319086AbSIJJWS>; Tue, 10 Sep 2002 05:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319080AbSIJJWR>; Tue, 10 Sep 2002 05:22:17 -0400
Received: from dp.samba.org ([66.70.73.150]:40667 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319086AbSIJJWB>;
	Tue, 10 Sep 2002 05:22:01 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Comment fix asm-i386_hardirq.h
Date: Tue, 10 Sep 2002 19:26:13 +1000
Message-Id: <20020910092648.628692C361@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ The best bit about this is how every arch copied the comment 8) ]
From:  Skip Ford <skip.ford@verizon.net>


--- trivial-2.5.34/include/asm-i386/hardirq.h.orig	2002-09-10 19:11:13.000000000 +1000
+++ trivial-2.5.34/include/asm-i386/hardirq.h	2002-09-10 19:11:13.000000000 +1000
@@ -27,8 +27,8 @@
  * - ( bit 26 is the PREEMPT_ACTIVE flag. )
  *
  * PREEMPT_MASK: 0x000000ff
- * HARDIRQ_MASK: 0x0000ff00
- * SOFTIRQ_MASK: 0x00ff0000
+ * SOFTIRQ_MASK: 0x0000ff00
+ * HARDIRQ_MASK: 0x00ff0000
  */
 
 #define PREEMPT_BITS	8
-- 
  Don't blame me: the Monkey is driving
  File: Skip Ford <skip.ford@verizon.net>: Comment fix asm-i386_hardirq.h
