Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSGQPoR>; Wed, 17 Jul 2002 11:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315245AbSGQPoR>; Wed, 17 Jul 2002 11:44:17 -0400
Received: from imeil.udg.es ([130.206.45.97]:41139 "EHLO imeil.udg.es")
	by vger.kernel.org with ESMTP id <S315214AbSGQPoQ>;
	Wed, 17 Jul 2002 11:44:16 -0400
Date: Wed, 17 Jul 2002 17:50:12 +0200 (CEST)
From: Giro <giro@hades.udg.es>
To: Klaus Dittrich <kladit@t-online.de>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19rc2 and Promise RAID controller
In-Reply-To: <20020717153848.GA3167@df1tlpc.local.here>
Message-ID: <Pine.LNX.4.30.0207171748350.3571-100000@hades.udg.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I with my promise fasttrack tx2000, with 2.4.19rc1 and 2.4.19rc2, promise
i detected correctly but i don't have dma on my hd disk.

With 2.4.19rc1-ac6 promise is perfecte but i have many oopss.


Giro


On Wed, 17 Jul 2002, Klaus Dittrich wrote:

> With 2.4.19.rc2 my Promise RAID controller will be skipped.
> With 2.4.19.rc1 and before it was detected and worked fine.
>
> from dmesg of 2.4.19rc2 ..
>
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:DMA
> 	ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
> 	PDC20270: IDE controller on PCI bus 00 dev 48
> 	PDC20270: chipset revision 2
> 	ide: Skipping Promise RAID controller.
> 	hdb: C/H/S=20510/81/228 from BIOS ignored
> 	hdb: IBM-DTLA-307060, ATA DISK drive
> 	ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> 	hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(33)
> 	Partition check:
> 		 hdb: hdb1
> Floppy drive(s): fd0 is 1.44M
>
>
>
> from dmesg of 2.4.19rc1 ..
>
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:DMA
> 	ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
> 	PDC20270: IDE controller on PCI bus 00 dev 48
> 	PDC20270: chipset revision 2
> 	PDC20270: not 100% native mode: will probe irqs later
> 	ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
> 	ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
> 	hdb: C/H/S=20510/81/228 from BIOS ignored
> 	hdb: IBM-DTLA-307060, ATA DISK drive
> 	hde: WDC WD600BB-32CXA0, ATA DISK drive
> 	hdg: WDC WD600BB-32CXA0, ATA DISK drive
> 	ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> 	ide2 at 0xb800-0xb807,0xb402 on irq 5
> 	ide3 at 0xb000-0xb007,0xa802 on irq 5
> 	hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(33)
> 	hde: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, (U)DMA
> 	hdg: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, (U)DMA
> 	Partition check:
> 		hdb: hdb1
> 		hde: hde1
> 		hdg: hdg1
> Floppy drive(s): fd0 is 1.44M
>
> --
> Regards
>
> Klaus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

*******************************************************************************
  David Gironella Casademont
  Estudiant Informatica de Sistemes - Universitat de Girona
  Administrador d'Hades root@hades.udg.es
  Secretari Associació d'Estudiants d'Informàtica de Girona AEIGI
  AEIGi Web - http://www.aeigi.org
  Giro Web - http://hades.udg.es/~giro
*******************************************************************************




