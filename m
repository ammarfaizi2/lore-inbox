Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbUJXOOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbUJXOOH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 10:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbUJXOOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 10:14:07 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29201 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261493AbUJXOOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 10:14:00 -0400
Date: Sun, 24 Oct 2004 16:13:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Tom Fredrik Blenning Klaussen <bfg-kernel@blenning.no>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] firmware spelling errors
Message-ID: <20041024141328.GF4216@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The trivial patch by Tom Fredrik Blenning Klaussen below which fixes 
some mis-spelings of the word "firmware" still applies against 
2.6.9-mm1.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

diff -ruN /usr/src/linux-2.6.8.1/drivers/atm/fore200e.h ./drivers/atm/fore200e.h
--- /usr/src/linux-2.6.8.1/drivers/atm/fore200e.h	2004-08-31 13:11:45.000000000 +0200
+++ ./drivers/atm/fore200e.h	2004-09-12 19:47:30.000000000 +0200
@@ -645,7 +645,7 @@
 
 typedef struct fw_header {
     u32 magic;           /* magic number                               */
-    u32 version;         /* firware version id                         */
+    u32 version;         /* firmware version id                        */
     u32 load_offset;     /* fw load offset in board memory             */
     u32 start_offset;    /* fw execution start address in board memory */
 } fw_header_t;
diff -ruN /usr/src/linux-2.6.8.1/drivers/base/Kconfig ./drivers/base/Kconfig
--- /usr/src/linux-2.6.8.1/drivers/base/Kconfig	2004-08-31 13:11:45.000000000 +0200
+++ ./drivers/base/Kconfig	2004-09-12 19:47:30.000000000 +0200
@@ -14,7 +14,7 @@
 	default y
 	help
 	  Say yes to avoid building firmware. Firmware is usually shipped
-	  with the driver, and only when updating the firware a rebuild
+	  with the driver, and only when updating the firmware a rebuild
 	  should be made.
 	  If unsure say Y here.
 
diff -ruN /usr/src/linux-2.6.8.1/drivers/net/wan/cosa.c ./drivers/net/wan/cosa.c
--- /usr/src/linux-2.6.8.1/drivers/net/wan/cosa.c	2004-08-31 13:11:45.000000000 +0200
+++ ./drivers/net/wan/cosa.c	2004-09-12 19:47:30.000000000 +0200
@@ -156,7 +156,7 @@
 	unsigned short startaddr;	/* Firmware start address */
 	unsigned short busmaster;	/* Use busmastering? */
 	int nchannels;			/* # of channels on this card */
-	int driver_status;		/* For communicating with firware */
+	int driver_status;		/* For communicating with firmware */
 	int firmware_status;		/* Downloaded, reseted, etc. */
 	long int rxbitmap, txbitmap;	/* Bitmap of channels who are willing to send/receive data */
 	long int rxtx;			/* RX or TX in progress? */
diff -ruN /usr/src/linux-2.6.8.1/drivers/scsi/megaraid.c ./drivers/scsi/megaraid.c
--- /usr/src/linux-2.6.8.1/drivers/scsi/megaraid.c	2004-08-31 13:11:45.000000000 +0200
+++ ./drivers/scsi/megaraid.c	2004-09-12 19:47:30.000000000 +0200
@@ -4006,7 +4006,7 @@
 	mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
 
 	/*
-	 * Non-ROMB firware fail this command, so all channels
+	 * Non-ROMB firmware fail this command, so all channels
 	 * must be shown RAID
 	 */
 	adapter->mega_ch_class = 0xFF;

