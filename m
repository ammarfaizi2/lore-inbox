Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265103AbUELPTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265103AbUELPTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 11:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265104AbUELPTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 11:19:04 -0400
Received: from metawire.org ([24.73.230.118]:40253 "EHLO mail.metawire.org")
	by vger.kernel.org with ESMTP id S265103AbUELPTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 11:19:00 -0400
Date: Wed, 12 May 2004 10:19:07 -0500 (EST)
From: jnf <jnf@datakill.org>
X-X-Sender: jnf@metawire.org
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new laptop woes
In-Reply-To: <40A1CEEF.5090309@aitel.hist.no>
Message-ID: <Pine.BSO.4.58.0405121014380.4366@metawire.org>
References: <Pine.BSO.4.58.0405111058520.5233@metawire.org>
 <40A1CEEF.5090309@aitel.hist.no>
X-SUPPORT: 0xDEADFED5 lab pr0ud supp0rt3rz 0f pr0j3kt m4yh3m
X-GPG-FINGRPRINT: 7DB1 AEED B2C7 FE09 433C  5106 B0A0 1E4C 084B 8821
X-GPG-PUBLIC_KEY: http://www.bombtrack.org/~jnf/jnf.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> Looking at other card drivers, you'll find out what a driver look like.
> You'll learn how a card driver interfaces to the kernel.
> To write a driver for this card you _need_ to know how that particular
> card is programmed. (What io adresses do it use, what do they mean,
> what are the timing requirements, and so on.)
> Looking at other drivers won't help you with that, unless one of the
> other drivers happens to use the same chips. This information is in the
> specs that broadcom so far haven't released.  Of course you can
> write to broadcom, perhaps they'll inform you when they see you
> are serious about this.

I figured as much, and I intend to use some of the other wlan drivers as a 
framework and to get a better idea of how to interface it, as for the io 
addresses/timing/etc, I was thinking that if you can use (i could be 
misremembering the name of the project) ... use the ndis wrappers and use 
an xp driver, it should be possible to just make the wrapper very verbose, 
id think anyways- although id have to look through the wrappers source and 
get a feel for how it works before i could really make that statement.
This is somewhat off topic to the discussion, but really its not- does the 
dmca restrict me from doing such a thing?

 
> The card is not assigned an irq precicely because it has no driver.
> IRQ's aren't handed out because devices exists - they are handed
> out because device drivers request them from the kernel.

i was pretty sure thats how it worked, but my level of programming in this 
specific arena is fairley minimal. Anyways, thanks for the tips/advice.

 
> Helge Hafting


jnf

- --

It is only the great men who are truly obscene.  If they had not dared to 
be obscene, they could never have dared to be great.
                -- Havelock Ellis


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (OpenBSD)

iD8DBQFAokBusKAeTAhLiCERAvEZAJ4rr9Hyz8loJhcwJ8EuhMjH6XQ4WgCfb+Pt
ljtdzfPIn2p6SCQEMahuN44=
=gDkG
-----END PGP SIGNATURE-----
