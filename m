Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbUCPUVW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 15:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbUCPUVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 15:21:22 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:35471 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261629AbUCPUUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 15:20:42 -0500
Date: Tue, 16 Mar 2004 20:20:01 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Remove old config options from defconfigs.
Message-ID: <20040316202001.GA24623@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These options are only ever referenced in the defconfigs
of various archs now.

		Dave

--- linux-2.6.4/arch/i386/defconfig~	2004-03-16 19:43:00.000000000 +0000
+++ linux-2.6.4/arch/i386/defconfig	2004-03-16 19:43:04.000000000 +0000
@@ -141,7 +141,6 @@
 CONFIG_ACPI_POWER=y
 CONFIG_ACPI_PCI=y
 CONFIG_ACPI_SYSTEM=y
-# CONFIG_ACPI_RELAXED_AML is not set
 # CONFIG_X86_PM_TIMER is not set
 
 #
--- linux-2.6.4/arch/ia64/configs/sn2_defconfig~	2004-03-16 19:43:09.000000000 +0000
+++ linux-2.6.4/arch/ia64/configs/sn2_defconfig	2004-03-16 19:43:11.000000000 +0000
@@ -90,7 +90,6 @@
 CONFIG_ACPI_POWER=y
 CONFIG_ACPI_PCI=y
 CONFIG_ACPI_SYSTEM=y
-# CONFIG_ACPI_RELAXED_AML is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 CONFIG_PCI_LEGACY_PROC=y
--- linux-2.6.4/arch/ia64/configs/zx1_defconfig~	2004-03-16 19:43:15.000000000 +0000
+++ linux-2.6.4/arch/ia64/configs/zx1_defconfig	2004-03-16 19:43:17.000000000 +0000
@@ -101,7 +101,6 @@
 CONFIG_ACPI_POWER=y
 CONFIG_ACPI_PCI=y
 CONFIG_ACPI_SYSTEM=y
-# CONFIG_ACPI_RELAXED_AML is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 CONFIG_PCI_LEGACY_PROC=y
--- linux-2.6.4/arch/ia64/configs/generic_defconfig~	2004-03-16 19:43:21.000000000 +0000
+++ linux-2.6.4/arch/ia64/configs/generic_defconfig	2004-03-16 19:43:22.000000000 +0000
@@ -105,7 +105,6 @@
 CONFIG_ACPI_POWER=y
 CONFIG_ACPI_PCI=y
 CONFIG_ACPI_SYSTEM=y
-# CONFIG_ACPI_RELAXED_AML is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 CONFIG_PCI_LEGACY_PROC=y
--- linux-2.6.4/arch/ia64/defconfig~	2004-03-16 19:43:26.000000000 +0000
+++ linux-2.6.4/arch/ia64/defconfig	2004-03-16 19:43:28.000000000 +0000
@@ -106,7 +106,6 @@
 CONFIG_ACPI_POWER=y
 CONFIG_ACPI_PCI=y
 CONFIG_ACPI_SYSTEM=y
-# CONFIG_ACPI_RELAXED_AML is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 CONFIG_PCI_LEGACY_PROC=y
--- linux-2.6.4/arch/ppc/configs/power3_defconfig~	2004-03-16 19:46:29.000000000 +0000
+++ linux-2.6.4/arch/ppc/configs/power3_defconfig	2004-03-16 19:46:34.000000000 +0000
@@ -177,7 +177,6 @@
 CONFIG_MD_RAID5=y
 # CONFIG_MD_MULTIPATH is not set
 CONFIG_BLK_DEV_DM=y
-CONFIG_DM_IOCTL_V4=y
 
 #
 # ATA/ATAPI/MFM/RLL support
--- linux-2.6.4/arch/ia64/configs/generic_defconfig~	2004-03-16 19:46:38.000000000 +0000
+++ linux-2.6.4/arch/ia64/configs/generic_defconfig	2004-03-16 19:46:41.000000000 +0000
@@ -238,7 +238,6 @@
 CONFIG_MD_RAID5=m
 CONFIG_MD_MULTIPATH=m
 CONFIG_BLK_DEV_DM=m
