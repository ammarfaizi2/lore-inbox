Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129716AbQK1HC3>; Tue, 28 Nov 2000 02:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129905AbQK1HCT>; Tue, 28 Nov 2000 02:02:19 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:266 "EHLO
        smtp.lax.megapath.net") by vger.kernel.org with ESMTP
        id <S129716AbQK1HCK>; Tue, 28 Nov 2000 02:02:10 -0500
Message-ID: <3A23FC14.8020403@megapathdsl.net>
Date: Tue, 28 Nov 2000 10:40:20 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test5 i686; en-US; m18) Gecko/20001127
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test12-pre2 -- Broken build.  Many definitions redefined
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686 
-DEXPORT_SYMTAB -c sys.cIn file included from 
/usr/src/linux/include/linux/wait.h:19,
                  from /usr/src/linux/include/linux/fs.h:12,
                  from /usr/src/linux/include/linux/capability.h:17,
                  from /usr/src/linux/include/linux/binfmts.h:5,
                  from /usr/src/linux/include/linux/sched.h:9,
                  from /usr/src/linux/include/linux/mm.h:4,
                  from sys.c:8:
/usr/src/linux/include/asm/processor.h:78: warning: `cpu_data' redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:76: warning: this is 
the location of the previous definition
In file included from /usr/src/linux/include/linux/sched.h:22,
                  from /usr/src/linux/include/linux/mm.h:4,
                  from sys.c:8:
/usr/src/linux/include/linux/smp.h:80: warning: `smp_num_cpus' redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:80: warning: this is 
the location of the previous definition
/usr/src/linux/include/linux/smp.h:87: warning: `smp_call_function' 
redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:96: warning: this is 
the location of the previous definition
/usr/src/linux/include/linux/smp.h:88: warning: `cpu_online_map' redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:82: warning: this is 
the location of the previous definition
In file included from /usr/src/linux/include/linux/sched.h:79,
                  from /usr/src/linux/include/linux/mm.h:4,
                  from sys.c:8:
/usr/src/linux/include/linux/timer.h:34: warning: `del_timer_sync' redefined
/usr/src/linux/include/linux/modules/ksyms.ver:504: warning: this is the 
location of the previous definition
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686 
-DEXPORT_SYMTAB -c kmod.c
In file included from /usr/src/linux/include/linux/wait.h:19,
                  from /usr/src/linux/include/linux/fs.h:12,
                  from /usr/src/linux/include/linux/capability.h:17,
                  from /usr/src/linux/include/linux/binfmts.h:5,
                  from /usr/src/linux/include/linux/sched.h:9,
                  from kmod.c:20:
/usr/src/linux/include/asm/processor.h:78: warning: `cpu_data' redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:76: warning: this is 
the location of the previous definition
In file included from /usr/src/linux/include/linux/sched.h:22,
                  from kmod.c:20:
/usr/src/linux/include/linux/smp.h:80: warning: `smp_num_cpus' redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:80: warning: this is 
the location of the previous definition
/usr/src/linux/include/linux/smp.h:87: warning: `smp_call_function' 
redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:96: warning: this is 
the location of the previous definition
/usr/src/linux/include/linux/smp.h:88: warning: `cpu_online_map' redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:82: warning: this is 
the location of the previous definition
In file included from /usr/src/linux/include/linux/sched.h:79,
                  from kmod.c:20:
/usr/src/linux/include/linux/timer.h:34: warning: `del_timer_sync' redefined
/usr/src/linux/include/linux/modules/ksyms.ver:504: warning: this is the 
location of the previous definition
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686 
-DEXPORT_SYMTAB -c context.c
In file included from /usr/src/linux/include/linux/wait.h:19,
                  from /usr/src/linux/include/linux/fs.h:12,
                  from /usr/src/linux/include/linux/capability.h:17,
                  from /usr/src/linux/include/linux/binfmts.h:5,
                  from /usr/src/linux/include/linux/sched.h:9,
                  from context.c:11:
