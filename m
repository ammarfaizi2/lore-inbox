Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbULAWNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbULAWNh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbULAWNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:13:37 -0500
Received: from b.mail.sonic.net ([64.142.19.5]:49617 "EHLO b.mail.sonic.net")
	by vger.kernel.org with ESMTP id S261406AbULAWKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:10:54 -0500
Date: Wed, 1 Dec 2004 14:10:51 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.28 compile problem with gcc-3.4.3
Message-ID: <20041201221051.GR790@thune.sonic.net>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Apparently, when building for a 386 kernel with gcc-3.4.3, rwsem-spinlock.c
fails to build.

.config and typescript attached.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
CONFIG_M386=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_CMPXCHG is not set
# CONFIG_X86_XADD is not set
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_RWSEM_GENERIC_SPINLOCK=y
# CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
CONFIG_X86_PPRO_FENCE=y
# CONFIG_X86_F00F_WORKS_OK is not set
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
# CONFIG_X86_TSC_DISABLE is not set

#
# General setup
#
# CONFIG_NET is not set
# CONFIG_PCI is not set
# CONFIG_ISA is not set
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_SYSVIPC is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_SYSCTL is not set
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_ELF is not set
# CONFIG_BINFMT_MISC is not set
# CONFIG_OOM_KILLER is not set
# CONFIG_PM is not set
# CONFIG_APM is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_CISS_MONITOR_THREAD is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
# CONFIG_IDE is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# ISDN subsystem
#

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
# CONFIG_VT is not set
# CONFIG_SERIAL is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_UNIX98_PTYS is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set

#
# Input core support is needed for gameports
#

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200 is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set

#
# Direct Rendering Manager (XFree86 DRI support)
#
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_OBMOUSE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
# CONFIG_PROC_FS is not set
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_EXT2_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_XFS_FS is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_TRACE is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_SMB_FS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
# CONFIG_NLS is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=0

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=typescript
Content-Transfer-Encoding: quoted-printable

