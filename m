Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUANXgx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUANXfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:35:03 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:38162 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S266312AbUANXbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:31:14 -0500
Message-ID: <4005D141.7050408@superbug.demon.co.uk>
Date: Wed, 14 Jan 2004 23:31:13 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Greg Stark <gsstark@mit.edu>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Serial ATA (SATA) for Linux status report
References: <20031203204445.GA26987@gtf.org> <87hdyyxjgl.fsf@stark.xeocode.com> <20040114225653.GA32704@codepoet.org>
In-Reply-To: <20040114225653.GA32704@codepoet.org>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> On Wed Jan 14, 2004 at 05:18:34PM -0500, Greg Stark wrote:
> 
>>Jeff Garzik <jgarzik@pobox.com> writes:
>>
>>
>>>Intel ICH5
>>>
>>>Issue #2: Excessive interrupts are seen in some configurations.
>>
>>I guess I'm seeing this problem. I'm trying to get my P4P800 motherboard with
>>an ICH5 chipset working completely. So far I've been living without the cdrom
>>or DVD players. I see lots of other posts on linux-kernel about the same
>>problems:
> 
> 
> I have the same deal.  My offer to send Jeff a P4P800 motherboard
> to test with is still open....
> 
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/

I have a ABIT IC7-G motherboard with the ICH5 chipset.
No reported problems with it. I would be happy to do some tests, just in 
case I have not actually noticed the problems.

hda=DVD-ROM
hdb=DVD writer
hdc=SATA Seagate Hard Disc 160 Gig.
hdd=Empty.

I do sometimes have problems during BIOS startup, with it not detecting 
the SATA hard disc, but pressing the reset button a few times fixes that.

Jan 14 01:01:17 new kernel: Uniform Multi-Platform E-IDE driver 
revision: 7.00alpha2
Jan 14 01:01:17 new kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
Jan 14 01:01:17 new kernel: ICH5-SATA: IDE controller at PCI slot 
0000:00:1f.2
Jan 14 01:01:17 new kernel: ICH5-SATA: chipset revision 2
Jan 14 01:01:17 new kernel: ICH5-SATA: not 100%% native mode: will probe 
irqs later
Jan 14 01:01:17 new kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS 
settings: hda:DMA, hdb:DMA
Jan 14 01:01:17 new kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS 
settings: hdc:DMA, hdd:pio
Jan 14 01:01:17 new kernel: hda: ATAPI DVD-ROM 16XMax, ATAPI CD/DVD-ROM 
drive
Jan 14 01:01:17 new kernel: hdb: OPTORITEDVD RW DD0203, ATAPI CD/DVD-ROM 
drive
Jan 14 01:01:17 new kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan 14 01:01:17 new kernel: hdc: ST3160023AS, ATA DISK drive
Jan 14 01:01:17 new kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jan 14 01:01:17 new kernel: hdc: max request size: 1024KiB
Jan 14 01:01:17 new kernel: hdc: 312581808 sectors (160041 MB) w/8192KiB 
Cache, CHS=19457/255/63, UDMA(33)
Jan 14 01:01:17 new kernel:  /dev/ide/host0/bus1/target0/lun0: p1 p2 < 
p5 p6 p7 >

