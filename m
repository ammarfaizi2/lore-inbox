Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262026AbRENBEb>; Sun, 13 May 2001 21:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262035AbRENBEV>; Sun, 13 May 2001 21:04:21 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:64261 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S262026AbRENBEB>;
	Sun, 13 May 2001 21:04:01 -0400
Message-Id: <200105140103.f4E13U3r010249@sleipnir.valparaiso.cl>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
cc: Wayne.Brown@altec.com, Hacksaw <hacksaw@hacksaw.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Not a typewriter 
In-Reply-To: Message from "Mike A. Harris" <mharris@opensourceadvocate.org> 
   of "Sun, 13 May 2001 19:35:06 -0400." <Pine.LNX.4.33.0105131928570.1590-100000@asdf.capslock.lan> 
Date: Sun, 13 May 2001 21:03:30 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mike A. Harris" <mharris@opensourceadvocate.org> said:
> On Fri, 11 May 2001 Wayne.Brown@altec.com wrote:

[...]

> >why creat doesn't end in an "e;" and so forth.  I tell the

The old C compiler/old Unix linker guaranteed 6 chars in an external symbol
name only, and C functions got an underscore prepended: _creat. I guess
this is the reason for this wart. As to why 6 chars only, I'd guess some
data structure in the linker was laid out that way. Machines had a few
dozen Kbs of RAM then, space was precious.

> What is the reason for that?  Also wondered why it is resolv.conf
> and not resolve.conf or resolver.conf...

Old FS handled only 14 chars in names, but that clearly isn't the reason
here (11 chars). Some other operating system perhaps?

> Were they afraid that "e" being the most widely used letter in
> the English language was going to war out thir xpnsiv kyboards if
> thy usd it all th tim?

Funny conspiracy suscpicion, that... ;-)
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
