Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263595AbREYG67>; Fri, 25 May 2001 02:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263597AbREYG6t>; Fri, 25 May 2001 02:58:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9925 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263595AbREYG6l>;
	Fri, 25 May 2001 02:58:41 -0400
Date: Fri, 25 May 2001 02:58:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Aaron Lehmann <aaronl@vitelus.com>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, adam@yggdrasil.com,
        linux-kernel@vger.kernel.org
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
In-Reply-To: <20010524234240.G23155@vitelus.com>
Message-ID: <Pine.GSO.4.21.0105250244310.24864-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 May 2001, Aaron Lehmann wrote:

> On Fri, May 25, 2001 at 02:34:05AM -0400, Alexander Viro wrote:
> > Should we file bug reports against glibc?
> 
> invsqrtpi=  5.64189583547756279280e-01
> Inverted square root of pi. Want to file a bug on Pi?

Nope. Well-known constant.

> tpi      =  6.36619772367581382433e-01,
> R0/S0 on [0, 2.00]
> 
> I'm not sure what R and S are, but the glibc developers probably are.
> IMHO poorly documented code is different from binary-only code.
> However, it appears to be a sketchy line.

It _is_ a sketchy line. In that case you can be damn sure that constants
had been derived from other form. And you need that other form to do any
modifications that wouldn't turn the thing into random junk.

Normally you don't need it, unless you feel that one you have in glibc is
not good enough for your needs or want to experiment with modifying it.
Or analise the thing.

It's pretty similar to the case in question. The only difference is that
information needed to implement Bessel functions from scratch is easier
to find. However, it will be reimplementing from scratch. It won't help
you to answer any questions about the accuracy of implementation in glibc,
etc.

