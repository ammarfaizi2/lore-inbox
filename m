Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292925AbSBVQqf>; Fri, 22 Feb 2002 11:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292928AbSBVQq0>; Fri, 22 Feb 2002 11:46:26 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:31161 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S292925AbSBVQqF>; Fri, 22 Feb 2002 11:46:05 -0500
Date: Fri, 22 Feb 2002 17:45:58 +0100
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: fernando@quatro.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-rcx: Dual P3 + VIA + APIC
Message-ID: <20020222164558.GE13774@os.inf.tu-dresden.de>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	fernando@quatro.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20020220104129.GP13774@os.inf.tu-dresden.de> <051a01c1bb01$70634580$c50016ac@spps.com.br> <20020221211142.0cf0efa4.skraw@ithnet.com> <20020222130246.GD13774@os.inf.tu-dresden.de> <20020222141101.0cc342e1.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="D6z0c4W1rkZNF4Vu"
Content-Disposition: inline
In-Reply-To: <20020222141101.0cc342e1.skraw@ithnet.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

On Fri Feb 22, 2002 at 14:11:01 +0100, Stephan von Krawczynski wrote:
> > > I compile my kernel (2.4.18-rc2) with the attached config. Please try
> > > it and tell your results. I can assure you that this machine runs rock
> > > solid over here for months.
> > 
> > No luck here. Hangs during boot (tried with 2.4.18-rc2-ac2).
> 
> Please start from a setup as close to mine as possible. That is 2.4.18-rc2.
> In setup switch MPS 1.4 support to disable and Power Management to disable.

No luck, even with completely switched off PM. "noapic" works. I
attached the stripped down config. It mostly hangs while setting up the
second CPU.

> > I even updated the BIOS from 1010 to 1014 as well (just in case). What
> > BIOS version are you running? And at how many MHz are the CPUs?
> 
> I use BIOS 1010, 2 x P3 1 GHz and tried RAM from 512MB to 2GB.
> Currently installed are 2GB being 2 x 1GB registered DIMM.

2x 933, RAM is 960MB.



Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://a.home.dhs.org

--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="config.y-only"

CONFIG_X86=y
CONFIG_ISA=y
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
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
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
CONFIG_BINFMT_MISC=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_G_NCR5380_PORT=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_TULIP=y
CONFIG_NET_RADIO=y
CONFIG_AIRONET4500_PNP=y
CONFIG_AIRONET4500_PCI=y
CONFIG_AIRONET4500_ISA=y
CONFIG_AIRONET4500_I365=y
CONFIG_NET_WIRELESS=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_QUOTA=y
CONFIG_TMPFS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD_V3=y
CONFIG_LOCKD_V4=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_VGA_CONSOLE=y

--D6z0c4W1rkZNF4Vu--
