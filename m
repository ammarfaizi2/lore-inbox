Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287199AbSALRC6>; Sat, 12 Jan 2002 12:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287196AbSALRCv>; Sat, 12 Jan 2002 12:02:51 -0500
Received: from mx1.fuse.net ([216.68.2.90]:36242 "EHLO mta01.fuse.net")
	by vger.kernel.org with ESMTP id <S287199AbSALRCk>;
	Sat, 12 Jan 2002 12:02:40 -0500
Message-ID: <3C406C21.3050208@fuse.net>
Date: Sat, 12 Jan 2002 12:02:25 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4 Unable to boot on Cyrix box?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have an old recycled box playing firewall for me which stubbornly 
refuses to run 2.4.  2.2.17,18,19,20 and a handful of -pre* patches have 
run just fine.

The system just hangs after 2.4 prints out:
SIS5513: IDE controller on PCI bus 00 dev 09
SIS5513: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 90320D2, ATA DISK drive
hdb: CD-ROM CDU76E, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

2.2 continues fine.  But 2.4 appears to hang here forever.  No panic, no 
keyboard control, C-A-D does nothing.

hda: Maxtor 90320D2, 3079MB w/256kB Cache, CHS=782/128/63
Partition check:
 hda: hda1 hda2 hda3
VFS: Mounted root (ext2 filesystem) readonly.

Relevant system specs:
Cyrix 233MHz processor
64M PC-100 RAM (1 dimm)
SIS5513 IDE chipset
    LSPCI reports: 00:01.1 IDE interface: Silicon Integrated Systems 
[SiS] 5513 [IDE] (rev d0)


I have the kernel built for a 386, PCI and EISA support enabled (and 
their respective PNP) all Y, SIS5513 support included in the kernel... 
 What am I missing, here?

More information available if needed.

Thanks in advance,
--Nathan


