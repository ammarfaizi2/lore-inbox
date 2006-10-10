Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbWJJVoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbWJJVoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbWJJVoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:44:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:28868 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030481AbWJJVoH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:44:07 -0400
To: torvalds@osdl.org
Subject: [PATCH] advansys __iomem annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPOR-0007J4-33@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:44:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/scsi/advansys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 8369541..587eac9 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -3881,7 +3881,7 @@ #endif /* ADVANSYS_STATS */
     /*
      * The following fields are used only for Wide Boards.
      */
-    void                 *ioremap_addr;         /* I/O Memory remap address. */
+    void                 __iomem *ioremap_addr; /* I/O Memory remap address. */
     ushort               ioport;                /* I/O Port address. */
     ADV_CARR_T           *orig_carrp;           /* ADV_CARR_T memory block. */
     adv_req_t            *orig_reqp;            /* adv_req_t memory block. */
-- 
1.4.2.GIT


