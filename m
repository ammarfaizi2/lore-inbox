Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422654AbWJ3VFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWJ3VFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 16:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbWJ3VFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 16:05:18 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:15787 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1422654AbWJ3VFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 16:05:16 -0500
X-Originating-Ip: 72.57.81.197
Date: Mon, 30 Oct 2006 16:02:40 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] sched.c : correct comment for this_rq_lock() routine
Message-ID: <Pine.LNX.4.64.0610301600550.12811@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correct the comment for the this_rq_lock() routine.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
---
diff --git a/kernel/sched.c b/kernel/sched.c
index 3399701..94f124e 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -547,7 +547,7 @@ # define schedstat_add(rq, field, amt)	d
 #endif

 /*
- * rq_lock - lock a given runqueue and disable interrupts.
+ * this_rq_lock - lock this runqueue and disable interrupts.
  */
 static inline struct rq *this_rq_lock(void)
 	__acquires(rq->lock)
