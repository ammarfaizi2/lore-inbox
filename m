Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262489AbSJKOLO>; Fri, 11 Oct 2002 10:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262491AbSJKOLO>; Fri, 11 Oct 2002 10:11:14 -0400
Received: from babel.spoiled.org ([217.13.197.48]:10871 "HELO a.mx.spoiled.org")
	by vger.kernel.org with SMTP id <S262489AbSJKOLA>;
	Fri, 11 Oct 2002 10:11:00 -0400
From: Juri Haberland <juri@koschikode.com>
To: gzp@myhost.mynet ("Gabor Z. Papp")
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE PDC20268 in Linux 2.4.20-pre10
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <4cc4.3da69003.2d455@gzp1.gzp.hu>
User-Agent: tin/1.4.5-20010409 ("One More Nightmare") (UNIX) (OpenBSD/2.9 (i386))
Message-Id: <20021011141646.DC3601196B@a.mx.spoiled.org>
Date: Fri, 11 Oct 2002 16:16:46 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <4cc4.3da69003.2d455@gzp1.gzp.hu> you wrote:
> * Marcelo Tosatti <marcelo@conectiva.com.br>:
> 
> | Here goes pre10.
> 
> When will the PDC20268 driver go with UDMA 100 in your tree?
> Before or after 2.4.20?

> PDC20268: IDE controller on PCI bus 02 dev 68
> PCI: Found IRQ 9 for device 02:0d.0
> PCI: Sharing IRQ 9 with 02:09.0
> PDC20268: chipset revision 1
> PDC20268: not 100% native mode: will probe irqs later
> PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode
> Secondary MASTER Mode.
>     ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
> hde: IC35L060AVVA07-0, ATA DISK drive
> hdg: IC35L060AVVA07-0, ATA DISK drive
> ide2 at 0xb800-0xb807,0xb402 on irq 9
> ide3 at 0xb000-0xb007,0xa802 on irq 9
> hde: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, UDMA(33)
> hdg: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, UDMA(33)

Uhm, tho following is with 2.4.19-xfs:

PDC20268: IDE controller on PCI bus 00 dev 98
PDC20268: chipset revision 1
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xfce0-0xfce7, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xfce8-0xfcef, BIOS settings: hdg:pio, hdh:pio
hde: Maxtor 4D080H4, ATA DISK drive
hdg: Maxtor 4G120J6, ATA DISK drive
ide2 at 0xfcc8-0xfccf,0xfcda on irq 10
ide3 at 0xfcd0-0xfcd7,0xfcde on irq 10
hde: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63, UDMA(100)
hdg: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)

So there *is* UDMA 100 support...

Cheers,
Juri

-- 
Juri Haberland  <juri@koschikode.com> 