-CONFIG_DM_IOCTL_V4=y
 
 #
 # Fusion MPT device support
--- linux-2.6.4/arch/ia64/defconfig~	2004-03-16 19:46:47.000000000 +0000
+++ linux-2.6.4/arch/ia64/defconfig	2004-03-16 19:46:50.000000000 +0000
@@ -236,7 +236,6 @@
 # CONFIG_MD_RAID6 is not set
 CONFIG_MD_MULTIPATH=m
 CONFIG_BLK_DEV_DM=m
-CONFIG_DM_IOCTL_V4=y
 
 #
 # Fusion MPT device support
--- linux-2.6.4/arch/mips/configs/rm200_defconfig~	2004-03-16 19:46:58.000000000 +0000
+++ linux-2.6.4/arch/mips/configs/rm200_defconfig	2004-03-16 19:47:00.000000000 +0000
@@ -323,7 +323,6 @@
 # CONFIG_MD_RAID6 is not set
 CONFIG_MD_MULTIPATH=m
 CONFIG_BLK_DEV_DM=m
-CONFIG_DM_IOCTL_V4=y
 
 #
 # Fusion MPT device support
--- linux-2.6.4/arch/ppc64/configs/g5_defconfig~	2004-03-16 19:47:04.000000000 +0000
+++ linux-2.6.4/arch/ppc64/configs/g5_defconfig	2004-03-16 19:47:07.000000000 +0000
@@ -278,7 +278,6 @@
 # CONFIG_MD_RAID6 is not set
 # CONFIG_MD_MULTIPATH is not set
 CONFIG_BLK_DEV_DM=y
-CONFIG_DM_IOCTL_V4=y
 # CONFIG_DM_CRYPT is not set
 
 #
--- linux-2.6.4/arch/ppc64/configs/iSeries_defconfig~	2004-03-16 19:47:13.000000000 +0000
+++ linux-2.6.4/arch/ppc64/configs/iSeries_defconfig	2004-03-16 19:47:14.000000000 +0000
@@ -197,7 +197,6 @@
 CONFIG_MD_RAID6=y
 # CONFIG_MD_MULTIPATH is not set
 CONFIG_BLK_DEV_DM=y
-CONFIG_DM_IOCTL_V4=y
 CONFIG_DM_CRYPT=m
 
 #
--- linux-2.6.4/arch/ppc64/configs/pSeries_defconfig~	2004-03-16 19:47:20.000000000 +0000
+++ linux-2.6.4/arch/ppc64/configs/pSeries_defconfig	2004-03-16 19:47:22.000000000 +0000
@@ -273,7 +273,6 @@
 CONFIG_MD_RAID6=y
 # CONFIG_MD_MULTIPATH is not set
 CONFIG_BLK_DEV_DM=y
-CONFIG_DM_IOCTL_V4=y
 CONFIG_DM_CRYPT=m
 
 #
--- linux-2.6.4/arch/ppc64/defconfig~	2004-03-16 19:47:26.000000000 +0000
+++ linux-2.6.4/arch/ppc64/defconfig	2004-03-16 19:47:27.000000000 +0000
@@ -273,7 +273,6 @@
 CONFIG_MD_RAID6=y
 # CONFIG_MD_MULTIPATH is not set
 CONFIG_BLK_DEV_DM=y
-CONFIG_DM_IOCTL_V4=y
 CONFIG_DM_CRYPT=m
 
 #
--- linux-2.6.4/arch/sparc64/defconfig~	2004-03-16 19:47:33.000000000 +0000
+++ linux-2.6.4/arch/sparc64/defconfig	2004-03-16 19:47:35.000000000 +0000
@@ -384,7 +384,6 @@
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
 CONFIG_BLK_DEV_DM=m
-# CONFIG_DM_IOCTL_V4 is not set
 CONFIG_DM_CRYPT=m
 
 #
