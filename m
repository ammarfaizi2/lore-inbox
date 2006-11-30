Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966312AbWK3MaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966312AbWK3MaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936350AbWK3MVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:21:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18061 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936340AbWK3MVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:21:01 -0500
Subject: [GFS2] Remove unused sysfs files [49/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:21:05 +0000
Message-Id: <1164889265.3752.403.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 175011cf6edddea32e5f5e0e04434104cc348de9 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Thu, 16 Nov 2006 10:58:55 -0500
Subject: [PATCH] [GFS2] Remove unused sysfs files

Four of the sysfs files are unused and can therefore be removed.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/sys.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 0e0ec98..983eaf1 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -426,9 +426,6 @@ static ssize_t name##_store(struct gfs2_
 }                                                                             \
 TUNE_ATTR_2(name, name##_store)
 
-TUNE_ATTR(ilimit, 0);
-TUNE_ATTR(ilimit_tries, 0);
-TUNE_ATTR(ilimit_min, 0);
 TUNE_ATTR(demote_secs, 0);
 TUNE_ATTR(incore_log_blocks, 0);
 TUNE_ATTR(log_flush_secs, 0);
@@ -447,7 +444,6 @@ TUNE_ATTR(quota_simul_sync, 1);
 TUNE_ATTR(quota_cache_secs, 1);
 TUNE_ATTR(max_atomic_write, 1);
 TUNE_ATTR(stall_secs, 1);
-TUNE_ATTR(entries_per_readdir, 1);
 TUNE_ATTR(greedy_default, 1);
 TUNE_ATTR(greedy_quantum, 1);
 TUNE_ATTR(greedy_max, 1);
@@ -459,9 +455,6 @@ TUNE_ATTR_DAEMON(quotad_secs, quotad_pro
 TUNE_ATTR_3(quota_scale, quota_scale_show, quota_scale_store);
 
 static struct attribute *tune_attrs[] = {
-	&tune_attr_ilimit.attr,
-	&tune_attr_ilimit_tries.attr,
-	&tune_attr_ilimit_min.attr,
 	&tune_attr_demote_secs.attr,
 	&tune_attr_incore_log_blocks.attr,
 	&tune_attr_log_flush_secs.attr,
@@ -478,7 +471,6 @@ static struct attribute *tune_attrs[] = 
 	&tune_attr_quota_cache_secs.attr,
 	&tune_attr_max_atomic_write.attr,
 	&tune_attr_stall_secs.attr,
-	&tune_attr_entries_per_readdir.attr,
 	&tune_attr_greedy_default.attr,
 	&tune_attr_greedy_quantum.attr,
 	&tune_attr_greedy_max.attr,
-- 
1.4.1



