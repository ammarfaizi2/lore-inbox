Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284421AbRLHT26>; Sat, 8 Dec 2001 14:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284420AbRLHT2u>; Sat, 8 Dec 2001 14:28:50 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:9732 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S284406AbRLHT2e>; Sat, 8 Dec 2001 14:28:34 -0500
Message-ID: <3C1269E1.53347A2A@delusion.de>
Date: Sat, 08 Dec 2001 20:28:33 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-pre7 ide-cd module
In-Reply-To: <3C1235C4.BC20AC8E@wanadoo.fr> <20011208161847.GK11567@suse.de> <3C126634.F3BBC941@delusion.de> <20011208191515.GX11567@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> Yes please -- try 2.5.1-pre1 and 2.5.1-pre2, it probably broke there.

Indeed. pre1 works, pre2 doesn't:

pre1:
hda: IBM-DTLA-307030, ATA DISK drive
hdb: IBM-DTLA-307030, ATA DISK drive
hde: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
ide0 at 0x9400-0x9407,0x9002 on irq 10
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
hdb: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
hde: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA

pre2:
hda: IBM-DTLA-307030, ATA DISK drive
hdb: IBM-DTLA-307030, ATA DISK drive
hde: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
ide0 at 0x9400-0x9407,0x9002 on irq 10
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
blk: queue c0345804, I/O limit 4095Mb (mask 0xffffffff)
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
blk: queue c0345974, I/O limit 4095Mb (mask 0xffffffff)
hdb: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
hde: ATAPI CD-ROM drive, 0kB Cache, DMA

Regards,
Udo.
