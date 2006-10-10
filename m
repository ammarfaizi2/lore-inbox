Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbWJJVsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbWJJVsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030528AbWJJVsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:48:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32699 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030515AbWJJVs2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:48:28 -0400
To: torvalds@osdl.org
Subject: [PATCH] __user annotations: loop.c
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPSd-0007QK-E1@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:48:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/block/loop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 19a09a1..beab6d2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1187,7 +1187,7 @@ struct compat_loop_info {
  * - noinlined to reduce stack space usage in main part of driver
  */
 static noinline int
-loop_info64_from_compat(const struct compat_loop_info *arg,
+loop_info64_from_compat(const struct compat_loop_info __user *arg,
 			struct loop_info64 *info64)
 {
 	struct compat_loop_info info;
-- 
1.4.2.GIT


