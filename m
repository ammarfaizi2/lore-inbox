Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312316AbSDXQj4>; Wed, 24 Apr 2002 12:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312332AbSDXQjz>; Wed, 24 Apr 2002 12:39:55 -0400
Received: from edu.joroinen.fi ([195.156.135.125]:41993 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S312316AbSDXQjy> convert rfc822-to-8bit;
	Wed, 24 Apr 2002 12:39:54 -0400
Date: Wed, 24 Apr 2002 19:39:52 +0300 (EEST)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: <pk@edu.joroinen.fi>
To: <jd@epcnet.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: AW: Re: VLAN and Network Drivers 2.4.x
In-Reply-To: <527944032.avixxmail@nexxnet.epcnet.de>
Message-ID: <Pine.LNX.4.33.0204241938140.32094-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Apr 2002 jd@epcnet.de wrote:

> > Von: <davem@redhat.com>
> > Gesendet: 24.04.2002 16:11
> >
> >    2.4.x-kernel, when it's useless without patching Network Drivers?
> > It is not useless for the drivers that have been fixed.
>
> Ok, but i have a stock 2.4.18 kernel, i can enable the VLAN option, recompile the kernel, configure a VLAN without any error or hint.
>
> BUT: If i try to do ftp or ping with a payload greater than 1468 my
> tulipbased ZNYX 346Q ethernetcards drop those packets. The driver or the
> card cannot handle those packets. They are to large. Maybe a driverpatch
> solve my problem - maybe not. The kernel itself doesn't care. vconfig
> doesn't barf. It silently fails.. not so good behaviour in my opinion.
> This is why there are always the same questions on the vlan mailinglist.
>

See linux-kernel archives.. some time ago Paul P Komkoff Jr <i@stingr.net>
posted a patch for tulip to make VLANs work.. the subject of the post was
something like "tulip and VLAN tagging".


> > Because the solutions are hardware specific to allow these extra
> > 4 bytes to be received by the card.  Some cards, in fact, cannot
> > support VLAN at all because they cannot be programmed at all to
> > take those 4 extra bytes.
>
> Ok. But why isn't there a "tag" (capabilities?) on the drivers which let vconfig barf with a message like "underlying network driver or hardware doesn't support VLAN"?
>
> > No it isn't useless.  There are many network drivers for which VLAN
> > works out of the box RIGHT NOW.
>
> Ok. But i don't get a message about the drivers which don't work. Which driver work/which not? Isn't it easier to tag all drivers as not VLAN-ready till somebody make a patch or confirm that its working with VLAN?
>
> On the other side, my ZNYX works "out of the box" too. It works till 1468 Bytes ;) - I tend to say that ALL nic-drivers/hardware work till 1468 Bytes. But its not the intention of VLAN to lower the MTU on each Client.
>


- Pasi Kärkkäinen


                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

