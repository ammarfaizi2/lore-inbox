Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUAIRGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 12:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUAIRGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 12:06:14 -0500
Received: from mail.zero.ou.edu ([129.15.0.75]:28995 "EHLO r2d2.ou.edu")
	by vger.kernel.org with ESMTP id S261909AbUAIRGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 12:06:03 -0500
Date: Fri, 09 Jan 2004 11:06:01 -0600
From: Steve Kenton <skenton@ou.edu>
Subject: 2.6.1 make defconfig for all arches give 143
 "trying to assign nonexistent symbol" errors
To: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <3FFEDF79.5090309@ou.edu>
Organization: The University Of Oklahoma
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.0.1) Gecko/20020920
 Netscape/7.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.1 make defconfig for all arches give 143 "trying to assign nonexistent symbol" errors
total in 15 different arches, down from 151 in 2.6.0.

alpha		14
arm		37
arm26		29
h8300		2
i386		4
ia64		4
m68k		22
m68knommu	6
mips		4
parisc		4
ppc		1
ppc64		1
sh		7
sparc		3
um		3
x86_64		2
		=
		143

FYI - smk


/spare1/build/src/linux-2.6.1/arch/alpha/defconfig:73: trying to assign nonexistent symbol KCORE_ELF
/spare1/build/src/linux-2.6.1/arch/alpha/defconfig:74: trying to assign nonexistent symbol KCORE_AOUT
/spare1/build/src/linux-2.6.1/arch/alpha/defconfig:95: trying to assign nonexistent symbol PNP_NAMES
/spare1/build/src/linux-2.6.1/arch/alpha/defconfig:147: trying to assign nonexistent symbol BLK_DEV_ISAPNP
/spare1/build/src/linux-2.6.1/arch/alpha/defconfig:231: trying to assign nonexistent symbol SCSI_EATA_DMA
/spare1/build/src/linux-2.6.1/arch/alpha/defconfig:240: trying to assign nonexistent symbol SCSI_NCR53C7xx
/spare1/build/src/linux-2.6.1/arch/alpha/defconfig:242: trying to assign nonexistent symbol SCSI_NCR53C8XX
/spare1/build/src/linux-2.6.1/arch/alpha/defconfig:243: trying to assign nonexistent symbol SCSI_SYM53C8XX
/spare1/build/src/linux-2.6.1/arch/alpha/defconfig:248: trying to assign nonexistent symbol SCSI_NCR53C8XX_IOMAPPED
/spare1/build/src/linux-2.6.1/arch/alpha/defconfig:249: trying to assign nonexistent symbol SCSI_NCR53C8XX_PQS_PDS
/spare1/build/src/linux-2.6.1/arch/alpha/defconfig:250: trying to assign nonexistent symbol SCSI_NCR53C8XX_SYMBIOS_COMPAT
/spare1/build/src/linux-2.6.1/arch/alpha/defconfig:285: trying to assign nonexistent symbol FILTER
/spare1/build/src/linux-2.6.1/arch/alpha/defconfig:325: trying to assign nonexistent symbol IP_NF_MATCH_UNCLEAN
/spare1/build/src/linux-2.6.1/arch/alpha/defconfig:329: trying to assign nonexistent symbol IP_NF_TARGET_MIRROR
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:24: trying to assign nonexistent symbol ARCH_ARCA5K
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:54: trying to assign nonexistent symbol CPU_26
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:60: trying to assign nonexistent symbol CPU_ARM720
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:61: trying to assign nonexistent symbol CPU_ARM920
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:62: trying to assign nonexistent symbol CPU_ARM920_CPU_IDLE
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:63: trying to assign nonexistent symbol CPU_ARM920_I_CACHE_ON
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:64: trying to assign nonexistent symbol CPU_ARM920_D_CACHE_ON
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:65: trying to assign nonexistent symbol CPU_ARM920_WRITETHROUGH
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:71: trying to assign nonexistent symbol ANGELBOOT
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:72: trying to assign nonexistent symbol PCI_INTEGRATOR
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:83: trying to assign nonexistent symbol NWFPE
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:84: trying to assign nonexistent symbol KCORE_ELF
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:85: trying to assign nonexistent symbol KCORE_AOUT
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:106: trying to assign nonexistent symbol MTD_DOC1000
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:128: trying to assign nonexistent symbol MTD_MIXMEM
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:129: trying to assign nonexistent symbol MTD_NORA
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:142: trying to assign nonexistent symbol MTD_ARM
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:169: trying to assign nonexistent symbol NETLINK
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:171: trying to assign nonexistent symbol FILTER
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:184: trying to assign nonexistent symbol KHTTPD
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:245: trying to assign nonexistent symbol EEPRO100_PM
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:252: trying to assign nonexistent symbol RTL8129
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:324: trying to assign nonexistent symbol I2O_LAN
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:343: trying to assign nonexistent symbol SERIAL
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:344: trying to assign nonexistent symbol SERIAL_EXTENDED
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:361: trying to assign nonexistent symbol MOUSE
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:362: trying to assign nonexistent symbol PSMOUSE
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:363: trying to assign nonexistent symbol 82C710_MOUSE
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:364: trying to assign nonexistent symbol PC110_PAD
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:369: trying to assign nonexistent symbol JOYSTICK
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:380: trying to assign nonexistent symbol INTEL_RNG
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:435: trying to assign nonexistent symbol SYSV_FS_WRITE
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:437: trying to assign nonexistent symbol UDF_RW
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:460: trying to assign nonexistent symbol NCPFS_MOUNT_SUBDIR
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:461: trying to assign nonexistent symbol NCPFS_NDS_DOMAINS
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:483: trying to assign nonexistent symbol KMI_KEYB
/spare1/build/src/linux-2.6.1/arch/arm/defconfig:484: trying to assign nonexistent symbol PC_KEYMAP
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:50: trying to assign nonexistent symbol KCORE_ELF
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:51: trying to assign nonexistent symbol KCORE_AOUT
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:56: trying to assign nonexistent symbol ALIGNMENT_TRAP
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:96: trying to assign nonexistent symbol BLK_DEV_LVM
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:101: trying to assign nonexistent symbol BLK_DEV_FD1772
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:102: trying to assign nonexistent symbol BLK_DEV_MFM
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:123: trying to assign nonexistent symbol INPUT_KEYBDEV
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:128: trying to assign nonexistent symbol INPUT_TSLIBDEV
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:145: trying to assign nonexistent symbol SERIO_ACORN
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:165: trying to assign nonexistent symbol ATOMWIDE_SERIAL
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:166: trying to assign nonexistent symbol DUALSP_SERIAL
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:175: trying to assign nonexistent symbol SERIAL_21285_OLD
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:194: trying to assign nonexistent symbol I2C_PROC
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:200: trying to assign nonexistent symbol L3_ALGOBIT
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:201: trying to assign nonexistent symbol L3_BIT_SA1100_GPIO
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:202: trying to assign nonexistent symbol L3_SA1111
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:203: trying to assign nonexistent symbol BIT_SA1100_GPIO
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:209: trying to assign nonexistent symbol PSMOUSE
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:286: trying to assign nonexistent symbol UDF_RW
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:313: trying to assign nonexistent symbol SMB_NLS
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:324: trying to assign nonexistent symbol MCP
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:325: trying to assign nonexistent symbol MCP_SA1100
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:326: trying to assign nonexistent symbol MCP_UCB1200
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:327: trying to assign nonexistent symbol MCP_UCB1200_AUDIO
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:328: trying to assign nonexistent symbol MCP_UCB1200_TS
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:333: trying to assign nonexistent symbol SWITCHES
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:334: trying to assign nonexistent symbol SWITCHES_SA1100
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:335: trying to assign nonexistent symbol SWITCHES_UCB1X00
/spare1/build/src/linux-2.6.1/arch/arm26/defconfig:345: trying to assign nonexistent symbol NO_FRAME_POINTER
/spare1/build/src/linux-2.6.1/arch/h8300/defconfig:53: trying to assign nonexistent symbol KCORE_AOUT
/spare1/build/src/linux-2.6.1/arch/h8300/defconfig:101: trying to assign nonexistent symbol MTD_DOC1000
/spare1/build/src/linux-2.6.1/arch/i386/defconfig:114: trying to assign nonexistent symbol ACPI_HT
/spare1/build/src/linux-2.6.1/arch/i386/defconfig:176: trying to assign nonexistent symbol KCORE_ELF
/spare1/build/src/linux-2.6.1/arch/i386/defconfig:177: trying to assign nonexistent symbol KCORE_AOUT
/spare1/build/src/linux-2.6.1/arch/i386/defconfig:355: trying to assign nonexistent symbol SCSI_SYM53C8XX
/spare1/build/src/linux-2.6.1/arch/ia64/defconfig:992: trying to assign nonexistent symbol IA64_EARLY_PRINTK
/spare1/build/src/linux-2.6.1/arch/ia64/defconfig:993: trying to assign nonexistent symbol IA64_EARLY_PRINTK_UART
/spare1/build/src/linux-2.6.1/arch/ia64/defconfig:994: trying to assign nonexistent symbol IA64_EARLY_PRINTK_UART_BASE
/spare1/build/src/linux-2.6.1/arch/ia64/defconfig:995: trying to assign nonexistent symbol IA64_EARLY_PRINTK_VGA
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:45: trying to assign nonexistent symbol KCORE_ELF
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:46: trying to assign nonexistent symbol KCORE_AOUT
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:81: trying to assign nonexistent symbol NETLINK
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:83: trying to assign nonexistent symbol FILTER
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:89: trying to assign nonexistent symbol IP_ROUTER
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:92: trying to assign nonexistent symbol IP_ALIAS
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:98: trying to assign nonexistent symbol SKB_LARGE
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:100: trying to assign nonexistent symbol KHTTPD
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:138: trying to assign nonexistent symbol SD_EXTRA_DEVS
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:140: trying to assign nonexistent symbol ST_EXTRA_DEVS
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:143: trying to assign nonexistent symbol SR_EXTRA_DEVS
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:188: trying to assign nonexistent symbol BUSMOUSE
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:194: trying to assign nonexistent symbol SUN3X_ZS
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:195: trying to assign nonexistent symbol SUN_KEYBOARD
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:196: trying to assign nonexistent symbol SUN_MOUSE
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:305: trying to assign nonexistent symbol FB_CLGEN
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:316: trying to assign nonexistent symbol FBCON_ADVANCED
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:317: trying to assign nonexistent symbol FBCON_MFB
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:318: trying to assign nonexistent symbol FBCON_AFB
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:319: trying to assign nonexistent symbol FBCON_ILBM
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:320: trying to assign nonexistent symbol FBCON_FONTWIDTH8_ONLY
/spare1/build/src/linux-2.6.1/arch/m68k/defconfig:321: trying to assign nonexistent symbol FBCON_FONTS
/spare1/build/src/linux-2.6.1/arch/m68knommu/defconfig:89: trying to assign nonexistent symbol KCORE_AOUT
/spare1/build/src/linux-2.6.1/arch/m68knommu/defconfig:141: trying to assign nonexistent symbol MTD_DOC1000
/spare1/build/src/linux-2.6.1/arch/m68knommu/defconfig:169: trying to assign nonexistent symbol BLK_DEV_BLKMEM
/spare1/build/src/linux-2.6.1/arch/m68knommu/defconfig:206: trying to assign nonexistent symbol FILTER
/spare1/build/src/linux-2.6.1/arch/m68knommu/defconfig:358: trying to assign nonexistent symbol LEDMAN
/spare1/build/src/linux-2.6.1/arch/m68knommu/defconfig:359: trying to assign nonexistent symbol RESETSWITCH
/spare1/build/src/linux-2.6.1/arch/mips/defconfig:130: trying to assign nonexistent symbol KCORE_ELF
/spare1/build/src/linux-2.6.1/arch/mips/defconfig:390: trying to assign nonexistent symbol SERIAL_IP22_ZILOG
/spare1/build/src/linux-2.6.1/arch/mips/defconfig:440: trying to assign nonexistent symbol INDYDOG
/spare1/build/src/linux-2.6.1/arch/mips/defconfig:450: trying to assign nonexistent symbol SGI_DS1286
/spare1/build/src/linux-2.6.1/arch/parisc/defconfig:455: trying to assign nonexistent symbol HP_SDC
/spare1/build/src/linux-2.6.1/arch/parisc/defconfig:456: trying to assign nonexistent symbol HIL_MLC
/spare1/build/src/linux-2.6.1/arch/parisc/defconfig:467: trying to assign nonexistent symbol KEYBOARD_HIL_OLD
/spare1/build/src/linux-2.6.1/arch/parisc/defconfig:489: trying to assign nonexistent symbol HP_SDC_RTC
/spare1/build/src/linux-2.6.1/arch/ppc/defconfig:708: trying to assign nonexistent symbol MOUSE_PS2_SYNAPTICS
/spare1/build/src/linux-2.6.1/arch/ppc64/defconfig:68: trying to assign nonexistent symbol KCORE_ELF
/spare1/build/src/linux-2.6.1/arch/sh/defconfig:21: trying to assign nonexistent symbol SH_OVERDRIVE
/spare1/build/src/linux-2.6.1/arch/sh/defconfig:47: trying to assign nonexistent symbol KCORE_ELF
/spare1/build/src/linux-2.6.1/arch/sh/defconfig:48: trying to assign nonexistent symbol KCORE_AOUT
/spare1/build/src/linux-2.6.1/arch/sh/defconfig:72: trying to assign nonexistent symbol BLK_DEV_LVM
/spare1/build/src/linux-2.6.1/arch/sh/defconfig:110: trying to assign nonexistent symbol BLK_DEV_ISAPNP
/spare1/build/src/linux-2.6.1/arch/sh/defconfig:169: trying to assign nonexistent symbol SYSV_FS_WRITE
/spare1/build/src/linux-2.6.1/arch/sh/defconfig:171: trying to assign nonexistent symbol UDF_RW
/spare1/build/src/linux-2.6.1/arch/sparc/defconfig:53: trying to assign nonexistent symbol KCORE_ELF
/spare1/build/src/linux-2.6.1/arch/sparc/defconfig:183: trying to assign nonexistent symbol SCSI_NCR53C8XX
/spare1/build/src/linux-2.6.1/arch/sparc/defconfig:214: trying to assign nonexistent symbol FILTER
/spare1/build/src/linux-2.6.1/arch/um/defconfig:9: trying to assign nonexistent symbol CONFIG_LOG_BUF_SHIFT
/spare1/build/src/linux-2.6.1/arch/um/defconfig:37: trying to assign nonexistent symbol PROC_MM
/spare1/build/src/linux-2.6.1/arch/um/defconfig:388: trying to assign nonexistent symbol MTD_DOC1000
/spare1/build/src/linux-2.6.1/arch/x86_64/defconfig:82: trying to assign nonexistent symbol ACPI_HT
/spare1/build/src/linux-2.6.1/arch/x86_64/defconfig:748: trying to assign nonexistent symbol MCE_DEBUG


