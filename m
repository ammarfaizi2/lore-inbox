Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbRGAKmV>; Sun, 1 Jul 2001 06:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265090AbRGAKmM>; Sun, 1 Jul 2001 06:42:12 -0400
Received: from edu.joroinen.fi ([195.156.135.125]:55559 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S265077AbRGAKmE> convert rfc822-to-8bit;
	Sun, 1 Jul 2001 06:42:04 -0400
Date: Sun, 1 Jul 2001 13:42:01 +0300 (EEST)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: <pk@edu.joroinen.fi>
To: Tom Rini <trini@kernel.crashing.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Broken tulip in 2.4.5+
In-Reply-To: <20010630182110.A1144@opus.bloom.county>
Message-ID: <Pine.LNX.4.33.0107011339100.24303-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 30 Jun 2001, Tom Rini wrote:

> Hello.  The current tulip driver in 2.4.5 and up no longer works with my
> 'tulip' ethernet card.  0.9.14 (what's in prior to 2.4.5-pre6, iirc) works
> fine with the card, as does de4x5.  Version 0.9.15-pre5 (2.4.6-pre8) and
> 1.1.8 (from sourceforge) both don't work.
>

I am seeing the same problem.
I had to plug my tulip to 10Mbps HUB yesterday, and it couldn't autosense
(options=0) 10Mbps Halfduplex! It tried to use 100Mbps or something..

Also, If I try to create 100Mbps Fullduplex connection with cross-cable
between two tulip-cards (2.2.19 on the other end, and 2.4.5 on the other
end) it doesn't work either.


- Pasi Kärkkäinen

                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

