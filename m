Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263258AbUJ2Acx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbUJ2Acx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbUJ2Aab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:30:31 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55046 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263246AbUJ2A0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:26:10 -0400
Date: Fri, 29 Oct 2004 02:25:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sched.c: remove an unused function
Message-ID: <20041029002538.GX29142@stusta.de>
References: <20041028231445.GE3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028231445.GE3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from kernel/sched.c


diffstat output:
 kernel/sched.c |    5 -----
 1 files changed, 5 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/kernel/sched.c.old	2004-10-28 22:33:14.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/kernel/sched.c	2004-10-28 22:34:47.000000000 +0200
@@ -438,11 +438,6 @@
 	return rq;
 }
 
-static inline void rq_unlock(runqueue_t *rq)
-{
-	spin_unlock_irq(&rq->lock);
-}
-
 #ifdef CONFIG_SCHEDSTATS
 /*
  * Called when a process is dequeued from the active array and given
