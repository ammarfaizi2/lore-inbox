Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbTEKM3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 08:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbTEKM3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:29:52 -0400
Received: from ulima.unil.ch ([130.223.144.143]:9137 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id S261239AbTEKM3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:29:51 -0400
Date: Sun, 11 May 2003 14:42:33 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 and ide-floppy errors
Message-ID: <20030511124233.GB10013@ulima.unil.ch>
References: <20030511122503.GA10013@ulima.unil.ch> <Pine.SOL.4.30.0305111434500.4788-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.SOL.4.30.0305111434500.4788-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 02:35:48PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> Don't compile TCQ support in.
> What do you have on hda and hdb?

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L120AVVA07-0, ATA DISK drive
hdb: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
hda: tagged command queueing enabled, command queue depth 8
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SONY DVD RW DRU-500A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
hdc: ATAPI 16X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)

I'll recompil without TCQ: thank you very much for the info!!!

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
