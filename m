Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272054AbRHWBEk>; Wed, 22 Aug 2001 21:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272051AbRHWBEa>; Wed, 22 Aug 2001 21:04:30 -0400
Received: from beppo.feral.com ([192.67.166.79]:62737 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S271752AbRHWBES>;
	Wed, 22 Aug 2001 21:04:18 -0400
Date: Wed, 22 Aug 2001 18:03:40 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: <mjacob@feral.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: "David S. Miller" <davem@redhat.com>, <groudier@free.fr>, <axboe@suse.de>,
        <skraw@ithnet.com>, <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: With Daniel Phillips Patch 
In-Reply-To: <200108230055.f7N0tLY20934@aslan.scsiguy.com>
Message-ID: <20010822180322.N3087-100000@wonky.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What guys writing SBus drivers? I mean, other than the NetBSD folks?


On Wed, 22 Aug 2001, Justin T. Gibbs wrote:

> >   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
> >   Date: Wed, 22 Aug 2001 18:01:40 -0600
> >
> >   It is opaque and should be able to represent all dma (or I would prefer
> >   bus) addresses in the system.  The examples I've seen where people
> >   assume it to be 32bits in size are, well, broken.
> >
> >It is the type to be used for 32-bit SAC based DMA.
> >DMA-mapping.txt is pretty clear about this.
>
> Then it is poorly named.  How about "pci_dma32_t".  Or better yet,
> uint32_t.  How do the guys writing SBUS drivers like the fact that
> all of this mapping stuff is so PCI centric?
>
> --
> Justin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

