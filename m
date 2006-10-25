Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422840AbWJYB1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422840AbWJYB1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 21:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422819AbWJYB1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 21:27:22 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:22453 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1422765AbWJYB1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 21:27:22 -0400
X-Originating-Ip: 72.57.81.197
Date: Tue, 24 Oct 2006 21:25:30 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] sched.c: correct typoes in this_rq_lock() comment.
Message-ID: <Pine.LNX.4.64.0610242122500.28083@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correct the comment preceding this_rq_lock() so that it matches the
actual function name and purpose.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
---
diff --git a/kernel/sched.c b/kernel/sched.c
index 3399701..8f3bdc3 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -547,7 +547,7 @@ # define schedstat_add(rq, field, amt)	d
 #endif

 /*
- * rq_lock - lock a given runqueue and disable interrupts.
+ * this_rq_lock - lock the current runqueue and disable interrupts.
  */
 static inline struct rq *this_rq_lock(void)
 	__acquires(rq->lock)
