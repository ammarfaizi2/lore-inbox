Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317580AbSH3VyW>; Fri, 30 Aug 2002 17:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317582AbSH3VyW>; Fri, 30 Aug 2002 17:54:22 -0400
Received: from web14004.mail.yahoo.com ([216.136.175.120]:21252 "HELO
	web14004.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317580AbSH3VyV>; Fri, 30 Aug 2002 17:54:21 -0400
Message-ID: <20020830215842.82762.qmail@web14004.mail.yahoo.com>
Date: Fri, 30 Aug 2002 14:58:42 -0700 (PDT)
From: Tony Spinillo <tspinillo@yahoo.com>
Subject: Re: Linux 2.4.20-pre5-ac1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I just tried 2.4.20-pre5-ac1 on my Gigabyte 8IGX 845G chipset board.
I have the same problem as reported previously. No IDE drives when
booting 2.4.20pre5-ac1, but drives do appear when booting
2.4.20-pre1-ac1. I don't know if
you or Andre have begun to sort it out yet, but maybe someone else
can 
report in who is using another 845G board to see if my problem is 
unique or not.
Dmesg snippets below, full http links to dmesg,lspci, kernel 
config at the end of the message. I will also  try on my 
Gigabyte 8IEX 845E chipset board later.  If it works I will report
in.

2.4.20pre1ac1 works great. (ide-scsi, DVD viewing etc)

I'm running stock RedHat 7.3 all updates. No binary proprietary
drivers
were built, intalled etc for 2.4.20pre5ac1.

Thanks for all the work you and the rest of the IDE team are doing.

Tony
(If I'm doing something stupid let me know)

***** DMESG on 2.4.20-pre5-ac1 - BIOS flagged correctly, but no
devices in 
/proc/ide.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdc:DMA, hdd:pio
Floppy drive(s): fd0 is 1.44M
***** DMESG on 2.4.20-pre1-ac1
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdc:DMA, hdd:pio
hda: LITE-ON LTR-48125W, ATAPI CD/DVD-ROM drive
hdc: LITEON DVD-ROM LTD16, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Floppy drive(s): fd0 is 1.44M

Full links below
http://ac.marywood.edu/tspin/www/dmesg2420pre1ac1.txt
http://ac.marywood.edu/tspin/www/dmesg2420pre5ac1.txt
Lspci -vvv when running 2.4.20-pre1-ac1
http://ac.marywood.edu/tspin/www/lspci.txt
http://ac.marywood.edu/tspin/www/dotconfig.txt


__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