--- linux-2.6.4/arch/arm/configs/pfs168_sastn_defconfig~	2004-03-16 20:04:24.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/pfs168_sastn_defconfig	2004-03-16 20:04:28.000000000 +0000
@@ -508,7 +508,6 @@
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
 # CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_ELV is not set
 # CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_ASSABET is not set
 # CONFIG_I2C_ALGOPCF is not set
--- linux-2.6.4/arch/arm/configs/rpc_defconfig~	2004-03-16 20:04:33.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/rpc_defconfig	2004-03-16 20:04:35.000000000 +0000
@@ -463,7 +463,6 @@
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
 # CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_ELV is not set
 # CONFIG_I2C_VELLEMAN is not set
 # CONFIG_SCx200_ACB is not set
 # CONFIG_I2C_ALGOPCF is not set
--- linux-2.6.4/arch/arm/configs/pfs168_mqvga_defconfig~	2004-03-16 20:04:38.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/pfs168_mqvga_defconfig	2004-03-16 20:04:39.000000000 +0000
@@ -507,7 +507,6 @@
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
 # CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_ELV is not set
 # CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_ASSABET is not set
 CONFIG_I2C_PFS168=y
--- linux-2.6.4/arch/arm/configs/trizeps_defconfig~	2004-03-16 20:04:42.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/trizeps_defconfig	2004-03-16 20:04:44.000000000 +0000
@@ -625,7 +625,6 @@
 CONFIG_I2C=m
 CONFIG_I2C_ALGOBIT=m
 # CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_ELV is not set
 # CONFIG_I2C_VELLEMAN is not set
 # CONFIG_SCx200_I2C is not set
 # CONFIG_SCx200_ACB is not set
--- linux-2.6.4/arch/arm/configs/a5k_defconfig~	2004-03-16 20:04:47.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/a5k_defconfig	2004-03-16 20:04:49.000000000 +0000
@@ -318,7 +318,6 @@
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
 # CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_ELV is not set
 # CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_ALGOPCF is not set
 CONFIG_I2C_CHARDEV=y
--- linux-2.6.4/arch/arm/configs/pfs168_mqtft_defconfig~	2004-03-16 20:04:53.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/pfs168_mqtft_defconfig	2004-03-16 20:04:55.000000000 +0000
@@ -507,7 +507,6 @@
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
 # CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_ELV is not set
 # CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_ASSABET is not set
 CONFIG_I2C_PFS168=y
--- linux-2.6.4/arch/arm/configs/pfs168_satft_defconfig~	2004-03-16 20:05:09.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/pfs168_satft_defconfig	2004-03-16 20:05:11.000000000 +0000
@@ -507,7 +507,6 @@
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
 # CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_ELV is not set
 # CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_ASSABET is not set
 CONFIG_I2C_PFS168=y
--- linux-2.6.4/arch/arm/configs/clps7500_defconfig~	2004-03-16 20:05:14.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/clps7500_defconfig	2004-03-16 20:05:15.000000000 +0000
@@ -341,7 +341,6 @@
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
 # CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_ELV is not set
 # CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_ALGOPCF is not set
 # CONFIG_I2C_CHARDEV is not set
--- linux-2.6.4/arch/arm/configs/neponset_defconfig~	2004-03-16 20:05:18.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/neponset_defconfig	2004-03-16 20:05:20.000000000 +0000
@@ -500,7 +500,6 @@
 #
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
-# CONFIG_I2C_ELV is not set
 # CONFIG_I2C_VELLEMAN is not set
 # CONFIG_SCx200_ACB is not set
 CONFIG_I2C_BIT_SA1100_GPIO=y
--- linux-2.6.4/arch/arm/configs/badge4_defconfig~	2004-03-16 20:05:28.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/badge4_defconfig	2004-03-16 20:05:30.000000000 +0000
@@ -691,7 +691,6 @@
 CONFIG_I2C=m
 CONFIG_I2C_ALGOBIT=m
 # CONFIG_I2C_PHILIPSPAR is not set
-CONFIG_I2C_ELV=m
 CONFIG_I2C_VELLEMAN=m
 # CONFIG_I2C_BIT_SA1100_GPIO is not set
 CONFIG_I2C_ALGOPCF=m
