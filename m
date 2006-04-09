Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWDIPby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWDIPby (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWDIPbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:31:21 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:38058 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750792AbWDIPbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:31:16 -0400
Date: Sun, 9 Apr 2006 17:31:15 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 19/19] kconfig: remove leading whitespace in menu prompts
Message-ID: <Pine.LNX.4.64.0604091731020.23191@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This removes all the leading whitespace kconfig now warns about.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 drivers/mtd/Kconfig          |    4 ++--
 drivers/mtd/maps/Kconfig     |    2 +-
 drivers/scsi/Kconfig         |   10 +++++-----
 drivers/scsi/qla2xxx/Kconfig |   12 ++++++------
 sound/oss/Kconfig            |    2 +-
 5 files changed, 15 insertions(+), 15 deletions(-)

Index: linux-2.6-git/drivers/mtd/Kconfig
===================================================================
--- linux-2.6-git.orig/drivers/mtd/Kconfig
+++ linux-2.6-git/drivers/mtd/Kconfig
@@ -86,14 +86,14 @@ config MTD_REDBOOT_DIRECTORY_BLOCK
 	  block and "-2" means the penultimate block.
 
 config MTD_REDBOOT_PARTS_UNALLOCATED
-	bool "  Include unallocated flash regions"
+	bool "Include unallocated flash regions"
 	depends on MTD_REDBOOT_PARTS
 	help
 	  If you need to register each unallocated flash region as a MTD
 	  'partition', enable this option.
 
 config MTD_REDBOOT_PARTS_READONLY
-	bool "  Force read-only for RedBoot system images"
+	bool "Force read-only for RedBoot system images"
 	depends on MTD_REDBOOT_PARTS
 	help
 	  If you need to force read-only for 'RedBoot', 'RedBoot Config' and
Index: linux-2.6-git/drivers/mtd/maps/Kconfig
===================================================================
--- linux-2.6-git.orig/drivers/mtd/maps/Kconfig
+++ linux-2.6-git/drivers/mtd/maps/Kconfig
@@ -212,7 +212,7 @@ config MTD_NETtel
 	  Support for flash chips on NETtel/SecureEdge/SnapGear boards.
 
 config MTD_ALCHEMY
-	tristate '  AMD Alchemy Pb1xxx/Db1xxx/RDK MTD support'
+	tristate "AMD Alchemy Pb1xxx/Db1xxx/RDK MTD support"
 	depends on SOC_AU1X00
 	help
 	  Flash memory access on AMD Alchemy Pb/Db/RDK Reference Boards
Index: linux-2.6-git/drivers/scsi/Kconfig
===================================================================
--- linux-2.6-git.orig/drivers/scsi/Kconfig
+++ linux-2.6-git/drivers/scsi/Kconfig
@@ -1156,7 +1156,7 @@ config SCSI_NCR_Q720
 	  you do not have this SCSI card, so say N.
 
 config SCSI_NCR53C8XX_DEFAULT_TAGS
-	int "  default tagged command queue depth"
+	int "default tagged command queue depth"
 	depends on SCSI_ZALON || SCSI_NCR_Q720
 	default "8"
 	---help---
@@ -1182,7 +1182,7 @@ config SCSI_NCR53C8XX_DEFAULT_TAGS
 	  There is no safe option other than using good SCSI devices.
 
 config SCSI_NCR53C8XX_MAX_TAGS
-	int "  maximum number of queued commands"
+	int "maximum number of queued commands"
 	depends on SCSI_ZALON || SCSI_NCR_Q720
 	default "32"
 	---help---
@@ -1199,7 +1199,7 @@ config SCSI_NCR53C8XX_MAX_TAGS
 	  There is no safe option and the default answer is recommended.
 
 config SCSI_NCR53C8XX_SYNC
-	int "  synchronous transfers frequency in MHz"
+	int "synchronous transfers frequency in MHz"
 	depends on SCSI_ZALON || SCSI_NCR_Q720
 	default "20"
 	---help---
@@ -1233,7 +1233,7 @@ config SCSI_NCR53C8XX_SYNC
 	  terminations and SCSI conformant devices.
 
 config SCSI_NCR53C8XX_PROFILE
