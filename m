Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbRBHSsk>; Thu, 8 Feb 2001 13:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129149AbRBHSsa>; Thu, 8 Feb 2001 13:48:30 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:25436 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S129130AbRBHSsY>;
	Thu, 8 Feb 2001 13:48:24 -0500
Message-ID: <3A82E9F1.3050208@valinux.com>
Date: Thu, 08 Feb 2001 11:48:17 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; 0.7) Gecko/20010126
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Deucher <adeucher@UU.NET>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: 2.4.x, drm, g400 and pci_set_master
In-Reply-To: <14EAB47C173C@vcnet.vc.cvut.cz> <3A82E86C.14217D65@uu.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Deucher wrote:

> There is preliminary support for pcigart in the dri tree.  I believe
> some people have had some success with it.
> 
> Alex
> 
> Petr Vandrovec wrote:
> 
>> On  8 Feb 01 at 13:14, Alex Deucher wrote:
>> 
>>> Jeff Hartmann wrote:
>>> 
>>>> Petr Vandrovec wrote:
>>> 
>>>> It does not use dynamic DMA mapping, because it doesn't do PCI DMA at
>>>> all.  It uses AGP DMA.  Actually, it shouldn't be too hard to get it to
>>>> work on the Alpha (just a few 32/64 bit issues probably.)  Someone just
>>>> needs to get agpgart working on the Alpha, thats the big step.
>>> 
>>> That shouldn't be too hard since many (all?) AGP alpha boards (UP1000's
>>> anyway) are based on the AMD 751 Northbridge? And there is already
>>> support for that in the kernel for x86.
>> 
>> My AlphaPC 164LX does not have AGP at all - and I want to get G200/G400 PCI
>> working on it with dri, using 21174 features.
>>                                                     Petr Vandrovec
>>                                                     vandrove@vc.cvut.cz
>> 
pcigart is only for the r128/radeon (and the radeon support is not done 
yet.)  The has been success using pcigart on the PPC, I would suspect 
the Alpha will probably be pretty easy to get going.

-Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
