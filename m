Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTF0O6N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbTF0O57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:57:59 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:50097 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S264465AbTF0O4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:56:22 -0400
Date: Fri, 27 Jun 2003 17:09:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (6/7): typos.
Message-ID: <20030627150905.GG3591@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typos.

diffstat:
 drivers/s390/block/xpram.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urN linux-2.5/drivers/s390/block/xpram.c linux-2.5-s390/drivers/s390/block/xpram.c
--- linux-2.5/drivers/s390/block/xpram.c	Sun Jun 22 20:33:04 2003
+++ linux-2.5-s390/drivers/s390/block/xpram.c	Fri Jun 27 16:04:40 2003
@@ -487,7 +487,7 @@
 	unregister_blkdev(XPRAM_MAJOR, XPRAM_NAME);
 	devfs_remove("slram");
 	sys_device_unregister(&xpram_sys_device);
-	sysdev_class_unregister(&xpram_sys_class);
+	sysdev_class_unregister(&xpram_sysclass);
 }
 
 static int __init xpram_init(void)
@@ -511,7 +511,7 @@
 
 	rc = sys_device_register(&xpram_sys_device);
 	if (rc) {
-		sysdev_class_unregister(&xpram_syclass);
+		sysdev_class_unregister(&xpram_sysclass);
 		return rc;
 	}
 	rc = xpram_setup_blkdev();
