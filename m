Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbTFUORx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 10:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264667AbTFUORp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 10:17:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20976 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264655AbTFUORh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 10:17:37 -0400
Date: Sat, 21 Jun 2003 16:31:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] remove an unused variable from fd_mcs.c
Message-ID: <20030621143134.GV29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch belowremoves an unused variable from drivers/scsi/fd_mcs.c .

I've tested the compilation with 2.5.72-mm2.



--- linux-2.5.72-mm2/drivers/scsi/fd_mcs.c.old	2003-06-21 16:28:39.000000000 +0200
+++ linux-2.5.72-mm2/drivers/scsi/fd_mcs.c	2003-06-21 16:28:43.000000000 +0200
@@ -589,7 +589,6 @@
 static int fd_mcs_proc_info(struct Scsi_Host *shpnt, char *buffer, char **start, off_t offset, int length, int inout)
 {
 	int len = 0;
-	int i;
 
 	if (inout)
 		return (-ENOSYS);



Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