--- linux-2.6.4/arch/ppc/configs/power3_defconfig~	2004-03-16 20:05:34.000000000 +0000
+++ linux-2.6.4/arch/ppc/configs/power3_defconfig	2004-03-16 20:05:36.000000000 +0000
@@ -621,7 +621,6 @@
 # CONFIG_I2C_ALI15X3 is not set
 # CONFIG_I2C_AMD756 is not set
 # CONFIG_I2C_AMD8111 is not set
-# CONFIG_I2C_ELV is not set
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
 # CONFIG_I2C_ISA is not set
--- linux-2.6.4/arch/arm26/defconfig~	2004-03-16 20:05:42.000000000 +0000
+++ linux-2.6.4/arch/arm26/defconfig	2004-03-16 20:05:44.000000000 +0000
@@ -186,7 +186,6 @@
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
 # CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_ELV is not set
 # CONFIG_I2C_VELLEMAN is not set
 CONFIG_I2C_ALGOPCF=y
 # CONFIG_I2C_ELEKTOR is not set
--- linux-2.6.4/arch/ia64/configs/zx1_defconfig~	2004-03-16 20:06:14.000000000 +0000
+++ linux-2.6.4/arch/ia64/configs/zx1_defconfig	2004-03-16 20:06:16.000000000 +0000
@@ -618,7 +618,6 @@
 # CONFIG_I2C_ALI15X3 is not set
 # CONFIG_I2C_AMD756 is not set
 # CONFIG_I2C_AMD8111 is not set
-# CONFIG_I2C_ELV is not set
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
 # CONFIG_I2C_ISA is not set
--- linux-2.6.4/arch/ppc64/configs/g5_defconfig~	2004-03-16 20:06:24.000000000 +0000
+++ linux-2.6.4/arch/ppc64/configs/g5_defconfig	2004-03-16 20:06:25.000000000 +0000
@@ -612,7 +612,6 @@
 # CONFIG_I2C_ALI15X3 is not set
 # CONFIG_I2C_AMD756 is not set
 # CONFIG_I2C_AMD8111 is not set
-# CONFIG_I2C_ELV is not set
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
 # CONFIG_I2C_ISA is not set
--- linux-2.6.4/arch/ppc64/configs/pSeries_defconfig~	2004-03-16 20:06:29.000000000 +0000
+++ linux-2.6.4/arch/ppc64/configs/pSeries_defconfig	2004-03-16 20:06:31.000000000 +0000
@@ -666,7 +666,6 @@
 # CONFIG_I2C_ALI15X3 is not set
 # CONFIG_I2C_AMD756 is not set
 # CONFIG_I2C_AMD8111 is not set
-# CONFIG_I2C_ELV is not set
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
 # CONFIG_I2C_ISA is not set
--- linux-2.6.4/arch/ppc64/defconfig~	2004-03-16 20:06:34.000000000 +0000
+++ linux-2.6.4/arch/ppc64/defconfig	2004-03-16 20:06:35.000000000 +0000
@@ -666,7 +666,6 @@
 # CONFIG_I2C_ALI15X3 is not set
 # CONFIG_I2C_AMD756 is not set
 # CONFIG_I2C_AMD8111 is not set
-# CONFIG_I2C_ELV is not set
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
 # CONFIG_I2C_ISA is not set
--- linux-2.6.4/arch/sparc64/defconfig~	2004-03-16 20:06:40.000000000 +0000
+++ linux-2.6.4/arch/sparc64/defconfig	2004-03-16 20:06:42.000000000 +0000
@@ -1074,7 +1074,6 @@
 CONFIG_I2C_ALI15X3=m
 CONFIG_I2C_AMD756=m
 CONFIG_I2C_AMD8111=m
-CONFIG_I2C_ELV=m
 CONFIG_I2C_I801=m
 CONFIG_I2C_I810=m
 CONFIG_I2C_ISA=m
