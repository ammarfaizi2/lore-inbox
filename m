Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290304AbSA3SHG>; Wed, 30 Jan 2002 13:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290314AbSA3SFv>; Wed, 30 Jan 2002 13:05:51 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:5538 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S290311AbSA3SFL>; Wed, 30 Jan 2002 13:05:11 -0500
Date: Wed, 30 Jan 2002 11:04:49 -0700
Message-Id: <200201301804.g0UI4nQ13064@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, tao@acc.umu.se (David Weinehall),
        brand@jupiter.cs.uni-dortmund.de (Horst von Brand),
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KERN_INFO for devfs
In-Reply-To: <E16VwTl-0007VJ-00@the-village.bc.nu>
In-Reply-To: <200201301232.g0UCWmt10496@Port.imtp.ilyichevsk.odessa.ua>
	<E16VwTl-0007VJ-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > > Yes, but that may change (in theory, at least.) Consistency is a virtue.
> > 
> > I'll do this cleanup if my KERN_INFO patches will be accepted, at least some 
> > of them. So far only Richard Gooch replied...
> 
> I ran some of them into 7ac1 but got rejects so I've dumped them out
> for now. They mostly look completely sensible

I'd prefer if tree maintainers (that means you, Alan:-) don't apply
devfs patches that didn't come from me. I've already posted a patch
which cleans up *all* the remaining printk()'s. In fact, it's a pair
of patches, one for 2.4.x and one for 2.5.x. That was yesterday. Today
I'm still seeing this thread being beaten to death.

Besides, this is hardly an urgent fix, so there's no great rush to
apply a random patch from someone else, even if I did sit on it for a
week or two. Applying random patches will just end up generating more
merge work for me down the track.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
