Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267624AbUHZFTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267624AbUHZFTS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 01:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267645AbUHZFTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 01:19:17 -0400
Received: from 34.67-18-129.reverse.theplanet.com ([67.18.129.34]:15006 "EHLO
	krish.dnshostnetwork.net") by vger.kernel.org with ESMTP
	id S267624AbUHZFSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 01:18:49 -0400
Message-ID: <000e01c48b2c$29c69ac0$2559023d@dreammachine>
From: "Pankaj Agarwal" <pankaj@pnpexports.com>
To: =?iso-8859-1?Q?David_Mart=EDnez_Moreno?= <ender@debian.org>
Cc: <linux-kernel@vger.kernel.org>, <ender@debian.org>
References: <002301c485cc$3777fed0$9159023d@dreammachine> <200408191127.37990.ender@debian.org> <000c01c4879d$574ce950$9f59023d@dreammachine> <200408260130.39772.ender@debian.org>
Subject: Re: Help Root Raid
Date: Thu, 26 Aug 2004 10:47:29 +0530
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0007_01C48B5A.152E7460"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - krish.dnshostnetwork.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - pnpexports.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01C48B5A.152E7460
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Ender,

Thanks for looking into it and for your help. I am hereby enclosing the
output of dmesg along with this mail. hdc(samsung ide) is the one i want to
retrieve data from.

thanks and regards,

Pankaj Agarwal

----- Original Message -----
From: "David Martínez Moreno" <ender@debian.org>
To: "Pankaj Agarwal" <pankaj@pnpexports.com>
Cc: <linux-kernel@vger.kernel.org>; <ender@debian.org>
Sent: Thursday, August 26, 2004 5:00 AM
Subject: Re: Help Root Raid


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Sábado, 21 de Agosto de 2004 18:37, Pankaj Agarwal escribió:
> Hi Ender,
>
> this isn't the case...however i tried by changing the 83 to FD but it
> doesn't worked.
>
> its already enabled and the kernel is reading these partitions as
well....i
> guess because of these messages during bootup and shutdown....
>
> Part of BOOTUP message ...
> "
> autodetecting Raid Arrays
> autorun...
> ...autorun DONE
> "
>
> Part of shutdown message ....
> "
> md recovery thread got woken
> md recovery thread finished
> mdrecoveryd(7) flushing signals
> Stopping all md devices.
> "
> Hope it helps you in helping me further.

Hello, Pankaj. Could you please send us a copy of your dmesg output? That is
the first thing you must do in order to diagnose problems.

Thanks,


Ender.
- --
Network engineer
Debian Developer
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBLSEfWs/EhA1iABsRAnHKAJwPuiNFYCncG6mfpGfkZcbg6Ug2OwCdFVS9
hNfF9qkIkYyZsXIvfOibUWA=
=l9uK
-----END PGP SIGNATURE-----



------=_NextPart_000_0007_01C48B5A.152E7460
Content-Type: text/plain;
	name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.txt"

Linux version 2.2.14-12smp (root@porky.devel.redhat.com) (gcc version =
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 SMP Tue Apr 25 =
12:58:06 EDT 2000=0A=
mapped APIC to ffffe000 (00295000)=0A=
Detected 500979898 Hz processor.=0A=
Console: colour VGA+ 80x25=0A=
Calibrating delay loop... 499.71 BogoMIPS=0A=
Memory: 256428k/261056k available (1120k kernel code, 424k reserved, =
3008k data, 76k init, 0k bigmem)=0A=
Dentry hash table entries: 262144 (order 9, 2048k)=0A=
Buffer cache hash table entries: 262144 (order 8, 1024k)=0A=
Page cache hash table entries: 65536 (order 6, 256k)=0A=
VFS: Diskquotas version dquot_6.4.0 initialized=0A=
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.=0A=
Checking 'hlt' instruction... OK.=0A=
POSIX conformance testing by UNIFIX=0A=
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)=0A=
per-CPU timeslice cutoff: 25.04 usecs.=0A=
CPU0: Intel Celeron (Mendocino) stepping 05=0A=
SMP motherboard not detected. Using dummy APIC emulation.=0A=
PCI: PCI BIOS revision 2.10 entry at 0xfb0f0=0A=
PCI: Using configuration type 1=0A=
PCI: Probing PCI hardware=0A=
Linux NET4.0 for Linux 2.2=0A=
Based upon Swansea University Computer Society NET3.039=0A=
NET4: Unix domain sockets 1.0 for Linux NET4.0.=0A=
NET4: Linux TCP/IP 1.0 for NET4.0=0A=
IP Protocols: ICMP, UDP, TCP, IGMP=0A=
TCP: Hash tables configured (ehash 262144 bhash 65536)=0A=
Initializing RT netlink socket=0A=
Starting kswapd v 1.5 =0A=
Detected PS/2 Mouse Port.=0A=
Serial driver version 4.27 with MANY_PORTS MULTIPORT SHARE_IRQ enabled=0A=
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A=0A=
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A=0A=
pty: 256 Unix98 ptys configured=0A=
Real Time Clock Driver v1.09=0A=
RAM disk driver initialized:  16 RAM disks of 4096K size=0A=
PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=3D8086, =
DID=3D2421=0A=
PCI_IDE: not 100% native mode: will probe irqs later=0A=
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA=0A=
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio=0A=
hda: ST34321A, ATA DISK drive=0A=
hdb: SAMSUNG CD-ROM SC-152C, ATAPI CDROM drive=0A=
hdc: SAMSUNG WA32163A, ATA DISK drive=0A=
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14=0A=
ide1 at 0x170-0x177,0x376 on irq 15=0A=
hda: ST34321A, 4103MB w/128kB Cache, CHS=3D523/255/63=0A=
hdc: SAMSUNG WA32163A, 2062MB w/128kB Cache, CHS=3D4190/16/63=0A=
hdb: ATAPI 52X CD-ROM drive, 128kB Cache=0A=
Uniform CDROM driver Revision: 2.56=0A=
Floppy drive(s): fd0 is 1.44M=0A=
FDC 0 is a post-1991 82077=0A=
md driver 0.90.0 MAX_MD_DEVS=3D256, MAX_REAL=3D12=0A=
raid5: measuring checksumming speed=0A=
raid5: MMX detected, trying high-speed MMX checksum routines=0A=
   pII_mmx   :  1122.426 MB/sec=0A=
   p5_mmx    :  1171.956 MB/sec=0A=
   8regs     :   860.298 MB/sec=0A=
   32regs    :   505.587 MB/sec=0A=
using fastest function: p5_mmx (1171.956 MB/sec)=0A=
scsi : 0 hosts.=0A=
scsi : detected total.=0A=
md.c: sizeof(mdp_super_t) =3D 4096=0A=
Partition check:=0A=
 hda:hda: set_multmode: status=3D0x51 { DriveReady SeekComplete Error }=0A=
hda: set_multmode: error=3D0x04 { DriveStatusError }=0A=
 hda1 hda2 < hda5 hda6 >=0A=
 hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 hdc8 hdc9 >=0A=
autodetecting RAID arrays=0A=
autorun ...=0A=
... autorun DONE.=0A=
VFS: Mounted root (ext2 filesystem) readonly.=0A=
Freeing unused kernel memory: 76k freed=0A=
Adding Swap: 514040k swap-space (priority -1)=0A=

------=_NextPart_000_0007_01C48B5A.152E7460--