--- linux-2.6.4/arch/arm/configs/pfs168_sastn_defconfig~	2004-03-16 20:07:57.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/pfs168_sastn_defconfig	2004-03-16 20:08:02.000000000 +0000
@@ -507,8 +507,6 @@
 #
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
-# CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_ASSABET is not set
 # CONFIG_I2C_ALGOPCF is not set
 CONFIG_I2C_CHARDEV=y
--- linux-2.6.4/arch/arm/configs/rpc_defconfig~	2004-03-16 20:08:47.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/rpc_defconfig	2004-03-16 20:08:50.000000000 +0000
@@ -462,8 +462,6 @@
 #
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
-# CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_VELLEMAN is not set
 # CONFIG_SCx200_ACB is not set
 # CONFIG_I2C_ALGOPCF is not set
 CONFIG_I2C_CHARDEV=y
--- linux-2.6.4/arch/arm/configs/pfs168_mqvga_defconfig~	2004-03-16 20:08:50.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/pfs168_mqvga_defconfig	2004-03-16 20:08:52.000000000 +0000
@@ -506,8 +506,6 @@
 #
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
-# CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_ASSABET is not set
 CONFIG_I2C_PFS168=y
 # CONFIG_I2C_ALGOPCF is not set
--- linux-2.6.4/arch/arm/configs/trizeps_defconfig~	2004-03-16 20:08:52.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/trizeps_defconfig	2004-03-16 20:08:55.000000000 +0000
@@ -624,8 +624,6 @@
 #
 CONFIG_I2C=m
 CONFIG_I2C_ALGOBIT=m
-# CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_VELLEMAN is not set
 # CONFIG_SCx200_I2C is not set
 # CONFIG_SCx200_ACB is not set
 # CONFIG_I2C_BIT_SA1100_GPIO is not set
--- linux-2.6.4/arch/arm/configs/a5k_defconfig~	2004-03-16 20:08:55.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/a5k_defconfig	2004-03-16 20:08:57.000000000 +0000
@@ -317,8 +317,6 @@
 #
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
-# CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_ALGOPCF is not set
 CONFIG_I2C_CHARDEV=y
 
--- linux-2.6.4/arch/arm/configs/pfs168_mqtft_defconfig~	2004-03-16 20:08:57.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/pfs168_mqtft_defconfig	2004-03-16 20:08:59.000000000 +0000
@@ -506,8 +506,6 @@
 #
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
-# CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_ASSABET is not set
 CONFIG_I2C_PFS168=y
 # CONFIG_I2C_ALGOPCF is not set
--- linux-2.6.4/arch/arm/configs/pfs168_satft_defconfig~	2004-03-16 20:08:59.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/pfs168_satft_defconfig	2004-03-16 20:09:01.000000000 +0000
@@ -506,8 +506,6 @@
 #
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
-# CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_ASSABET is not set
 CONFIG_I2C_PFS168=y
 # CONFIG_I2C_ALGOPCF is not set
--- linux-2.6.4/arch/arm/configs/clps7500_defconfig~	2004-03-16 20:09:01.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/clps7500_defconfig	2004-03-16 20:09:03.000000000 +0000
@@ -340,8 +340,6 @@
 #
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
-# CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_ALGOPCF is not set
 # CONFIG_I2C_CHARDEV is not set
 
--- linux-2.6.4/arch/arm/configs/neponset_defconfig~	2004-03-16 20:09:03.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/neponset_defconfig	2004-03-16 20:09:09.000000000 +0000
@@ -500,7 +500,6 @@
 #
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
-# CONFIG_I2C_VELLEMAN is not set
 # CONFIG_SCx200_ACB is not set
 CONFIG_I2C_BIT_SA1100_GPIO=y
 # CONFIG_I2C_ALGOPCF is not set
--- linux-2.6.4/arch/arm/configs/badge4_defconfig~	2004-03-16 20:09:09.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/badge4_defconfig	2004-03-16 20:09:13.000000000 +0000
@@ -690,8 +690,6 @@
 #
 CONFIG_I2C=m
 CONFIG_I2C_ALGOBIT=m
