Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbUKFDXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbUKFDXg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 22:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbUKFDXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 22:23:35 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:22690 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261302AbUKFDXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 22:23:22 -0500
Date: Fri, 5 Nov 2004 19:23:05 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] WIN_* -> ATA_CMD_* conversion: add new entries to ata.h
Message-ID: <20041106032305.GB6060@taniwha.stupidest.org>
References: <20041103091101.GC22469@taniwha.stupidest.org> <418AE8C0.3040205@pobox.com> <58cb370e041105051635c15281@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e041105051635c15281@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===== include/linux/ata.h 1.19 vs edited =====
--- 1.19/include/linux/ata.h	2004-11-02 11:32:44 -08:00
+++ edited/include/linux/ata.h	2004-11-05 19:04:41 -08:00
@@ -122,6 +122,27 @@
 	ATA_CMD_SET_FEATURES	= 0xEF,
 	ATA_CMD_PACKET		= 0xA0,
 
+	/* ATA devices commands (used by legacy IDE code) */
+	ATA_CMD_NOP		= 0x00,
+	ATA_CMD_SRST		= 0x08,
+	ATA_CMD_RESTORE		= 0x10,
+	ATA_CMD_MULTREAD_EXT	= 0x29,
+	ATA_CMD_READ_NATIVE_MAX_EXT = 0x27,
+	ATA_CMD_MULTWRITE_EXT	= 0x39,
+	ATA_CMD_SPECIFY		= 0x91, /* set geom */
+	ATA_CMD_SMART		= 0xB0,
+	ATA_CMD_MULTREAD	= 0xC4,
+	ATA_CMD_MULTWRITE	= 0xC5,
+	ATA_CMD_MULTSET		= 0xC6,
+	ATA_CMD_DOORLOCK	= 0xDE,
+	ATA_CMD_DOORUNLOCK	= 0xDF,
+	ATA_CMD_STANDBYNOW1	= 0xE0,
+	ATA_CMD_IDLEIMMEDIATE	= 0xE1,
+	ATA_CMD_ID_ATA_DMA	= 0xEE,
+	ATA_CMD_READ_NATIVE_MAX	= 0xF8,
+	ATA_CMD_SET_MAX		= 0xF9,
+	ATA_CMD_SET_MAX_EXT	= 0x37,
+
 	/* SETFEATURES stuff */
 	SETFEATURES_XFER	= 0x03,
 	XFER_UDMA_7		= 0x47,
