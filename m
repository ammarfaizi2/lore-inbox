Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262572AbRENXc5>; Mon, 14 May 2001 19:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262577AbRENXcr>; Mon, 14 May 2001 19:32:47 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:64153 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262572AbRENXc3>; Mon, 14 May 2001 19:32:29 -0400
Date: Mon, 14 May 2001 17:32:13 -0600
Message-Id: <200105142332.f4ENWDO19375@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: hpa@transmeta.com (H. Peter Anvin), jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        torvalds@transmeta.com (Linus Torvalds), viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zOfH-0001LG-00@the-village.bc.nu>
In-Reply-To: <3B0038B3.EBB9747A@transmeta.com>
	<E14zOfH-0001LG-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > > (c) does not require devfs.  most distros ship without it afaik, and
> > > switching to it is not an overnight process, and requires devfsd to be
> > > useful in the real world.
> > > 
> > 
> > It does, however, not manage permissions, nor does it provide for a sane
> > namespace (it exposes too many internal implementation details in the
> > interface -- in particular, the driver becomes part of the namespace, and
> > devices move around between drivers regularly.)
> 
> It is also very hard to tar that device file.
> 
> As to devfsd well Al Viro was reporting races in it long ago that I
> don't believe Richard has had time to fix nor has anyone else fixed.

Actually, it was devfs, not devfsd that Al was complaining about.
Fortunately these races are hard to trigger without deliberately
trying to trigger them, otherwise I'd be inundated with bug reports
:-/

> What is the state on devfs there ?

Getting very close now. This last weekend was my first time for ages
that I've had an uninterrupted weekend to hack on Linux and didn't
have other really urgent stuff to deal with.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