-	bool "  enable profiling"
+	bool "enable profiling"
 	depends on SCSI_ZALON || SCSI_NCR_Q720
 	help
 	  This option allows you to enable profiling information gathering.
@@ -1244,7 +1244,7 @@ config SCSI_NCR53C8XX_PROFILE
 	  The normal answer therefore is N.
 
 config SCSI_NCR53C8XX_NO_DISCONNECT
-	bool "  not allow targets to disconnect"
+	bool "not allow targets to disconnect"
 	depends on (SCSI_ZALON || SCSI_NCR_Q720) && SCSI_NCR53C8XX_DEFAULT_TAGS=0
 	help
 	  This option is only provided for safety if you suspect some SCSI
Index: linux-2.6-git/drivers/scsi/qla2xxx/Kconfig
===================================================================
--- linux-2.6-git.orig/drivers/scsi/qla2xxx/Kconfig
+++ linux-2.6-git/drivers/scsi/qla2xxx/Kconfig
@@ -30,7 +30,7 @@ config SCSI_QLA_FC
 	be removed from the kernel sources.
 
 config SCSI_QLA2XXX_EMBEDDED_FIRMWARE
-	bool "  Use firmware-loader modules (DEPRECATED)"
+	bool "Use firmware-loader modules (DEPRECATED)"
 	depends on SCSI_QLA_FC
 	help
 	  This option offers you the deprecated firmware-loader
@@ -38,33 +38,33 @@ config SCSI_QLA2XXX_EMBEDDED_FIRMWARE
 	  Firmware Loader interface in the qla2xxx driver.
 
 config SCSI_QLA21XX
-	tristate "  Build QLogic ISP2100 firmware-module"
+	tristate "Build QLogic ISP2100 firmware-module"
 	depends on SCSI_QLA_FC && SCSI_QLA2XXX_EMBEDDED_FIRMWARE
 	---help---
 	This driver supports the QLogic 21xx (ISP2100) host adapter family.
 
 config SCSI_QLA22XX
-	tristate "  Build QLogic ISP2200 firmware-module"
+	tristate "Build QLogic ISP2200 firmware-module"
 	depends on SCSI_QLA_FC && SCSI_QLA2XXX_EMBEDDED_FIRMWARE
 	---help---
 	This driver supports the QLogic 22xx (ISP2200) host adapter family.
 
 config SCSI_QLA2300
-	tristate "  Build QLogic ISP2300/ISP6312 firmware-module"
+	tristate "Build QLogic ISP2300/ISP6312 firmware-module"
 	depends on SCSI_QLA_FC && SCSI_QLA2XXX_EMBEDDED_FIRMWARE
 	---help---
 	This driver supports the QLogic 2300 (ISP2300, ISP2312 and
 	ISP6312) host adapter family.
 
 config SCSI_QLA2322
-	tristate "  Build QLogic ISP2322/ISP6322 firmware-module"
+	tristate "Build QLogic ISP2322/ISP6322 firmware-module"
 	depends on SCSI_QLA_FC && SCSI_QLA2XXX_EMBEDDED_FIRMWARE
 	---help---
 	This driver supports the QLogic 2322 (ISP2322 and ISP6322) host
 	adapter family.
 
 config SCSI_QLA24XX
-	tristate "  Build QLogic ISP24xx firmware-module"
+	tristate "Build QLogic ISP24xx firmware-module"
 	depends on SCSI_QLA_FC && SCSI_QLA2XXX_EMBEDDED_FIRMWARE
 	---help---
 	This driver supports the QLogic 24xx (ISP2422 and ISP2432) host
Index: linux-2.6-git/sound/oss/Kconfig
===================================================================
--- linux-2.6-git.orig/sound/oss/Kconfig
+++ linux-2.6-git/sound/oss/Kconfig
@@ -1130,6 +1130,6 @@ config SOUND_SH_DAC_AUDIO
 	depends on SOUND_PRIME && CPU_SH3
 
 config SOUND_SH_DAC_AUDIO_CHANNEL
-	int "    DAC channel"
+	int "DAC channel"
 	default "1"
 	depends on SOUND_SH_DAC_AUDIO
