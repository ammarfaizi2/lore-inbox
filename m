Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030518AbWJJVt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030518AbWJJVt6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030531AbWJJVt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:49:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42939 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030534AbWJJVts
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:49:48 -0400
To: torvalds@osdl.org
Subject: [PATCH] use %zu for size_t
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPTv-0007Sf-HP@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:49:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/scsi/dc395x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 23f5e41..e95b367 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -1219,7 +1219,7 @@ static void dump_register_info(struct Ad
 			    	srb, srb->cmd, srb->cmd->pid,
 				srb->cmd->cmnd[0], srb->cmd->device->id,
 			       	srb->cmd->device->lun);
-		printk("  sglist=%p cnt=%i idx=%i len=%Zd\n",
+		printk("  sglist=%p cnt=%i idx=%i len=%zu\n",
 		       srb->segment_x, srb->sg_count, srb->sg_index,
 		       srb->total_xfer_length);
 		printk("  state=0x%04x status=0x%02x phase=0x%02x (%sconn.)\n",
-- 
1.4.2.GIT


