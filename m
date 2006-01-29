Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWA2GY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWA2GY6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 01:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWA2GY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 01:24:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24286 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750840AbWA2GY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 01:24:57 -0500
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove dead kill_sl prototype from sched.h
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 28 Jan 2006 23:24:30 -0700
Message-ID: <m1vew3ft5t.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The kill_sl function doesn't exist in the kernel so
a prototype is completely unnecessary.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 include/linux/sched.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

f4fc066bbc4a2b89ac621a50d9da097c59d840bf
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0cfcd1c..8645ae1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1092,7 +1092,6 @@ extern void force_sig_specific(int, stru
 extern int send_sig(int, struct task_struct *, int);
 extern void zap_other_threads(struct task_struct *p);
 extern int kill_pg(pid_t, int, int);
-extern int kill_sl(pid_t, int, int);
 extern int kill_proc(pid_t, int, int);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
-- 
1.1.5.g3480

