Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVBXC7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVBXC7I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVBXC7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:59:08 -0500
Received: from web40911.mail.yahoo.com ([66.218.78.208]:64643 "HELO
	web40911.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261697AbVBXC6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:58:35 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=H+2hEA6AFt6Sd6c9lS0i5eR1mYrXNLyWJKg5l9taMRdIkFRKbh5pxmjo9xBaYLTFgWF17injsgGeCcW0uCT7Ecky9xRsbldolf9Be4ROtjcrzwMnPo9VVNlu2M5shM2fsjk8ufIwlD29e3EvCTRINuHs3Iy0tgnhw+3JYTmHF4w=  ;
Message-ID: <20050224025834.97123.qmail@web40911.mail.yahoo.com>
Date: Wed, 23 Feb 2005 18:58:34 -0800 (PST)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: [PATCH] Re: 2.6.11-rc4 libata-core (irq 30: nobody cared!)
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?=20=22Rog=E9rio=22?= Brito <rbrito@ime.usp.br>,
       linux-ide@vger.kernel.org
In-Reply-To: <421D3D33.9060707@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Does this patch do anything useful?
> 
> 	Jeff
> 

Not really.  It doesn't print the nobody cared
message, but still hangs at boot.  I'd give you a
backtrace but my MAGIC_SYSRQ doesn't seem to be
working right now.

-Brian


Linux version 2.6.11-rc4 (root@localhost.localdomain)
(gcc version 3.3.2) #28 Wed Feb 23 18:52:22 PST 2005
Built 1 zonelists
Kernel command line: root=/dev/ram rw ramdisk=36000
console=ttyS0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5,
131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536
bytes)
Memory: 120832k available (2136k kernel code, 916k
data, 108k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
checking if image is initramfs...it isn't (no cpio
magic); looks like an initrd
Freeing initrd memory: 5709k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
SCSI subsystem initialized
Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Initializing Cryptographic API
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports,
IRQ sharing disabled
ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 36000K
size 1024 blocksize
loop: loaded (max 8 devices)
mal0: Initialized, 1 tx channels, 1 rx channels
emac: IBM EMAC Ethernet driver, version 2.0
Maintained by Benjamin Herrenschmidt
<benh@kernel.crashing.org>
eth0: IBM emac, MAC 08:00:3e:26:15:59
eth0: Found Generic MII PHY (0x06)
Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
ata1: SATA max UDMA/100 cmd 0xC9002E80 ctl 0xC9002E8A
bmdma 0xC9002E00 irq 30
ata2: SATA max UDMA/100 cmd 0xC9002EC0 ctl 0xC9002ECA
bmdma 0xC9002E08 irq 30
ata1: dev 0 ATA, max UDMA7, 234493056 sectors: lba48
eth0: Link is Up
eth0: Speed: 100, Full duplex.



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
