Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315236AbSEGBCV>; Mon, 6 May 2002 21:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315271AbSEGBCV>; Mon, 6 May 2002 21:02:21 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:43775 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315236AbSEGBCT>; Mon, 6 May 2002 21:02:19 -0400
Message-Id: <200205070059.g470x8v10550@w-gaughen.des.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: colpatch@us.ibm.com
Subject: problems with 2.5.[9-13] on numa-q boxes hanging during boot
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-8886895460"
Date: Mon, 06 May 2002 17:59:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-8886895460
Content-Type: text/plain; charset=us-ascii


2.5.[9-13] isn't booting on my hardware (8 proc numaq).  It hangs during boot. 
 The last message on the console is "INIT:".  If I don't define 
CONFIG_MULTIQUAD, it boot.  But without CONFIG_MULTIQUAD I only have 4 procs.

I've put printks in the kernel but haven't gotten any closer to a solution 
(cpu_idle() is called), also have tried kdb but it didn't help (it said that 
the processes had no stack frame).  If you have any suggestions for where to 
go now in debugging this issue I'd greatly appreciate it.

Has anyone else had troubles with 2.5.[9-13] hanging during boot?

My config for 2.5.13 is attached.

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/


--==_Exmh_-8886895460
Content-Type: text/plain ; name="2.5.13-config"; charset=us-ascii
Content-Description: 2.5.13-config
Content-Disposition: attachment; filename="2.5.13-config"

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
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
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_CPUID=y
CONFIG_HIGHMEM64G=y
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_SMP=y
CONFIG_MULTIQUAD=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_QLOGIC_ISP=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_ADAPTEC_STARFIRE=y
CONFIG_NET_TULIP=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_AUTOFS4_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFSD=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_EXPORTFS=y
CONFIG_SMB_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_DEBUG_KERNEL=y
CONFIG_CRC32=y

--==_Exmh_-8886895460--


