Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131549AbQLIQgL>; Sat, 9 Dec 2000 11:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131682AbQLIQgB>; Sat, 9 Dec 2000 11:36:01 -0500
Received: from netsrvr.ami.com.au ([203.55.31.38]:13688 "EHLO
	netsrvr.ami.com.au") by vger.kernel.org with ESMTP
	id <S131549AbQLIQfr>; Sat, 9 Dec 2000 11:35:47 -0500
Message-Id: <200012091233.eB9CW7Z27402@emu.os2.ami.com.au>
X-Mailer: exmh version 2.1.1 10/15/1999
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.0-test11 does not build:
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-7790365880"
Date: Sat, 09 Dec 2000 20:32:17 +0800
From: John Summerfield <summer@OS2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-7790365880
Content-Type: text/plain; charset=us-ascii

/usr/src/linux/include/linux/modules/irmod.ver:139: warning: this is the 
location of the previous definition
/usr/src/linux/include/linux/modules/irsyms.ver:145: warning: 
`__ver_irda_task_kick' redefined
/usr/src/linux/include/linux/modules/irmod.ver:141: warning: this is the 
location of the previous definition
/usr/src/linux/include/linux/modules/irsyms.ver:147: warning: 
`__ver_irda_task_next_state' redefined
/usr/src/linux/include/linux/modules/irmod.ver:143: warning: this is the 
location of the previous definition
/usr/src/linux/include/linux/modules/irsyms.ver:149: warning: 
`__ver_irda_task_delete' redefined
/usr/src/linux/include/linux/modules/irmod.ver:145: warning: this is the 
location of the previous definition
/usr/src/linux/include/linux/modules/irsyms.ver:151: warning: 
`__ver_async_wrap_skb' redefined
/usr/src/linux/include/linux/modules/irmod.ver:147: warning: this is the 
location of the previous definition
/usr/src/linux/include/linux/modules/irsyms.ver:153: warning: 
`__ver_async_unwrap_char' redefined
/usr/src/linux/include/linux/modules/irmod.ver:149: warning: this is the 
location of the previous definition
In file included from /usr/src/linux/include/linux/modversions.h:40,
                 from /usr/src/linux/include/linux/module.h:21,
                 from ksyms.c:14:
/usr/src/linux/include/linux/modules/ksyms.ver:504: warning: `del_timer_sync' 
redefined
/usr/src/linux/include/linux/timer.h:34: warning: this is the location of the 
previous definition
In file included from /usr/src/linux/include/linux/interrupt.h:45,
                 from ksyms.c:21:
/usr/src/linux/include/asm/hardirq.h:37: warning: `synchronize_irq' redefined
/usr/src/linux/include/linux/modules/i386_ksyms.ver:84: warning: this is the 
location of the previous definition
In file included from ksyms.c:17:
/usr/src/linux/include/linux/kernel_stat.h: In function `kstat_irqs':
/usr/src/linux/include/linux/kernel_stat.h:48: `smp_num_cpus' undeclared 
(first use in this function)
/usr/src/linux/include/linux/kernel_stat.h:48: (Each undeclared identifier is 
reported only once
/usr/src/linux/include/linux/kernel_stat.h:48: for each function it appears 
in.)
make[2]: *** [ksyms.o] Error 1
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/kernel'
make: *** [_dir_kernel] Error 2
[summer@possum linux]$  

I HAVE built this kernel for another computer. I was having problems with 
this, so I remove the .config, created a new one with "make oldconfig" and the 
customised with make xconfig"



--==_Exmh_-7790365880
Content-Type: text/plain ; name="K"; charset=us-ascii
Content-Description: K
Content-Disposition: attachment; filename="K"

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MSR=y
CONFIG_NOHIGHMEM=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_PARPORT=m
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_IVB=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_PROC_STATS=y
CONFIG_AIC7XXX_RESET_DELAY=5
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_EPIC100=y
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_PCNET=y
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=y
CONFIG_PCMCIA_NETCARD=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_PCMCIA_SERIAL=y
CONFIG_AUTOFS4_FS=y
CONFIG_JFFS_FS_VERBOSE=0
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFSD=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SOUND_ES1371=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_MOUSE=y
CONFIG_MAGIC_SYSRQ=y

--==_Exmh_-7790365880--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
