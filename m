Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263579AbTCVQ2E>; Sat, 22 Mar 2003 11:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263650AbTCVQ2E>; Sat, 22 Mar 2003 11:28:04 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:22913 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S263579AbTCVQ2A>;
	Sat, 22 Mar 2003 11:28:00 -0500
Message-ID: <3E7C91AF.9070309@portrix.net>
Date: Sat, 22 Mar 2003 17:39:11 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4
References: <20030322140337.GA1193@brodo.de>	 <1048350905.9219.1.camel@irongate.swansea.linux.org.uk>	 <20030322162502.GA870@brodo.de> <1048354921.9221.17.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1048354921.9221.17.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sat, 2003-03-22 at 16:25, Dominik Brodowski wrote:
> 
>>>Where is the lock, what does the NMI oopser show ?
>>
>>The lock is directly "below" that line -- and the NMI oopser isn't
>>triggered, AFAICT
> 
> 
> Anything useful off right-alt scroll-lock etc ?
> 
I'm seeing the same problem. VIA KT133A platform, nothing after 
partition detection.  No NMI-Watchdog, no sysrq magic. Just dead.
Any patch particular I could try to revert?

Jan

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:pio
ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L060AVV207-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SONY CD-RW CRX175E2, ATAPI CD/DVD-ROM drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-104S 012, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/1821KiB Cache, CHS=7476/255/63, 
UDMA(100)
  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 >

