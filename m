Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266676AbSKUO1N>; Thu, 21 Nov 2002 09:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbSKUO1N>; Thu, 21 Nov 2002 09:27:13 -0500
Received: from front.ethz.ch ([129.132.53.17]:22258 "EHLO seismo.ifg.ethz.ch")
	by vger.kernel.org with ESMTP id <S266676AbSKUO1M>;
	Thu, 21 Nov 2002 09:27:12 -0500
Message-ID: <3DDCEEC6.5030806@seismo.ifg.ethz.ch>
Date: Thu, 21 Nov 2002 15:33:42 +0100
From: jan <jan@seismo.ifg.ethz.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: A7M266-D
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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



