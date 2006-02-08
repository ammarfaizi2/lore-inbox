Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030508AbWBHDVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030508AbWBHDVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030501AbWBHDUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:20:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:1153 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030477AbWBHDTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:19:32 -0500
To: torvalds@osdl.org
Subject: [PATCH 20/29] scsi_transport_iscsi gfp_t annotations
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Message-Id: <E1F6frg-0006DY-4T@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:19:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138793445 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/scsi/scsi_transport_iscsi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

e5fb81bd895041230dfaeb8f8f498b85b4705988
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 59a1c9d..723f7ac 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -463,7 +463,7 @@ static inline struct list_head *skb_to_l
 }
 
 static void*
-mempool_zone_alloc_skb(unsigned int gfp_mask, void *pool_data)
+mempool_zone_alloc_skb(gfp_t gfp_mask, void *pool_data)
 {
 	struct mempool_zone *zone = pool_data;
 
-- 
0.99.9.GIT

