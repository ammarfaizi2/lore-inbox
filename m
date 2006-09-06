Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWIFQCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWIFQCV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWIFQCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:02:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17563 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751257AbWIFQCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:02:20 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Linux Containers <containers@lists.osdl.org>
Subject: [PATCH] FIX: whitespace damage in namespaces-incorporate-fs-namespace-into-nsproxy
Date: Wed, 06 Sep 2006 10:01:37 -0600
Message-ID: <m1wt8hx9um.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


---
 fs/proc/base.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 45b70fd..4096518 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -545,7 +545,7 @@ static int mountstats_open(struct inode 
 
 		if (task) {
 			task_lock(task);
-	namespace = task->nsproxy->namespace;
+			namespace = task->nsproxy->namespace;
 			if (namespace)
 				get_namespace(namespace);
 			task_unlock(task);
-- 
1.4.2.rc3.g7e18e-dirty

