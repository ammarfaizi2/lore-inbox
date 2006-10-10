Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030576AbWJJWAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030576AbWJJWAW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbWJJVoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:44:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:30148 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030486AbWJJVoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:44:37 -0400
To: torvalds@osdl.org
Subject: [PATCH] dccp __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPOv-0007Jf-3p@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:44:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/dccp.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/dccp.h b/include/linux/dccp.h
index d6f4ec4..53553c9 100644
--- a/include/linux/dccp.h
+++ b/include/linux/dccp.h
@@ -191,7 +191,7 @@ enum {
 /* this structure is argument to DCCP_SOCKOPT_CHANGE_X */
 struct dccp_so_feat {
 	__u8 dccpsf_feat;
-	__u8 *dccpsf_val;
+	__u8 __user *dccpsf_val;
 	__u8 dccpsf_len;
 };
 
-- 
1.4.2.GIT


