Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135265AbRDRT1P>; Wed, 18 Apr 2001 15:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135266AbRDRT1G>; Wed, 18 Apr 2001 15:27:06 -0400
Received: from AGrenoble-101-1-1-84.abo.wanadoo.fr ([193.251.23.84]:51695 "EHLO
	lyon.ram.loc") by vger.kernel.org with ESMTP id <S135265AbRDRT04>;
	Wed, 18 Apr 2001 15:26:56 -0400
To: linux-kernel@vger.kernel.org
From: ram@ram.fr.eu.org (Raphael Manfredi)
Subject: 2.2.19 - old UDMA drive detected, recent is not?
Date: 18 Apr 2001 19:26:47 GMT
Organization: Home, Grenoble, France
Message-ID: <9bkppn$330$1@lyon.ram.loc>
X-Newsreader: trn 4.0-test74 (May 26, 2000)
X-Mailer: newsgate 1.0 at lyon.ram.loc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On an older machine running 2.2.19, I have the following messages at boot
time:

PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DTLA-307030, ATA DISK drive
hdb: IBM-DJNA-351520, ATA DISK drive
hdc: IBM-DTLA-307030, ATA DISK drive
hdd: WDC AC34300L, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: IBM-DTLA-307030, 29314MB w/1916kB Cache, CHS=3737/255/63
hdb: IBM-DJNA-351520, 14664MB w/430kB Cache, CHS=29795/16/63
hdc: IBM-DTLA-307030, 29314MB w/1916kB Cache, CHS=59560/16/63
hdd: WDC AC34300L, 4104MB w/256kB Cache, CHS=8896/15/63, UDMA

My question is: why is the WDC drive detected as UDMA and the
other more recent disks are NOT?

The hdd drive that is detected as UDMA is at the end of the IDE
cable, so cable length is not a problem for hdc...

I'd like to understand the logic behind this UDMA detection.
The BIOS settings, as reported for the 4 IDE drives are identical,
so I don't know why there is a difference at all...

Please, enlighten me.

Raphael
