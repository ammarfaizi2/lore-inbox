Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTLCT42 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 14:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbTLCT42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 14:56:28 -0500
Received: from mailrelay03.sunrise.ch ([194.158.229.31]:39361 "EHLO
	obelix.spectraweb.ch") by vger.kernel.org with ESMTP
	id S261950AbTLCT4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 14:56:19 -0500
Message-ID: <3FCE3FDE.8040308@swoopy.net>
Date: Wed, 03 Dec 2003 20:56:14 +0100
From: "S.W." <linux-kernel@swoopy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11 USB Sony Digicam
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mounting a Sony DSC-P1 is not possible to me with 2.6.0-test11

syslog:
=======
kernel: hub 1-0:1.0: new USB device on port 2, assigned address 3
kernel: scsi1 : SCSI emulation for USB Mass Storage devices
kernel:   Vendor: Sony      Model: Sony DSC          Rev: 2.10
kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
kernel: SCSI device sdb: 15840 512-byte hdwr sectors (8 MB)
kernel: sdb: Write Protect is off
kernel: sdb: Mode Sense: 00 32 00 00
kernel: sdb: assuming drive cache: write through
kernel: SCSI device (ioctl) reports ILLEGAL REQUEST.
kernel: SCSI device sdb: 15840 512-byte hdwr sectors (8 MB)
kernel: sdb: Write Protect is off
kernel: sdb: Mode Sense: 00 32 00 00
kernel: sdb: assuming drive cache: write through
kernel: SCSI device sdb: 15840 512-byte hdwr sectors (8 MB)
kernel: sdb: Write Protect is off
kernel: sdb: Mode Sense: 00 32 00 00
kernel: sdb: assuming drive cache: write through
kernel:  sdb:<3>Buffer I/O error on device sdb, logical block 0
kernel: Buffer I/O error on device sdb, logical block 0
kernel:  unable to read partition table
kernel:  sdb:<3>Buffer I/O error on device sdb, logical block 0
kernel:  unable to read partition table
kernel: Attached scsi removable disk sdb at scsi1, channel 0, id 0, lun 0
kernel: Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
kernel: WARNING: USB Mass Storage data integrity not assured
kernel: USB Mass Storage device found at 3
kernel: SCSI device (ioctl) reports ILLEGAL REQUEST.
kernel: SCSI device sdb: 15840 512-byte hdwr sectors (8 MB)
kernel: sdb: Write Protect is off
kernel: sdb: Mode Sense: 00 32 00 00
kernel: sdb: assuming drive cache: write through
kernel: SCSI device sdb: 15840 512-byte hdwr sectors (8 MB)
kernel: sdb: Write Protect is off
kernel: sdb: Mode Sense: 00 32 00 00
kernel: sdb: assuming drive cache: write through
kernel:  sdb:<3>Buffer I/O error on device sdb, logical block 0
kernel: Buffer I/O error on device sdb, logical block 0
kernel:  unable to read partition table
kernel: SCSI device (ioctl) reports ILLEGAL REQUEST.
kernel: SCSI device sdb: 15840 512-byte hdwr sectors (8 MB)
kernel: sdb: Write Protect is off
kernel: sdb: Mode Sense: 00 32 00 00
kernel: sdb: assuming drive cache: write through
kernel: SCSI device sdb: 15840 512-byte hdwr sectors (8 MB)
kernel: sdb: Write Protect is off
kernel: sdb: Mode Sense: 00 32 00 00
kernel: sdb: assuming drive cache: write through
kernel:  sdb:<3>Buffer I/O error on device sdb, logical block 0
kernel: Buffer I/O error on device sdb, logical block 0
kernel:  unable to read partition table
kernel: SCSI device (ioctl) reports ILLEGAL REQUEST.
kernel: SCSI device sdb: 15840 512-byte hdwr sectors (8 MB)
kernel: sdb: Write Protect is off
kernel: sdb: Mode Sense: 00 32 00 00
kernel: sdb: assuming drive cache: write through
kernel: SCSI device sdb: 15840 512-byte hdwr sectors (8 MB)
kernel: sdb: Write Protect is off
kernel: sdb: Mode Sense: 00 32 00 00
kernel: sdb: assuming drive cache: write through
kernel:  sdb:<3>Buffer I/O error on device sdb, logical block 0
kernel: Buffer I/O error on device sdb, logical block 0
kernel:  unable to read partition table
kernel: Buffer I/O error on device sdb, logical block 0
kernel: Buffer I/O error on device sdb, logical block 1
kernel: Buffer I/O error on device sdb, logical block 2
kernel: Buffer I/O error on device sdb, logical block 3
kernel: Buffer I/O error on device sdb, logical block 4
kernel: Buffer I/O error on device sdb, logical block 5
kernel: Buffer I/O error on device sdb, logical block 6
kernel: Buffer I/O error on device sdb, logical block 7
kernel: Buffer I/O error on device sdb, logical block 8
kernel: Buffer I/O error on device sdb, logical block 9
kernel: Buffer I/O error on device sdb, logical block 10
kernel: Buffer I/O error on device sdb, logical block 11
kernel: Buffer I/O error on device sdb, logical block 12
kernel: Buffer I/O error on device sdb, logical block 13
kernel: Buffer I/O error on device sdb, logical block 14
kernel: Buffer I/O error on device sdb, logical block 15

lspci -v
========
00:1f.2 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB 
(Hub A) (rev 11) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 8027
         Flags: bus master, medium devsel, latency 0, IRQ 9
         I/O ports at b400 [size=32]


.config
=======
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_LBD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_HW_RANDOM=m
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_MGA=y
CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_ENS1370=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=y
CONFIG_NTFS_RW=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=m
CONFIG_NFSD=m
CONFIG_LOCKD=m
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SMB_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=y
CONFIG_NTFS_RW=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=m
CONFIG_NFSD=m
CONFIG_LOCKD=m
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SMB_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRC32=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

