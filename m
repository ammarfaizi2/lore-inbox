Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbSKVHHI>; Fri, 22 Nov 2002 02:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266955AbSKVHHI>; Fri, 22 Nov 2002 02:07:08 -0500
Received: from front.ethz.ch ([129.132.53.17]:11472 "EHLO seismo.ifg.ethz.ch")
	by vger.kernel.org with ESMTP id <S266640AbSKVHHH>;
	Fri, 22 Nov 2002 02:07:07 -0500
Message-ID: <3DDDD923.1070702@seismo.ifg.ethz.ch>
Date: Fri, 22 Nov 2002 08:13:39 +0100
From: jan <jan@seismo.ifg.ethz.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: A7M266-D
References: <200211211124.36280.shawn.starr@datawire.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks to all who helped me out. I finally found that option
in :
ATA/IDE/MFM/RLL support
It is the AMD Viper support button.

Jan


Shawn Starr wrote:
> Works fine in 2.4.18+ (since I had the machine only durning 2.4.18).
> 
> Shawn.
> 
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of jan
> Sent: Thursday, November 21, 2002 8:34 AM
> To: linux-kernel@vger.kernel.org
> Subject: A7M266-D
> 
> dear list,
> 
> i have an A7M266-D board with two AMD Athlon MP 2000+ on it.
> Unfortunately I am unable to compile the correct driver for the AM7441 
> IDE Controller (using 2.4.19)
> I always get this under SuSE :
> 
> AMD7441: detected chipset, but driver not compiled in!
> 
> When using a precompiled SUSE or RedHat Kernel it gets recognized.
> 
> 
> 
> SuSE Linux 2.4.18-64GB-SMP output :
> 
> AMD_IDE: IDE controller on PCI bus 00 dev 39
> AMD_IDE: chipset revision 4
> AMD_IDE: not 100% native mode: will probe irqs later
> AMD_IDE: AMD-768 Opus (rev 04) IDE UDMA100 controller on pci00:07.1
>      ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
>      ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
> 
> RedHat 2.4.18-14smp output :
> 
> AMD7441: IDE controller on PCI bus 00 dev 39
> AMD7441: chipset revision 4
> AMD7441: not 100% native mode: will probe irqs later
> AMD7441: disabling single-word DMA support (revision < C4)
>      ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
>      ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
> 
> 
> What am I doing wrong ? and why RedHat and SuSE Kernel have no Problem 
> with this Chipset ?
> 
> 
> best regards,
> 
> 
> Jan


-- 
Jan ZELLER

Swiss Seismological Service
ETH-Hoenggerberg / HPP P 9
CH-8093 Zurich
Switzerland

Phone : +41-1-633-3243
Fax   : +41-1-633-1065

Microsoft gives you Windows but Unix gives you the whole house!

