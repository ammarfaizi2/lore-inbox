Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313989AbSDQAzw>; Tue, 16 Apr 2002 20:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313993AbSDQAzv>; Tue, 16 Apr 2002 20:55:51 -0400
Received: from mail.mesatop.com ([208.164.122.9]:517 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S313989AbSDQAzr>;
	Tue, 16 Apr 2002 20:55:47 -0400
Subject: [PATCH] 2.5.8-dj1, add five help texts to arch/ppc/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1019004564.16110.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution/1.0.2-5mdk 
Date: 16 Apr 2002 18:54:19 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds five help texts to arch/ppc/Config.help.
The texts were obtained from the 2.4.19-pre7 Configure.help.

Steven

--- linux-2.5.8-dj1/arch/ppc/Config.help.orig	Tue Apr 16 12:58:46 2002
+++ linux-2.5.8-dj1/arch/ppc/Config.help	Tue Apr 16 13:05:33 2002
@@ -315,6 +315,31 @@
   includes a server that supports the frame buffer device directly
   (XF68_FBDev).
 
+CONFIG_VIODASD
+  If you are running on an iSeries system and you want to use
+  virtual disks created and managed by OS/400, say Y.
+
+CONFIG_VIODASD_IDE
+  This causes the iSeries virtual disks to look like IDE disks.
+  If you have programs or utilities that only support certain
+  kinds of disks, this option will cause iSeries virtual disks
+  to pretend to be IDE disks, which may satisfy the program.
+
+CONFIG_VIOCD
+  If you are running Linux on an IBM iSeries system and you want to
+  read a CD drive owned by OS/400, say Y here.
+
+CONFIG_VIOTAPE
+  If you are running Linux on an iSeries system and you want Linux
+  to read and/or write a tape drive owned by OS/400, say Y here.
+
+CONFIG_PMAC_APM_EMU
+  This driver provides an emulated /dev/apm_bios and /proc/apm. The
+  first one is mostly intended for XFree to sleep & wakeup properly,
+  the second one provides some battery information to allow existing
+  APM utilities to work. It provides less useful information than
+  tools specifically designed for PowerBooks or /proc/pmu/battery_x.
+
 CONFIG_SCSI
   If you want to use a SCSI hard disk, SCSI tape drive, SCSI CD-ROM or
   any other SCSI device under Linux, say Y and make sure that you know