Script started on Wed Dec  1 14:04:16 2004
nexus@marlis=1B[3m[2:04pm]=1B[23m=1B[4msrc/linux-basic/linux-basic-2.4.28=
=1B[24m(501) make bzImage CC=3Di386 =08-linux-gcc-3.4.3=0D=0D
=2E scripts/mkversion > .tmpversion=0D
i386-linux-gcc-3.4.3 -D__KERNEL__ -I/usr/src/linux-basic/linux-basic-2.4.28=
/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing =
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -marc=
h=3Di386 -fno-unit-at-a-time  -DUTS_MACHINE=3D'"i386"' -DKBUILD_BASENAME=3D=
version -c -o init/version.o init/version.c=0D
make CFLAGS=3D"-D__KERNEL__ -I/usr/src/linux-basic/linux-basic-2.4.28/inclu=
de -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-c=
ommon -fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di3=
86 -fno-unit-at-a-time " -C  kernel=0D
make[1]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/kernel=
'=0D
make all_targets=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/kernel=
'=0D
make[2]: Nothing to be done for `all_targets'.=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/kernel'=
=0D
make[1]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/kernel'=
=0D
make CFLAGS=3D"-D__KERNEL__ -I/usr/src/linux-basic/linux-basic-2.4.28/inclu=
de -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-c=
ommon -fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di3=
86 -fno-unit-at-a-time " -C  drivers=0D
make[1]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s'=0D
make -C block=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/block'=0D
make all_targets=0D
make[3]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/block'=0D
make[3]: Nothing to be done for `all_targets'.=0D
make[3]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/block'=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/block'=0D
make -C cdrom=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/cdrom'=0D
make all_targets=0D
make[3]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/cdrom'=0D
make[3]: Nothing to be done for `all_targets'.=0D
make[3]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/cdrom'=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/cdrom'=0D
make -C char=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/char'=0D
make all_targets=0D
make[3]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/char'=0D
make[3]: Nothing to be done for `all_targets'.=0D
make[3]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/char'=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/char'=0D
make -C hotplug=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/hotplug'=0D
make all_targets=0D
make[3]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/hotplug'=0D
make[3]: Nothing to be done for `all_targets'.=0D
make[3]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/hotplug'=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/hotplug'=0D
make -C media=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/media'=0D
make -C radio=0D
make[3]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/media/radio'=0D
make all_targets=0D
make[4]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/media/radio'=0D
make[4]: Nothing to be done for `all_targets'.=0D
make[4]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/media/radio'=0D
make[3]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/media/radio'=0D
make -C video=0D
make[3]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/media/video'=0D
make all_targets=0D
make[4]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/media/video'=0D
make[4]: Nothing to be done for `all_targets'.=0D
make[4]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/media/video'=0D
make[3]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/media/video'=0D
make all_targets=0D
make[3]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/media'=0D
make[3]: Nothing to be done for `all_targets'.=0D
make[3]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/media'=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/media'=0D
make -C misc=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/misc'=0D
make all_targets=0D
make[3]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/misc'=0D
make[3]: Nothing to be done for `all_targets'.=0D
make[3]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/misc'=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/misc'=0D
make -C net=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/net'=0D
make all_targets=0D
make[3]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/net'=0D
make[3]: Nothing to be done for `all_targets'.=0D
make[3]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/net'=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/net'=0D
make -C parport=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/parport'=0D
make all_targets=0D
make[3]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/parport'=0D
make[3]: Nothing to be done for `all_targets'.=0D
make[3]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/parport'=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/parport'=0D
make -C sound=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/sound'=0D
make all_targets=0D
make[3]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s/sound'=0D
make[3]: Nothing to be done for `all_targets'.=0D
make[3]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/sound'=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
/sound'=0D
make all_targets=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/driver=
s'=0D
make[2]: Nothing to be done for `all_targets'.=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
'=0D
make[1]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/drivers=
'=0D
make CFLAGS=3D"-D__KERNEL__ -I/usr/src/linux-basic/linux-basic-2.4.28/inclu=
de -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-c=
ommon -fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di3=
86 -fno-unit-at-a-time " -C  mm=0D
make[1]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/mm'=0D
make all_targets=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/mm'=0D
make[2]: Nothing to be done for `all_targets'.=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/mm'=0D
make[1]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/mm'=0D
make CFLAGS=3D"-D__KERNEL__ -I/usr/src/linux-basic/linux-basic-2.4.28/inclu=
de -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-c=
ommon -fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di3=
86 -fno-unit-at-a-time " -C  fs=0D
make[1]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/fs'=0D
make -C partitions=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/fs/par=
titions'=0D
make all_targets=0D
make[3]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/fs/par=
titions'=0D
make[3]: Nothing to be done for `all_targets'.=0D
make[3]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/fs/part=
itions'=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/fs/part=
itions'=0D
make -C ramfs=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/fs/ram=
fs'=0D
make all_targets=0D
make[3]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/fs/ram=
fs'=0D
make[3]: Nothing to be done for `all_targets'.=0D
make[3]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/fs/ramf=
s'=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/fs/ramf=
s'=0D
make all_targets=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/fs'=0D
make[2]: Nothing to be done for `all_targets'.=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/fs'=0D
make[1]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/fs'=0D
make CFLAGS=3D"-D__KERNEL__ -I/usr/src/linux-basic/linux-basic-2.4.28/inclu=
de -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-c=
ommon -fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di3=
86 -fno-unit-at-a-time " -C  net=0D
make[1]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/net'=0D
make -C core=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/net/co=
re'=0D
make all_targets=0D
make[3]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/net/co=
re'=0D
make[3]: Nothing to be done for `all_targets'.=0D
make[3]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/net/cor=
e'=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/net/cor=
e'=0D
make -C ethernet=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/net/et=
hernet'=0D
make all_targets=0D
make[3]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/net/et=
hernet'=0D
make[3]: Nothing to be done for `all_targets'.=0D
make[3]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/net/eth=
ernet'=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/net/eth=
ernet'=0D
make all_targets=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/net'=0D
make[2]: Nothing to be done for `all_targets'.=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/net'=0D
make[1]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/net'=0D
make CFLAGS=3D"-D__KERNEL__ -I/usr/src/linux-basic/linux-basic-2.4.28/inclu=
de -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-c=
ommon -fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di3=
86 -fno-unit-at-a-time " -C  ipc=0D
make[1]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/ipc'=0D
make all_targets=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/ipc'=0D
make[2]: Nothing to be done for `all_targets'.=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/ipc'=0D
make[1]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/ipc'=0D
make CFLAGS=3D"-D__KERNEL__ -I/usr/src/linux-basic/linux-basic-2.4.28/inclu=
de -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-c=
ommon -fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -march=3Di3=
86 -fno-unit-at-a-time " -C  lib=0D
make[1]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/lib'=0D
make all_targets=0D
make[2]: Entering directory `/usr/src/linux-basic/linux-basic-2.4.28/lib'=0D
i386-linux-gcc-3.4.3 -D__KERNEL__ -I/usr/src/linux-basic/linux-basic-2.4.28=
/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing =
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=3D2 -marc=
h=3Di386 -fno-unit-at-a-time   -nostdinc -iwithprefix include -DKBUILD_BASE=
NAME=3Drwsem_spinlock  -c -o rwsem-spinlock.o rwsem-spinlock.c=0D
rwsem-spinlock.c:36: error: conflicting types for 'init_rwsem'=0D
/usr/src/linux-basic/linux-basic-2.4.28/include/linux/rwsem-spinlock.h:57: =
error: previous declaration of 'init_rwsem' was here=0D
rwsem-spinlock.c:36: error: conflicting types for 'init_rwsem'=0D
/usr/src/linux-basic/linux-basic-2.4.28/include/linux/rwsem-spinlock.h:57: =
error: previous declaration of 'init_rwsem' was here=0D
rwsem-spinlock.c:124: error: conflicting types for '__down_read'=0D
/usr/src/linux-basic/linux-basic-2.4.28/include/linux/rwsem-spinlock.h:58: =
error: previous declaration of '__down_read' was here=0D
rwsem-spinlock.c:124: error: conflicting types for '__down_read'=0D
/usr/src/linux-basic/linux-basic-2.4.28/include/linux/rwsem-spinlock.h:58: =
error: previous declaration of '__down_read' was here=0D
rwsem-spinlock.c:170: error: conflicting types for '__down_read_trylock'=0D
/usr/src/linux-basic/linux-basic-2.4.28/include/linux/rwsem-spinlock.h:59: =
error: previous declaration of '__down_read_trylock' was here=0D
rwsem-spinlock.c:170: error: conflicting types for '__down_read_trylock'=0D
/usr/src/linux-basic/linux-basic-2.4.28/include/linux/rwsem-spinlock.h:59: =
error: previous declaration of '__down_read_trylock' was here=0D
rwsem-spinlock.c:193: error: conflicting types for '__down_write'=0D
/usr/src/linux-basic/linux-basic-2.4.28/include/linux/rwsem-spinlock.h:60: =
error: previous declaration of '__down_write' was here=0D
rwsem-spinlock.c:193: error: conflicting types for '__down_write'=0D
/usr/src/linux-basic/linux-basic-2.4.28/include/linux/rwsem-spinlock.h:60: =
error: previous declaration of '__down_write' was here=0D
rwsem-spinlock.c:239: error: conflicting types for '__down_write_trylock'=0D
/usr/src/linux-basic/linux-basic-2.4.28/include/linux/rwsem-spinlock.h:61: =
error: previous declaration of '__down_write_trylock' was here=0D
rwsem-spinlock.c:239: error: conflicting types for '__down_write_trylock'=0D
/usr/src/linux-basic/linux-basic-2.4.28/include/linux/rwsem-spinlock.h:61: =
error: previous declaration of '__down_write_trylock' was here=0D
rwsem-spinlock.c:261: error: conflicting types for '__up_read'=0D
/usr/src/linux-basic/linux-basic-2.4.28/include/linux/rwsem-spinlock.h:62: =
error: previous declaration of '__up_read' was here=0D
rwsem-spinlock.c:261: error: conflicting types for '__up_read'=0D
/usr/src/linux-basic/linux-basic-2.4.28/include/linux/rwsem-spinlock.h:62: =
error: previous declaration of '__up_read' was here=0D
rwsem-spinlock.c:278: error: conflicting types for '__up_write'=0D
/usr/src/linux-basic/linux-basic-2.4.28/include/linux/rwsem-spinlock.h:63: =
error: previous declaration of '__up_write' was here=0D
rwsem-spinlock.c:278: error: conflicting types for '__up_write'=0D
/usr/src/linux-basic/linux-basic-2.4.28/include/linux/rwsem-spinlock.h:63: =
error: previous declaration of '__up_write' was here=0D
make[2]: *** [rwsem-spinlock.o] Error 1=0D
make[2]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/lib'=0D
make[1]: *** [first_rule] Error 2=0D
make[1]: Leaving directory `/usr/src/linux-basic/linux-basic-2.4.28/lib'=0D
make: *** [_dir_lib] Error 2=0D
12.810u 1.920s 0:23.59 62.4%	0+0k 0+0io 16151pf+0w=0D
nexus@marlis=1B[3m[2:04pm]=1B[23m=1B[4msrc/linux-basic/linux-basic-2.4.28=
=1B[24m(502) ^D=08=08exit=0D

Script done on Wed Dec  1 14:06:41 2004

--fUYQa+Pmc3FrFX/N--
