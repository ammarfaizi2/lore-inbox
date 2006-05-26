Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWEZOW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWEZOW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWEZOWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:22:24 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:717 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750786AbWEZOV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:21:58 -0400
In-reply-to: <20060526142117.GA2764@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 2/10] Clean up #include's
Message-Id: <E1FjdCG-00033A-JH@localhost.localdomain>
Date: Fri, 26 May 2006 09:21:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up a couple of #include's in the header file. Looks like there
may be a few more places where the #include's could be tweaked; we'll
address that in a future patch set.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/ecryptfs_kernel.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

41e02f240e66ee9c74871eaf0cadd3581cbb1980
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index b58e515..48fd0a1 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -32,8 +32,7 @@ #endif
 
 #include <keys/user-type.h>
 #include <linux/fs.h>
-#include <asm/semaphore.h>
-#include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 
 /* Version verification for shared data structures w/ userspace */
 #ifndef ECRYPTFS_VERSION_MAJOR
-- 
1.3.3

