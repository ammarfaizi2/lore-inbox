Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbTEHHwT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 03:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbTEHHwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 03:52:19 -0400
Received: from [203.145.184.221] ([203.145.184.221]:57095 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S261202AbTEHHwS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 03:52:18 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH - 2.5.69] Warning fix in drivers/mtd/mtdblock.c
Date: Thu, 8 May 2003 13:33:25 +0530
User-Agent: KMail/1.4.1
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305081333.25600.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch will remove the compilation warning 
of  "unused variable" from the drivers/mtd/mtdblock.c.
Please apply.

Regards
KK

diffstat -p1 mtdblock-2.5.69.patch
===========================
drivers/mtd/mtdblock.c |    1 -
1 files changed, 1 deletion(-)


--- linux-2.5.69/drivers/mtd/mtdblock.c.orig    Mon May  5 05:23:13 2003
+++ linux-2.5.69/drivers/mtd/mtdblock.c Thu May  8 13:46:38 2003
@@ -522,7 +522,6 @@
 static void mtd_notify_add(struct mtd_info* mtd)
 {
        struct gendisk *disk;
-        char name[16];

         if (!mtd || mtd->type == MTD_ABSENT)
                 return;


