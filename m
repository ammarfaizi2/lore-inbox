Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318539AbSHQI6p>; Sat, 17 Aug 2002 04:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319368AbSHQI6p>; Sat, 17 Aug 2002 04:58:45 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:36363 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318539AbSHQI6n>; Sat, 17 Aug 2002 04:58:43 -0400
Date: Sat, 17 Aug 2002 11:02:01 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: 2.4.20-pre3 hangs after 'apm: disabled - apm is not SMP safe (power off active)'
Message-ID: <20020817090201.GA933@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It hangs during boot right after the message

apm: disabled - apm is not SMP safe (power off active).
This same setup did work find on 2.4.20pre1-ac1.

Here is the .config:

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_ISA=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
CONFIG_SYN_COOKIES=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_DE4X5=m
CONFIG_8139TOO=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_CHARDEV=m
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_RTC=m
CONFIG_AGP=m
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_MGA=m
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_SUN12x22=y
CONFIG_SOUND=y
CONFIG_SOUND_OSS=m
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=y
CONFIG_USB_STORAGE=y
CONFIG_USB_PRINTER=y
CONFIG_USB_SCANNER=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

This is on an Abit VP6 board, dual P3/700 cpus.

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
00:0a.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c860 (rev 13)
00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
00:0e.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 03)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 03)


Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)
GNU ld version 2.12.90.0.15 20020717 Debian GNU/Linux

Good luck,
Jurriaan
-- 
She looked away from him, the wall suddenly fascinating in its flat lack
of anything interesting. The silence stretched out for minutes on end.
	Michelle West - The Uncrowned King
GNU/Linux 2.4.20-pre1-ac1 SMP/ReiserFS 2x1402 bogomips load av: 0.37 0.72 0.76
