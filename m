Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbSKWMGp>; Sat, 23 Nov 2002 07:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266989AbSKWMGp>; Sat, 23 Nov 2002 07:06:45 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:15557 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266987AbSKWMGo>; Sat, 23 Nov 2002 07:06:44 -0500
Message-Id: <4.3.2.7.2.20021123131000.00b50100@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 23 Nov 2002 13:14:15 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Linux 2.4.20-rc3
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this patch (rc2-rc3) correct ?

diff -urN linux-2.4.20-rc2/drivers/scsi/scsi_merge.c 
linux-2.4.20-rc3/drivers/scsi/scsi_merge.c
--- linux-2.4.20-rc2/drivers/scsi/scsi_merge.c  Fri Nov 22 12:14:23 2002
+++ linux-2.4.20-rc3/drivers/scsi/scsi_merge.c  Fri Nov 22 12:14:32 2002
@@ -835,7 +835,7 @@
          * case.
          */
         if (count == 1 && !SCpnt->host->highmem_io) {
-               this_count = req->current_nr_sectors;
+               this_count = req->nr_sectors;
                 goto single_segment;
         }


Margit 

