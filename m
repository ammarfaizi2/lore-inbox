Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266564AbSKOS67>; Fri, 15 Nov 2002 13:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266565AbSKOS67>; Fri, 15 Nov 2002 13:58:59 -0500
Received: from mailhost.cotse.com ([216.112.42.58]:10514 "EHLO
	mailhost.cotse.com") by vger.kernel.org with ESMTP
	id <S266564AbSKOS65>; Fri, 15 Nov 2002 13:58:57 -0500
Message-ID: <YWxhbg==.c702915e20b358591f77f3acb03c71fa@1037386739.cotse.net>
Date: Fri, 15 Nov 2002 13:58:59 -0500 (EST)
X-Abuse-To: abuse@cotse.com
Subject: Re: CD IO error
From: "Alan Willis" <alan@cotse.net>
To: <lgouv@pi.be>
In-Reply-To: <20021115183525.GA1285@gouv>
References: <YWxhbg==.a513a46732330fd5f834894ae7200923@1037378527.cotse.net>
        <20021115183525.GA1285@gouv>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-kernel@vger.kernel.org>
Reply-To: alan@cotse.com
X-Mailer: www.cotse.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  Same here. I have disabled DMA for cdrom(CONFIG_IDEDMA_ONLYDISK=y) and
> things are working again, perhaps with a loss operformance?
>  Hope it helps.

  Unfortunately it doesnt, I still get the err with DMA disabled on hdc.

-alan

ide: Assuming 66MHz system bus speed for PIO modes
ICH: IDE controller at PCI slot 00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 2B020H1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Lite-On LTN486 48x Max, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 39062500 sectors (20000 MB) w/2048KiB Cache, CHS=2431/255/63, UDMA(66)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdc: DMA disabled
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 48X CD-ROM drive, 120kB Cache
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0



