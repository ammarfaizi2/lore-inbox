Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbUKGGFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbUKGGFJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 01:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbUKGGFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 01:05:09 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:17909 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261543AbUKGGFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 01:05:01 -0500
Date: Sat, 6 Nov 2004 22:04:32 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] WIN_* -> ATA_CMD_* conversion (take #2): add new entries to ata.h
Message-ID: <20041107060432.GB25569@taniwha.stupidest.org>
References: <20041103091101.GC22469@taniwha.stupidest.org> <418AE8C0.3040205@pobox.com> <58cb370e041105051635c15281@mail.gmail.com> <20041106032305.GB6060@taniwha.stupidest.org> <418D0066.9040002@pobox.com> <418D043E.3090406@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418D043E.3090406@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===== include/linux/ata.h 1.19 vs edited =====
--- 1.19/include/linux/ata.h	2004-11-02 11:32:44 -08:00
+++ edited/include/linux/ata.h	2004-11-06 21:39:38 -08:00
@@ -1,4 +1,3 @@
-
 /*
    Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
    Copyright 2003-2004 Jeff Garzik
@@ -121,6 +120,26 @@
 	ATA_CMD_PIO_WRITE_EXT	= 0x34,
 	ATA_CMD_SET_FEATURES	= 0xEF,
 	ATA_CMD_PACKET		= 0xA0,
+	ATA_CMD_NOP		= 0x00,
+	ATA_CMD_SMART		= 0xB0,
+	ATA_CMD_DEVICE_RESET	= 0x08,
+	ATA_CMD_READ_MULTIPLE_EXT = 0x29,
+	ATA_CMD_WRITE_MULTIPLE_EXT= 0x39,
+	ATA_CMD_READ_MULTIPLE	= 0xC4,
+	ATA_CMD_WRITE_MULTIPLE	= 0xC5,
+	ATA_CMD_SET_MULTIPLE_MODE = 0xC6,
+	ATA_CMD_MEDIA_LOCK	= 0xDE,
+	ATA_CMD_MEDIA_UNLOCK	= 0xDF,
+	ATA_CMD_STANDBY_IMMEDIATE = 0xE0,
+	ATA_CMD_IDLE_IMMEDIATE	= 0xE1,
+	ATA_CMD_READ_NATIVE_MAX_ADDRESS = 0xF8,
+	ATA_CMD_READ_NATIVE_MAX_ADDRESS_EXT = 0x27,
+	ATA_CMD_SET_MAX_ADDRESS = 0xF9,
+	ATA_CMD_SET_MAX_ADDRESS_EXT = 0x37,
+
+	/* marked obsolete in the ATA/ATAPI-7 spec */
+	ATA_CMD_RESTORE		= 0x10,
+	ATA_CMD_SPECIFY		= 0x91,
 
 	/* SETFEATURES stuff */
 	SETFEATURES_XFER	= 0x03,
