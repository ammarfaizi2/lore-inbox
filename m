Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTFZVV3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 17:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTFZVV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 17:21:29 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:17552 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S262714AbTFZVVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 17:21:21 -0400
Date: Thu, 26 Jun 2003 14:35:08 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Larry McVoy <lm@work.bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
In-Reply-To: <20030626231752.E5633@ucw.cz>
Message-ID: <Pine.LNX.4.44.0306261428400.25030-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jun 2003, Vojtech Pavlik wrote:

> On Tue, Jun 24, 2003 at 06:33:02PM -0700, Larry McVoy wrote:

> > Anyway, we put 2.5.70 on bkbits.net which is a Tyan dual PII motherboard
> > w/ serverworks IDE and we started getting data corruption.  So I just
> > installed 2.4.21 and we'll see if that works better.  
> 
> Eek. Serverworks IDE. I don't think they ever got that bit of their
> chipset right.

I've had sane behavior for most of the later 2.4 series...

Linux pith.uoregon.edu 2.4.21-rc1-ac4 #2 SMP Tue May 6 14:27:52 PDT 2003 i686 unknown

2:39pm  up 36 days,  1:26,  2 users,  load average: 0.02, 0.12, 0.13

[root@pith root]# cat /proc/ide/svwks 

                             ServerWorks OSB4/CSB5/CSB6

                            ServerWorks OSB4 Chipset (rev 00)
------------------------------- General Status ---------------------------------
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              no              yes               yes
UDMA enabled:   yes              no              yes               yes
UDMA enabled:   2                0               2                 2
DMA enabled:    2                ?               2                 2
PIO  enabled:   4                0               4                 4

PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xfea70000
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide4: BM-DMA at 0xde80-0xde87, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0xde88-0xde8f, BIOS settings: hdk:pio, hdl:pio
PDC20267: IDE controller at PCI slot 00:02.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xfea60000
PDC20267: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20267: FORCING BURST BIT 0x00->0x01 ACTIVE
    ide6: BM-DMA at 0xdd80-0xdd87, BIOS settings: hdm:DMA, hdn:pio
    ide7: BM-DMA at 0xdd88-0xdd8f, BIOS settings: hdo:DMA, hdp:DMA
SvrWks OSB4: IDE controller at PCI slot 00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTLA-307015, ATA DISK drive
blk: queue c0361940, I/O limit 4095Mb (mask 0xffffffff)
hdc: IBM-DTLA-307015, ATA DISK drive
hdd: CD-540E, ATAPI CD/DVD-ROM drive
blk: queue c0361dbc, I/O limit 4095Mb (mask 0xffffffff)
hde: IBM-DTLA-307075, ATA DISK drive
blk: queue c0362238, I/O limit 4095Mb (mask 0xffffffff)
hdg: IBM-DTLA-307075, ATA DISK drive
blk: queue c03626b4, I/O limit 4095Mb (mask 0xffffffff)
hdi: IBM-DTLA-307075, ATA DISK drive
blk: queue c0362b30, I/O limit 4095Mb (mask 0xffffffff)
hdm: IBM-DTLA-307015, ATA DISK drive
blk: queue c0363428, I/O limit 4095Mb (mask 0xffffffff)
hdo: IBM-DTLA-307075, ATA DISK drive
blk: queue c03638a4, I/O limit 4095Mb (mask 0xffffffff)

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


