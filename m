Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWDMVxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWDMVxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 17:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWDMVxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 17:53:08 -0400
Received: from smtp-2.llnl.gov ([128.115.3.82]:34262 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S964988AbWDMVxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 17:53:07 -0400
From: Dave Peterson <dsp@llnl.gov>
To: linux-mm@kvack.org
Subject: [PATCH 1/2] mm: fix typos in comments in mm/oom_kill.c
Date: Thu, 13 Apr 2006 14:52:06 -0700
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, riel@surriel.com, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604131452.06722.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a few typos in the comments in mm/oom_kill.c.

Signed-Off-By: David S. Peterson <dsp@llnl.gov>
---

Index: linux-2.6.17-rc1-oom/mm/oom_kill.c
===================================================================
--- linux-2.6.17-rc1-oom.orig/mm/oom_kill.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.17-rc1-oom/mm/oom_kill.c	2006-04-13 14:25:16.000000000 -0700
@@ -25,7 +25,7 @@
 /* #define DEBUG */
 
 /**
- * oom_badness - calculate a numeric value for how bad this task has been
+ * badness - calculate a numeric value for how bad this task has been
  * @p: task struct of which task we should calculate
  * @uptime: current uptime in seconds
  *
@@ -190,7 +190,7 @@ static struct task_struct *select_bad_pr
 			continue;
 
 		/*
-		 * This is in the process of releasing memory so for wait it
+		 * This is in the process of releasing memory so wait for it
 		 * to finish before killing some other task by mistake.
 		 */
 		releasing = test_tsk_thread_flag(p, TIF_MEMDIE) ||
@@ -291,7 +291,7 @@ static struct mm_struct *oom_kill_proces
 }
 
 /**
- * oom_kill - kill the "best" process when we run out of memory
+ * out_of_memory - kill the "best" process when we run out of memory
  *
  * If we run out of memory, we have the choice between either
  * killing a random task (bad), letting the system crash (worse)
