Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264593AbTFQFwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 01:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbTFQFwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 01:52:00 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:17593 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S264593AbTFQFv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 01:51:59 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  v850 whitespace tweaks
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030617060540.7E15C37E1@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 17 Jun 2003 15:05:40 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.72-moo/include/asm-v850/hardirq.h linux-2.5.72-moo-v850-20030617/include/asm-v850/hardirq.h
--- linux-2.5.72-moo/include/asm-v850/hardirq.h	2003-05-27 11:31:32.000000000 +0900
+++ linux-2.5.72-moo-v850-20030617/include/asm-v850/hardirq.h	2003-06-17 14:23:12.000000000 +0900
@@ -80,12 +80,12 @@
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
 
-#define irq_exit()							\
-do {									\
-		preempt_count() -= IRQ_EXIT_OFFSET;			\
-		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-			do_softirq();					\
-		preempt_enable_no_resched();				\
+#define irq_exit()							      \
+do {									      \
+	preempt_count() -= IRQ_EXIT_OFFSET;				      \
+	if (!in_interrupt() && softirq_pending(smp_processor_id()))	      \
+		do_softirq();						      \
+	preempt_enable_no_resched();					      \
 } while (0)
 
 #ifndef CONFIG_SMP