-# CONFIG_I2C_PHILIPSPAR is not set
-CONFIG_I2C_VELLEMAN=m
 # CONFIG_I2C_BIT_SA1100_GPIO is not set
 CONFIG_I2C_ALGOPCF=m
 CONFIG_I2C_ELEKTOR=m
--- linux-2.6.4/arch/ppc/configs/power3_defconfig~	2004-03-16 20:09:22.000000000 +0000
+++ linux-2.6.4/arch/ppc/configs/power3_defconfig	2004-03-16 20:09:28.000000000 +0000
@@ -626,7 +626,6 @@
 # CONFIG_I2C_ISA is not set
 # CONFIG_I2C_KEYWEST is not set
 # CONFIG_I2C_NFORCE2 is not set
-# CONFIG_I2C_PHILIPSPAR is not set
 # CONFIG_I2C_PIIX4 is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
@@ -634,7 +633,6 @@
 # CONFIG_I2C_SIS5595 is not set
 # CONFIG_I2C_SIS630 is not set
 # CONFIG_I2C_SIS96X is not set
-# CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_VIA is not set
 # CONFIG_I2C_VIAPRO is not set
 # CONFIG_I2C_VOODOO3 is not set
--- linux-2.6.4/arch/ia64/configs/zx1_defconfig~	2004-03-16 20:09:28.000000000 +0000
+++ linux-2.6.4/arch/ia64/configs/zx1_defconfig	2004-03-16 20:09:35.000000000 +0000
@@ -629,7 +629,6 @@
 # CONFIG_I2C_SIS5595 is not set
 # CONFIG_I2C_SIS630 is not set
 # CONFIG_I2C_SIS96X is not set
-# CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_VIA is not set
 # CONFIG_I2C_VIAPRO is not set
 # CONFIG_I2C_VOODOO3 is not set
--- linux-2.6.4/arch/arm26/defconfig~	2004-03-16 20:09:35.000000000 +0000
+++ linux-2.6.4/arch/arm26/defconfig	2004-03-16 20:09:38.000000000 +0000
@@ -185,8 +185,6 @@
 #
 CONFIG_I2C=y
 CONFIG_I2C_ALGOBIT=y
-# CONFIG_I2C_PHILIPSPAR is not set
-# CONFIG_I2C_VELLEMAN is not set
 CONFIG_I2C_ALGOPCF=y
 # CONFIG_I2C_ELEKTOR is not set
 CONFIG_I2C_CHARDEV=y
--- linux-2.6.4/arch/ppc64/configs/g5_defconfig~	2004-03-16 20:09:38.000000000 +0000
+++ linux-2.6.4/arch/ppc64/configs/g5_defconfig	2004-03-16 20:09:42.000000000 +0000
@@ -624,7 +624,6 @@
 # CONFIG_I2C_SIS5595 is not set
 # CONFIG_I2C_SIS630 is not set
 # CONFIG_I2C_SIS96X is not set
-# CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_VIA is not set
 # CONFIG_I2C_VIAPRO is not set
 # CONFIG_I2C_VOODOO3 is not set
--- linux-2.6.4/arch/ppc64/configs/pSeries_defconfig~	2004-03-16 20:09:42.000000000 +0000
+++ linux-2.6.4/arch/ppc64/configs/pSeries_defconfig	2004-03-16 20:09:46.000000000 +0000
@@ -677,7 +677,6 @@
 # CONFIG_I2C_SIS5595 is not set
 # CONFIG_I2C_SIS630 is not set
 # CONFIG_I2C_SIS96X is not set
-# CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_VIA is not set
 # CONFIG_I2C_VIAPRO is not set
 # CONFIG_I2C_VOODOO3 is not set
--- linux-2.6.4/arch/ppc64/defconfig~	2004-03-16 20:09:46.000000000 +0000
+++ linux-2.6.4/arch/ppc64/defconfig	2004-03-16 20:09:49.000000000 +0000
@@ -677,7 +677,6 @@
 # CONFIG_I2C_SIS5595 is not set
 # CONFIG_I2C_SIS630 is not set
 # CONFIG_I2C_SIS96X is not set
