Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269486AbUINQna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269486AbUINQna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 12:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269472AbUINQlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:41:15 -0400
Received: from host-81-191-110-70.bluecom.no ([81.191.110.70]:28812 "EHLO
	mail.blenning.no") by vger.kernel.org with ESMTP id S269616AbUINQXN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:23:13 -0400
Subject: [PATCH] Spelling errors
From: Tom Fredrik Blenning Klaussen <bfg-kernel@blenning.no>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095178918.11939.9.camel@host-81-191-110-70.bluecom.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Sep 2004 18:21:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a few spelling errors in comments and conf-help.
The word firmware was written wrong as firware several places.

=======================================================
diff -ruN /usr/src/linux-2.6.8.1/drivers/atm/fore200e.h ./drivers/atm/fore200e.h
--- /usr/src/linux-2.6.8.1/drivers/atm/fore200e.h       2004-08-31 13:11:45.000000000 +0200
+++ ./drivers/atm/fore200e.h    2004-09-12 19:47:30.000000000 +0200
@@ -645,7 +645,7 @@
 
 typedef struct fw_header {
     u32 magic;           /* magic number                               */
-    u32 version;         /* firware version id                         */
+    u32 version;         /* firmware version id                        */
     u32 load_offset;     /* fw load offset in board memory             */
     u32 start_offset;    /* fw execution start address in board memory */
 } fw_header_t;                 
diff -ruN /usr/src/linux-2.6.8.1/drivers/base/Kconfig ./drivers/base/Kconfig
--- /usr/src/linux-2.6.8.1/drivers/base/Kconfig 2004-08-31 13:11:45.000000000 +0200
+++ ./drivers/base/Kconfig      2004-09-12 19:47:30.000000000 +0200
@@ -14,7 +14,7 @@               
        default y               
        help                    
          Say yes to avoid building firmware. Firmware is usually shipped
-         with the driver, and only when updating the firware a rebuild
+         with the driver, and only when updating the firmware a rebuild
          should be made.       
          If unsure say Y here. 
                                
diff -ruN /usr/src/linux-2.6.8.1/drivers/net/wan/cosa.c ./drivers/net/wan/cosa.c
--- /usr/src/linux-2.6.8.1/drivers/net/wan/cosa.c       2004-08-31 13:11:45.000000000 +0200
+++ ./drivers/net/wan/cosa.c    2004-09-12 19:47:30.000000000 +0200
@@ -156,7 +156,7 @@             
        unsigned short startaddr;       /* Firmware start address */
        unsigned short busmaster;       /* Use busmastering? */
        int nchannels;                  /* # of channels on this card */
-       int driver_status;              /* For communicating with firware */
+       int driver_status;              /* For communicating with firmware */
        int firmware_status;            /* Downloaded, reseted, etc. */
        long int rxbitmap, txbitmap;    /* Bitmap of channels who are willing to send/receive data */
        long int rxtx;                  /* RX or TX in progress? */
diff -ruN /usr/src/linux-2.6.8.1/drivers/scsi/megaraid.c ./drivers/scsi/megaraid.c
--- /usr/src/linux-2.6.8.1/drivers/scsi/megaraid.c      2004-08-31 13:11:45.000000000 +0200
+++ ./drivers/scsi/megaraid.c   2004-09-12 19:47:30.000000000 +0200
@@ -4006,7 +4006,7 @@           
        mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
                                
        /*                      
-        * Non-ROMB firware fail this command, so all channels
+        * Non-ROMB firmware fail this command, so all channels
         * must be shown RAID   
         */                     
        adapter->mega_ch_class = 0xFF;
==============================================================

Sincerely
-- 
Tom Fredrik Klaussen
Rosendalsvn. 16B
N-1166 Oslo
Norway

Phone : (+47) 22 28 20 68
Mobile: (+47) 99 62 45 44
