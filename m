Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbTA1Wco>; Tue, 28 Jan 2003 17:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbTA1Wco>; Tue, 28 Jan 2003 17:32:44 -0500
Received: from mailrelay1.lanl.gov ([128.165.4.101]:34234 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S261594AbTA1Wcn>; Tue, 28 Jan 2003 17:32:43 -0500
Subject: [PATCH] 2.5.59 add two help texts to drivers/scsi/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: trivial@rustcorp.com.au, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 28 Jan 2003 15:39:38 -0700
Message-Id: <1043793578.2576.160.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some help texts from 2.4.21-pre3 Configure.help which are
needed in 2.5.59 drivers/scsi/Kconfig.

Steven

--- linux-2.5.59/drivers/scsi/Kconfig.orig	Tue Jan 28 15:10:28 2003
+++ linux-2.5.59/drivers/scsi/Kconfig	Tue Jan 28 15:14:08 2003
@@ -176,6 +176,9 @@
 config SGIWD93_SCSI
 	tristate "SGI WD93C93 SCSI Driver"
 	depends on SGI_IP22 && SCSI
+  	help
+	  If you have a Western Digital WD93 SCSI controller on
+	  an SGI MIPS system, say Y.  Otherwise, say N.
 
 config SCSI_DECNCR
 	tristate "DEC NCR53C94 Scsi Driver"
@@ -1342,6 +1345,10 @@
 config SCSI_QLOGIC_FC_FIRMWARE
 	bool "Include loadable firmware in driver"
 	depends on SCSI_QLOGIC_FC
+  	help
+	  Say Y to include ISP2100 Fabric Initiator/Target Firmware, with
+	  expanded LUN addressing and FcTape (FCP-2) support, in the
+	  Qlogic QLA 1280 driver. This is required on some platforms.
 
 config SCSI_QLOGIC_1280
 	tristate "Qlogic QLA 1280 SCSI support"




