Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317059AbSFWQ5n>; Sun, 23 Jun 2002 12:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317063AbSFWQ5m>; Sun, 23 Jun 2002 12:57:42 -0400
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:28199 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id <S317059AbSFWQ5l>; Sun, 23 Jun 2002 12:57:41 -0400
Message-ID: <3D15FDFE.5010109@fabbione.net>
Date: Sun, 23 Jun 2002 18:57:34 +0200
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
X-Accept-Language: en
MIME-Version: 1.0
To: Lars Magne Ingebrigtsen <larsi@gnus.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: ALI15X3 (was: Problems with Maxtor 4G160J8 and 2.4.19-* +/- ac*)
References: <m3ofe2vpa4.fsf@quimbies.gnus.org> <m3hejurrez.fsf@quimbies.gnus.org>
X-Enigmail-Version: 0.62.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Magne Ingebrigtsen wrote:

>Lars Magne Ingebrigtsen <larsi@gnus.org> writes:
>  
>
>>ALI15X3: IDE controller on PCI bus 00 dev 20
>>PCI: No IRQ known for interrupt pin A of device 00:04.0. Please try using pci=biosirq.
>>ALI15X3: chipset revision 196
>>ALI15X3: not 100% native mode: will probe irqs later
>>    ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:pio
>>    ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:pio, hdd:DMA
>>    
>>
>
>After poking around a bit, it seems like the real problem might be
>with the ALI15X3 driver.  I disabled that driver, and now I can boot
>using 2.4.19-pre10-ac2.  Of course, that leaves me with no DMA...
>
>So -- is this a general problem with this driver, or does it only
>show up when using disks bigger than 128GiB?
>
>  
>

hi Lars,
            now that you noticed this problem I did the same at home.
I get a different problem in general (see [FREEZE] 24.19-pre10 + Promise)
but I did like you suggested disabling the ALI driver and now everything
is working just fine but no DMA.

Fabio

