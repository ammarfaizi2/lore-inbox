Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272005AbRHVNZA>; Wed, 22 Aug 2001 09:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272006AbRHVNYu>; Wed, 22 Aug 2001 09:24:50 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:25875 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272002AbRHVNYk>; Wed, 22 Aug 2001 09:24:40 -0400
Message-Id: <200108221324.f7MDOTY10490@aslan.scsiguy.com>
To: Jens Axboe <axboe@suse.de>
cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P) 
In-Reply-To: Your message of "Wed, 22 Aug 2001 08:46:49 +0200."
             <20010822084649.F604@suse.de> 
Date: Wed, 22 Aug 2001 07:24:29 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Aug 21 2001, Justin T. Gibbs wrote:
>> [...] Unfortunately the x86 port
>> doesn't support passing large dma addresses to drivers so bouncing is requir
>ed
>> in order to do PAE.
>
>With the PCI64 + highmem no-bounce patches it does, so feel free to
>convert aic7xxx to the newpci64 API :-)

Is this somehow different than how large DMA is done on the ia64
port?  All I do is look at the size of dma_addr_t to decide whether
to enable high address support in my driver.  If dma_addr_t's size
changes, then 64bit addressing will work the same as on every other
Linux port.

--
Justin