-# CONFIG_I2C_VELLEMAN is not set
 # CONFIG_I2C_VIA is not set
 # CONFIG_I2C_VIAPRO is not set
 # CONFIG_I2C_VOODOO3 is not set
--- linux-2.6.4/arch/sparc64/defconfig~	2004-03-16 20:09:50.000000000 +0000
+++ linux-2.6.4/arch/sparc64/defconfig	2004-03-16 20:09:57.000000000 +0000
@@ -1078,7 +1078,6 @@
 CONFIG_I2C_I810=m
 CONFIG_I2C_ISA=m
 CONFIG_I2C_NFORCE2=m
-CONFIG_I2C_PHILIPSPAR=m
 CONFIG_I2C_PARPORT=m
 CONFIG_I2C_PARPORT_LIGHT=m
 CONFIG_I2C_PROSAVAGE=m
@@ -1087,7 +1086,6 @@
 CONFIG_I2C_SIS5595=m
 CONFIG_I2C_SIS630=m
 CONFIG_I2C_SIS96X=m
-CONFIG_I2C_VELLEMAN=m
 CONFIG_I2C_VIA=m
 CONFIG_I2C_VIAPRO=m
 CONFIG_I2C_VOODOO3=m
--- linux-2.6.4/arch/arm/configs/ebsa110_defconfig~	2004-03-16 20:11:21.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/ebsa110_defconfig	2004-03-16 20:11:24.000000000 +0000
@@ -475,7 +475,6 @@
 # CONFIG_ADVANTECH_WDT is not set
 # CONFIG_60XX_WDT is not set
 # CONFIG_MIXCOMWD is not set
-# CONFIG_I810_TCO is not set
 # CONFIG_MACHZ_WDT is not set
 # CONFIG_INTEL_RNG is not set
 # CONFIG_NVRAM is not set
--- linux-2.6.4/arch/arm/configs/netwinder_defconfig~	2004-03-16 20:11:24.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/netwinder_defconfig	2004-03-16 20:11:26.000000000 +0000
@@ -617,7 +617,6 @@
 CONFIG_977_WATCHDOG=y
 # CONFIG_EUROTECH_WDT is not set
 # CONFIG_IB700_WDT is not set
-# CONFIG_I810_TCO is not set
 # CONFIG_MIXCOMWD is not set
 # CONFIG_SCx200_WDT is not set
 # CONFIG_60XX_WDT is not set
--- linux-2.6.4/arch/arm/configs/shannon_defconfig~	2004-03-16 20:11:26.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/shannon_defconfig	2004-03-16 20:11:29.000000000 +0000
@@ -476,7 +476,6 @@
 CONFIG_SA1100_WATCHDOG=y
 # CONFIG_EUROTECH_WDT is not set
 # CONFIG_IB700_WDT is not set
-# CONFIG_I810_TCO is not set
 # CONFIG_MIXCOMWD is not set
 # CONFIG_60XX_WDT is not set
 # CONFIG_W83877F_WDT is not set
--- linux-2.6.4/arch/arm/configs/cerfcube_defconfig~	2004-03-16 20:11:29.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/cerfcube_defconfig	2004-03-16 20:11:31.000000000 +0000
@@ -573,7 +573,6 @@
 CONFIG_SA1100_WATCHDOG=m
 # CONFIG_EUROTECH_WDT is not set
 # CONFIG_IB700_WDT is not set
-# CONFIG_I810_TCO is not set
 # CONFIG_MIXCOMWD is not set
 # CONFIG_SCx200_WDT is not set
 # CONFIG_60XX_WDT is not set
--- linux-2.6.4/arch/arm/configs/footbridge_defconfig~	2004-03-16 20:11:31.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/footbridge_defconfig	2004-03-16 20:11:34.000000000 +0000
@@ -525,7 +525,6 @@
 # CONFIG_ACQUIRE_WDT is not set
 # CONFIG_60XX_WDT is not set
 # CONFIG_MIXCOMWD is not set
