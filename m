Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbWBHHL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbWBHHL7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWBHHLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:11:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:59036 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161050AbWBHHLB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:11:01 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] __user annotations in powerpc thread_info
Cc: linuxppc-dev@ozlabs.org
Message-Id: <E1F6jTh-0002cN-1v@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:11:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138796974 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-powerpc/thread_info.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

e795638bb9e81bae80bbe88b74c8ee0d1b1d8d3c
diff --git a/include/asm-powerpc/thread_info.h b/include/asm-powerpc/thread_info.h
index 67cdaf3..c044ec1 100644
--- a/include/asm-powerpc/thread_info.h
+++ b/include/asm-powerpc/thread_info.h
@@ -37,7 +37,7 @@ struct thread_info {
 	int		preempt_count;		/* 0 => preemptable,
 						   <0 => BUG */
 	struct restart_block restart_block;
-	void *nvgprs_frame;
+	void __user *nvgprs_frame;
 	/* low level flags - has atomic operations done on it */
 	unsigned long	flags ____cacheline_aligned_in_smp;
 };
-- 
0.99.9.GIT

