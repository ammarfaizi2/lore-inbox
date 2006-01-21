Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWAUVll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWAUVll (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWAUVll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:41:41 -0500
Received: from admingilde.org ([213.95.32.146]:16358 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932368AbWAUVlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:41:40 -0500
Date: Sat, 21 Jan 2006 22:41:37 +0100
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DocBook: fix some kernel-doc comments in net/sunrpc
Message-ID: <20060121214137.GE30777@admingilde.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the syntax of some kernel-doc comments

Signed-off-by: Martin Waitz <tali@admingilde.org>

---

 net/sunrpc/sched.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

d0eff4080c346e7f81172c0bbe81f16c9ba2e85d
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 7415406..802d4fe 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -908,10 +908,10 @@ void rpc_release_task(struct rpc_task *t
 
 /**
  * rpc_run_task - Allocate a new RPC task, then run rpc_execute against it
- * @clnt - pointer to RPC client
- * @flags - RPC flags
- * @ops - RPC call ops
- * @data - user call data
+ * @clnt: pointer to RPC client
+ * @flags: RPC flags
+ * @ops: RPC call ops
+ * @data: user call data
  */
 struct rpc_task *rpc_run_task(struct rpc_clnt *clnt, int flags,
 					const struct rpc_call_ops *ops,
@@ -930,6 +930,7 @@ EXPORT_SYMBOL(rpc_run_task);
 /**
  * rpc_find_parent - find the parent of a child task.
  * @child: child task
+ * @parent: parent task
  *
  * Checks that the parent task is still sleeping on the
  * queue 'childq'. If so returns a pointer to the parent.
-- 
0.99.9.GIT

-- 
Martin Waitz