-# CONFIG_I810_TCO is not set
 CONFIG_21285_WATCHDOG=m
 CONFIG_977_WATCHDOG=m
 CONFIG_DS1620=y
--- linux-2.6.4/arch/arm/configs/neponset_defconfig~	2004-03-16 20:11:34.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/neponset_defconfig	2004-03-16 20:11:37.000000000 +0000
@@ -534,7 +534,6 @@
 CONFIG_SA1100_WATCHDOG=m
 # CONFIG_EUROTECH_WDT is not set
 # CONFIG_IB700_WDT is not set
-# CONFIG_I810_TCO is not set
 # CONFIG_MIXCOMWD is not set
 # CONFIG_SCx200_WDT is not set
 # CONFIG_60XX_WDT is not set
--- linux-2.6.4/arch/arm/configs/badge4_defconfig~	2004-03-16 20:11:37.000000000 +0000
+++ linux-2.6.4/arch/arm/configs/badge4_defconfig	2004-03-16 20:11:39.000000000 +0000
@@ -732,7 +732,6 @@
 CONFIG_SA1100_WATCHDOG=m
 # CONFIG_EUROTECH_WDT is not set
 # CONFIG_IB700_WDT is not set
-# CONFIG_I810_TCO is not set
 # CONFIG_MIXCOMWD is not set
 # CONFIG_60XX_WDT is not set
 # CONFIG_W83877F_WDT is not set
--- linux-2.6.4/arch/ppc/configs/ash_defconfig~	2004-03-16 20:11:39.000000000 +0000
+++ linux-2.6.4/arch/ppc/configs/ash_defconfig	2004-03-16 20:11:41.000000000 +0000
@@ -400,7 +400,6 @@
 # CONFIG_ADVANTECH_WDT is not set
 # CONFIG_EUROTECH_WDT is not set
 # CONFIG_IB700_WDT is not set
-# CONFIG_I810_TCO is not set
 # CONFIG_MIXCOMWD is not set
 # CONFIG_SCx200_WDT is not set
 # CONFIG_60XX_WDT is not set
--- linux-2.6.4/arch/ppc/configs/rainier_defconfig~	2004-03-16 20:11:41.000000000 +0000
+++ linux-2.6.4/arch/ppc/configs/rainier_defconfig	2004-03-16 20:11:43.000000000 +0000
@@ -436,7 +436,6 @@
 # CONFIG_ADVANTECH_WDT is not set
 # CONFIG_EUROTECH_WDT is not set
 # CONFIG_IB700_WDT is not set
-# CONFIG_I810_TCO is not set
 # CONFIG_MIXCOMWD is not set
 # CONFIG_SCx200_WDT is not set
 # CONFIG_60XX_WDT is not set
--- linux-2.6.4/arch/ppc/configs/cedar_defconfig~	2004-03-16 20:11:43.000000000 +0000
+++ linux-2.6.4/arch/ppc/configs/cedar_defconfig	2004-03-16 20:11:46.000000000 +0000
@@ -366,7 +366,6 @@
 # CONFIG_ADVANTECH_WDT is not set
 # CONFIG_EUROTECH_WDT is not set
 # CONFIG_IB700_WDT is not set
-# CONFIG_I810_TCO is not set
 # CONFIG_MIXCOMWD is not set
 # CONFIG_SCx200_WDT is not set
 # CONFIG_60XX_WDT is not set
--- linux-2.6.4/arch/i386/defconfig~	2004-03-16 20:15:02.000000000 +0000
+++ linux-2.6.4/arch/i386/defconfig	2004-03-16 20:15:06.000000000 +0000
@@ -66,7 +66,6 @@
 # CONFIG_MK6 is not set
 # CONFIG_MK7 is not set
 # CONFIG_MK8 is not set
-# CONFIG_MELAN is not set
 # CONFIG_MCRUSOE is not set
 # CONFIG_MWINCHIPC6 is not set
 # CONFIG_MWINCHIP2 is not set
