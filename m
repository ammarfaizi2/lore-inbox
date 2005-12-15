Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422648AbVLOJVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbVLOJVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422659AbVLOJTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:19:03 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:16042 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422648AbVLOJSZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:18:25 -0500
To: torvalds@osdl.org
Subject: [PATCH] missing prototype (mm/page_alloc.c)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpFp-000800-27@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:18:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 mm/page_alloc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

8b2c4d06d0fb4b1278a457c3d275745b921f8c82
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3b21a13..fe14a8c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1896,7 +1896,7 @@ static int __devinit pageset_cpuup_callb
 static struct notifier_block pageset_notifier =
 	{ &pageset_cpuup_callback, NULL, 0 };
 
-void __init setup_per_cpu_pageset()
+void __init setup_per_cpu_pageset(void)
 {
 	int err;
 
-- 
0.99.9.GIT

