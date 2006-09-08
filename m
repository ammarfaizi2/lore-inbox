Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWIHW4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWIHW4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWIHWzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:55:32 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:20107 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751245AbWIHWzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:55:24 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-Id: <20060908225524.9340.12010.sendpatchset@kaori.pdx.zabbo.net>
In-Reply-To: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
References: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
Subject: [PATCH 9/10] trident: use size_t length modifier in pr_debug format arguments
Date: Fri,  8 Sep 2006 15:55:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trident: use size_t length modifier in pr_debug format arguments

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 sound/oss/trident.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6.18-rc6-debug-args/sound/oss/trident.c
===================================================================
--- 2.6.18-rc6-debug-args.orig/sound/oss/trident.c
+++ 2.6.18-rc6-debug-args/sound/oss/trident.c
@@ -1873,7 +1873,7 @@ trident_read(struct file *file, char __u
 	unsigned swptr;
 	int cnt;
 
-	pr_debug("trident: trident_read called, count = %d\n", count);
+	pr_debug("trident: trident_read called, count = %zd\n", count);
 
 	VALIDATE_STATE(state);
 
@@ -1989,7 +1989,7 @@ trident_write(struct file *file, const c
 	unsigned int copy_count;
 	int lret; /* for lock_set_fmt */
 
-	pr_debug("trident: trident_write called, count = %d\n", count);
+	pr_debug("trident: trident_write called, count = %zd\n", count);
 
 	VALIDATE_STATE(state);
 
