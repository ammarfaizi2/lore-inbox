Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268346AbTBYUaN>; Tue, 25 Feb 2003 15:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268296AbTBYUVT>; Tue, 25 Feb 2003 15:21:19 -0500
Received: from [24.77.48.240] ([24.77.48.240]:40233 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268289AbTBYUVD>;
	Tue, 25 Feb 2003 15:21:03 -0500
Date: Tue, 25 Feb 2003 12:31:18 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302252031.h1PKVI324910@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - didn't
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:
    didnt -> didn't (4 occurrences)

diff -ur a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Mon Feb 24 11:05:15 2003
+++ b/arch/i386/kernel/io_apic.c	Tue Feb 25 09:55:01 2003
@@ -2063,7 +2063,7 @@
 }
 
 /*
- *	Called after all the initialization is done. If we didnt find any
+ *	Called after all the initialization is done. If we didn't find any
  *	APIC bugs then we can allow the modify fast path
  */
  
diff -ur a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Mon Feb 24 11:05:07 2003
+++ b/drivers/block/ll_rw_blk.c	Tue Feb 25 09:55:03 2003
@@ -1578,7 +1578,7 @@
 	request_queue_t *q = req->q;
 	
 	/*
-	 * if req->q isn't set, this request didnt originate from the
+	 * if req->q isn't set, this request didn't originate from the
 	 * block layer, so it's safe to just disregard it
 	 */
 	if (q) {
diff -ur a/drivers/scsi/wd7000.c b/drivers/scsi/wd7000.c
--- a/drivers/scsi/wd7000.c	Mon Feb 24 11:06:01 2003
+++ b/drivers/scsi/wd7000.c	Tue Feb 25 09:55:09 2003
@@ -874,7 +874,7 @@
 		}
 	}
 
-	/* Take the lock, then check we didnt get beaten, if so try again */
+	/* Take the lock, then check we didn't get beaten, if so try again */
 	spin_lock_irqsave(&scbpool_lock, flags);
 	if (freescbs < needed) {
 		spin_unlock_irqrestore(&scbpool_lock, flags);
diff -ur a/fs/xfs/xfs_quota.h b/fs/xfs/xfs_quota.h
--- a/fs/xfs/xfs_quota.h	Mon Feb 24 11:06:01 2003
+++ b/fs/xfs/xfs_quota.h	Tue Feb 25 09:55:13 2003
@@ -140,7 +140,7 @@
  * The inode cannot go inactive as long a reference is kept, and
  * therefore if dquot(s) were attached, they'll stay consistent.
  * If, for example, the ownership of the inode changes while
- * we didnt have the inode locked, the appropriate dquot(s) will be
+ * we didn't have the inode locked, the appropriate dquot(s) will be
  * attached atomically.
  */
 #define XFS_NOT_DQATTACHED(mp, ip) ((XFS_IS_UQUOTA_ON(mp) &&\
