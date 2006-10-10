Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030483AbWJJVoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbWJJVoe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbWJJVod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:44:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:29636 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030483AbWJJVo1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:44:27 -0400
To: torvalds@osdl.org
Subject: [PATCH] drivers/s390 misc sparse annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPOl-0007JV-3F@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:44:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/s390/scsi/zfcp_erp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index 862a411..c88babc 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -1987,7 +1987,7 @@ zfcp_erp_adapter_strategy_open_qdio(stru
 		sbale = &(adapter->response_queue.buffer[i]->element[0]);
 		sbale->length = 0;
 		sbale->flags = SBAL_FLAGS_LAST_ENTRY;
-		sbale->addr = 0;
+		sbale->addr = NULL;
 	}
 
 	ZFCP_LOG_TRACE("calling do_QDIO on adapter %s (flags=0x%x, "
-- 
1.4.2.GIT


