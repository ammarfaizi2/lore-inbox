Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132055AbRBNORg>; Wed, 14 Feb 2001 09:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132221AbRBNOR0>; Wed, 14 Feb 2001 09:17:26 -0500
Received: from f19.law9.hotmail.com ([64.4.9.19]:17679 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S132055AbRBNORP>;
	Wed, 14 Feb 2001 09:17:15 -0500
X-Originating-IP: [212.58.173.129]
From: "Jonathan Brugge" <jonathan_brugge@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem: NIC doesn't work anymore, SIOCIFADDR-errors
Date: Wed, 14 Feb 2001 15:17:09 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F19t0CI76rOJhKPc99i00002310@hotmail.com>
X-OriginalArrivalTime: 14 Feb 2001 14:17:09.0348 (UTC) FILETIME=[D1127A40:01C09690]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the output from dmesg, after deleting some unimportant stuff like 
sound and graphics-init. I don't see any errors that have something to do 
with my NIC, the detected type (Winbond 89C940) is the right one.

Linux version 2.4.0-prerelease (root@odysseus) (gcc version 2.95.3 20010125 
(prerelease)) #2 Tue Feb 13 20:27:53 CET 2001
[...]
PCI: PCI BIOS revision 2.10 entry at 0xfdb71, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1022/740b] at 00:07.3
isapnp: Scanning for Pnp cards...
isapnp: Card 'ESS ES1868 Plug and Play AudioDrive'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.3 present.
29 structures occupying 974 bytes.
DMI table at 0x000F04F0.
[...]
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 66MHz system bus speed for PIO modes
AMD7409: IDE controller on PCI bus 00 dev 39
AMD7409: chipset revision 3
AMD7409: not 100% native mode: will probe irqs later
AMD7409: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:DMA
[...]
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: Winbond 89C940 found at 0xde00, IRQ 9, 00:20:18:80:B0:95.
[...]
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 212k freed
Adding Swap: 208836k swap-space (priority -1)



>From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
>To: Jonathan Brugge <jonathan_brugge@hotmail.com>
>Subject: Re: Problem: NIC doesn't work anymore, SIOCIFADDR-errors
>Date: Wed, 14 Feb 2001 05:15:26 -0600 (CST)
>
>Check out REPORTING-BUGS in the kernel source code...  In particular
>getting 'dmesg' output would be most helpful.
>
>	Jeff
>

Jonathan Brugge

_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