/usr/src/linux/include/asm/processor.h:78: warning: `cpu_data' redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:76: warning: this is 
the location of the previous definition
In file included from /usr/src/linux/include/linux/sched.h:22,
                  from context.c:11:
/usr/src/linux/include/linux/smp.h:80: warning: `smp_num_cpus' redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:80: warning: this is 
the location of the previous definition
/usr/src/linux/include/linux/smp.h:87: warning: `smp_call_function' 
redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:96: warning: this is 
the location of the previous definition
/usr/src/linux/include/linux/smp.h:88: warning: `cpu_online_map' redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:82: warning: this is 
the location of the previous definition
In file included from /usr/src/linux/include/linux/sched.h:79,
                  from context.c:11:
/usr/src/linux/include/linux/timer.h:34: warning: `del_timer_sync' redefined
/usr/src/linux/include/linux/modules/ksyms.ver:504: warning: this is the 
location of the previous definition
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686 
-DEXPORT_SYMTAB -c ksyms.c
In file included from /usr/src/linux/include/linux/modversions.h:32,
                  from /usr/src/linux/include/linux/module.h:21,
                  from ksyms.c:14:
/usr/src/linux/include/linux/modules/i386_ksyms.ver:76: warning: 
`cpu_data' redefined
/usr/src/linux/include/asm/processor.h:78: warning: this is the location 
of the previous definition
/usr/src/linux/include/linux/modules/i386_ksyms.ver:80: warning: 
`smp_num_cpus' redefined
/usr/src/linux/include/linux/smp.h:80: warning: this is the location of 
the previous definition
/usr/src/linux/include/linux/modules/i386_ksyms.ver:82: warning: 
`cpu_online_map' redefined
/usr/src/linux/include/linux/smp.h:88: warning: this is the location of 
the previous definition
/usr/src/linux/include/linux/modules/i386_ksyms.ver:96: warning: 
`smp_call_function' redefined
/usr/src/linux/include/linux/smp.h:87: warning: this is the location of 
the previous definition
In file included from /usr/src/linux/include/linux/modversions.h:39,
                  from /usr/src/linux/include/linux/module.h:21,
                  from ksyms.c:14:
/usr/src/linux/include/linux/modules/ksyms.ver:504: warning: 
`del_timer_sync' redefined
/usr/src/linux/include/linux/timer.h:34: warning: this is the location 
of the previous definition
In file included from /usr/src/linux/include/linux/interrupt.h:45,
                  from ksyms.c:21:
/usr/src/linux/include/asm/hardirq.h:37: warning: `synchronize_irq' 
redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:84: warning: this is 
the location of the previous definition
/usr/src/linux/include/linux/kernel_stat.h: In function `kstat_irqs':
In file included from ksyms.c:17:
/usr/src/linux/include/linux/kernel_stat.h:48: `smp_num_cpus' undeclared 
(first use in this function)
/usr/src/linux/include/linux/kernel_stat.h:48: (Each undeclared 
identifier is reported only once
/usr/src/linux/include/linux/kernel_stat.h:48: for each function it 
appears in.)make[2]: *** [ksyms.o] Error 1
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/kernel'
make: *** [_dir_kernel] Error 2






#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_BYTES=32
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MSR=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_LOCAL_APIC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_ALLOW_INTS=y

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=m
CONFIG_ISAPNP=m

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PF=m

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_ATALK=m

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_CONSTANTS=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_RAWIO=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# Appletalk devices
#
CONFIG_DUMMY=m
CONFIG_BONDING=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m

#
# Ethernet (1000 Mbit)
#
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_BSDCOMP=m

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_PCMCIA_SERIAL=m

#
# PCMCIA character device support
#
CONFIG_PCMCIA_SERIAL_CS=m
CONFIG_PCMCIA_SERIAL_CB=m

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_USB=m

#
# File systems
#
CONFIG_AUTOFS4_FS=y
CONFIG_HFS_FS=m
CONFIG_BFS_FS=m
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_HPFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_DEBUG=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_ICS=y
CONFIG_ACORN_PARTITION_ADFS=y
CONFIG_ACORN_PARTITION_POWERTEC=y
CONFIG_ACORN_PARTITION_RISCIX=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=m
CONFIG_FBCON_CFB16=m
CONFIG_FBCON_CFB24=m
CONFIG_FBCON_CFB32=m
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
CONFIG_SOUND=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_CS4232=m
#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m
CONFIG_USB_PRINTER=m
CONFIG_USB_SCANNER=m
CONFIG_USB_AUDIO=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_DEBUG=y
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_HID=m

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
