Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272173AbRHWAzt>; Wed, 22 Aug 2001 20:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272175AbRHWAzj>; Wed, 22 Aug 2001 20:55:39 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:43782 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272173AbRHWAzV>; Wed, 22 Aug 2001 20:55:21 -0400
Message-Id: <200108230055.f7N0tLY20934@aslan.scsiguy.com>
To: "David S. Miller" <davem@redhat.com>
cc: groudier@free.fr, axboe@suse.de, skraw@ithnet.com, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
In-Reply-To: Your message of "Wed, 22 Aug 2001 17:40:48 PDT."
             <20010822.174048.116352248.davem@redhat.com> 
Date: Wed, 22 Aug 2001 18:55:21 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
>   Date: Wed, 22 Aug 2001 18:01:40 -0600
>
>   It is opaque and should be able to represent all dma (or I would prefer
>   bus) addresses in the system.  The examples I've seen where people
>   assume it to be 32bits in size are, well, broken.
>
>It is the type to be used for 32-bit SAC based DMA.
>DMA-mapping.txt is pretty clear about this.

Then it is poorly named.  How about "pci_dma32_t".  Or better yet,
uint32_t.  How do the guys writing SBUS drivers like the fact that
all of this mapping stuff is so PCI centric?

--
Justin
