Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266772AbSKUQBC>; Thu, 21 Nov 2002 11:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266792AbSKUQBC>; Thu, 21 Nov 2002 11:01:02 -0500
Received: from [64.246.18.23] ([64.246.18.23]:5248 "EHLO ensim.2hosting.net")
	by vger.kernel.org with ESMTP id <S266772AbSKUQBB>;
	Thu, 21 Nov 2002 11:01:01 -0500
From: "Steve Lee" <steve@tuxsoft.com>
To: "'jan'" <jan@seismo.ifg.ethz.ch>, <linux-kernel@vger.kernel.org>
Subject: RE: A7M266-D
Date: Thu, 21 Nov 2002 10:09:27 -0600
Message-ID: <004401c29178$6370b8f0$0201a8c0@pluto>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <3DDCEEC6.5030806@seismo.ifg.ethz.ch>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add "CONFIG_BLK_DEV_AMD74XX=y" to your config and you'll be fine.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of jan
Sent: Thursday, November 21, 2002 8:34 AM
To: linux-kernel@vger.kernel.org
Subject: A7M266-D

dear list,

i have an A7M266-D board with two AMD Athlon MP 2000+ on it.
Unfortunately I am unable to compile the correct driver for the AM7441 
IDE Controller (using 2.4.19)
I always get this under SuSE :

AMD7441: detected chipset, but driver not compiled in!

When using a precompiled SUSE or RedHat Kernel it gets recognized.



SuSE Linux 2.4.18-64GB-SMP output :

AMD_IDE: IDE controller on PCI bus 00 dev 39
AMD_IDE: chipset revision 4
AMD_IDE: not 100% native mode: will probe irqs later
AMD_IDE: AMD-768 Opus (rev 04) IDE UDMA100 controller on pci00:07.1
     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio

RedHat 2.4.18-14smp output :

AMD7441: IDE controller on PCI bus 00 dev 39
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: disabling single-word DMA support (revision < C4)
     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio


What am I doing wrong ? and why RedHat and SuSE Kernel have no Problem 
with this Chipset ?


best regards,


Jan



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


