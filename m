Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263188AbUFTWlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUFTWlU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUFTWlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:41:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24020 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263188AbUFTWlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:41:17 -0400
Date: Mon, 21 Jun 2004 00:41:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: jgarzik@pobox.com, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] add SATA Configure.help texts
Message-ID: <20040620224109.GE27822@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds the missing SATA Configure.help texts
(stolen from 2.6.7).

Please apply
Adrian

--- linux-2.4.27-rc1-full/Documentation/Configure.help.old	2004-06-21 00:01:56.000000000 +0200
+++ linux-2.4.27-rc1-full/Documentation/Configure.help	2004-06-21 00:38:19.000000000 +0200
@@ -9265,6 +9265,48 @@
   say M here and read <file:Documentation/modules.txt>.  The module
   will be called megaraid2.o.
 
+CONFIG_SCSI_SATA
+  This driver family supports Serial ATA host controllers
+  and devices.
+
+  If unsure, say N.
+
+CONFIG_SCSI_SATA_SVW
+  This option enables support for Broadcom/Serverworks/Apple K2
+  SATA support.
+
+  If unsure, say N.
+
+CONFIG_SCSI_SATA_PROMISE
+  This option enables support for Promise Serial ATA TX2/TX4.
+
+  If unsure, say N.
+
+CONFIG_SCSI_SATA_SX4
+  This option enables support for Promise Serial ATA SX4.
+
+  If unsure, say N.
+
+CONFIG_SCSI_SATA_SIL
+  This option enables support for Silicon Image Serial ATA.
+
+  If unsure, say N.
+
+CONFIG_SCSI_SATA_SIS
+  This option enables support for SiS Serial ATA 964/180.
+
+  If unsure, say N.
+
+CONFIG_SCSI_SATA_VIA
+  This option enables support for VIA Serial ATA.
+
+  If unsure, say N.
+
+CONFIG_SCSI_SATA_VITESSE
+  This option enables support for Vitesse VSC7174 Serial ATA.
+
+  If unsure, say N.
+
 Intel/ICP (former GDT SCSI Disk Array) RAID Controller support
 CONFIG_SCSI_GDTH
   Formerly called GDT SCSI Disk Array Controller Support.
