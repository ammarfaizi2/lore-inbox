Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129100AbQKNDFL>; Mon, 13 Nov 2000 22:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129895AbQKNDEw>; Mon, 13 Nov 2000 22:04:52 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:1289 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129100AbQKNDEk>;
	Mon, 13 Nov 2000 22:04:40 -0500
Message-Id: <200011140135.eAE1ZTD11785@sleipnir.valparaiso.cl>
To: Chris Evans <chris@scary.beasts.org>
cc: Torsten.Duwe@caldera.de, Francis Galiegue <fg@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit 
In-Reply-To: Message from Chris Evans <chris@scary.beasts.org> 
   of "Mon, 13 Nov 2000 16:56:40 -0000." <Pine.LNX.4.21.0011131655430.22139-100000@ferret.lmh.ox.ac.uk> 
Date: Mon, 13 Nov 2000 22:35:29 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Evans <chris@scary.beasts.org> said:
> On Mon, 13 Nov 2000, Torsten Duwe wrote:
> > >>>>> "Francis" == Francis Galiegue <fg@mandrakesoft.com> writes:
> > 
> >     >> + if ((*p & 0xdf) >= 'a' && (*p & 0xdf) <= 'z') continue;
> > 
> >     Francis> Just in case... Some modules have uppercase letters too :)
> > 
> > That's what the &0xdf is intended for...

> Code in a security sensitive area needs to be crystal clear.

Nodz!

> What's wrong with isalnum() ?

Too efficient? ;)
--
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
