Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752132AbWJ1LgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbWJ1LgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 07:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbWJ1LgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 07:36:25 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:8681 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1752132AbWJ1LgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 07:36:24 -0400
X-Originating-Ip: 72.57.81.197
Date: Sat, 28 Oct 2006 07:33:45 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] sched.c: update inappropriate comment for this_rq_lock()
Message-ID: <Pine.LNX.4.64.0610280731440.31032@localhost.localdomain>
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


  Correct the misspelling and explanation in the comment for
this_rq_lock().

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
