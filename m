Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313461AbSDLIsj>; Fri, 12 Apr 2002 04:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313462AbSDLIsi>; Fri, 12 Apr 2002 04:48:38 -0400
Received: from [195.63.194.11] ([195.63.194.11]:34834 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313461AbSDLIsh>; Fri, 12 Apr 2002 04:48:37 -0400
Message-ID: <3CB690DC.7020104@evision-ventures.com>
Date: Fri, 12 Apr 2002 09:46:36 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: martin@dalecki.de, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: VIA and 2.5.8-pre kernels doesn't boot!
In-Reply-To: <5.1.0.14.2.20020412014716.01f7aec0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> For me 2.5.8-pre2 and -pre3 (-pre1 not tested) both fail to boot on my 
> VIA chipset box. 2.5.7 works fine.
> 
> Best regards,
> 
>         Anton
> 
> 2.5.8-pre3 prints on serial console and then it just dies:
> ----snip----
> Uniform Multi-Platform E-IDE driver ver.:7.0.0
> ide: system bus speed 33MHz
> VIA Technologies, Inc. Bus Master IDE: IDE controller on PCI slot 00:07.1
> VIA Technologies, Inc. Bus Master IDE: chipset revision 6
> VIA Technologies, Inc. Bus Master IDE: not 100% native mode: will probe 
> irqs later
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: IC35L040AVER07-0, ATA DISK drive
> ----snip----
>

Does it crash dump thereafter? Could be that the code around
save_match doesn't get it right.

