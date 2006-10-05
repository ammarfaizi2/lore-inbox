Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751658AbWJEKsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbWJEKsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 06:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWJEKsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 06:48:12 -0400
Received: from server6.greatnet.de ([83.133.96.26]:3040 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1751657AbWJEKsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 06:48:10 -0400
Message-ID: <4524E310.9020602@nachtwindheim.de>
Date: Thu, 05 Oct 2006 12:48:48 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched: fix a kerneldoc error on is_init()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a kerneldoc warning and reorderd the description for is_init().
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

 sched.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 331f450..6735c1c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1065,9 +1065,10 @@ static inline int pid_alive(struct task_
 }
 
 /**
- * is_init - check if a task structure is the first user space
- *	     task the kernel created.
- * @p: Task structure to be checked.
+ * is_init - check if a task structure is init
+ * @tsk: Task structure to be checked.
+ *
+ * Check if a task structure is the first user space task the kernel created.
  */
 static inline int is_init(struct task_struct *tsk)
 {


