Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281291AbRKETt3>; Mon, 5 Nov 2001 14:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281293AbRKETtT>; Mon, 5 Nov 2001 14:49:19 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:15251 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S281291AbRKETtJ> convert rfc822-to-8bit; Mon, 5 Nov 2001 14:49:09 -0500
Date: Mon, 5 Nov 2001 18:04:05 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, John Fremlin <john@fremlin.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [POLITICAL] Re: ECS k7s5a audio sound SiS 735 - 7012
In-Reply-To: <3BE5C699.4FF8322B@colorfullife.com>
Message-ID: <20011105175245.X1658-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Nov 2001, Manfred Spraul wrote:

> Jeff Garzik wrote:
> >
> > Gérard Roudier wrote:
> > > different from Tekram adapters. Btw, my Netgear FA311 board is not handled
> > > by the sis driver of linux-2.2.20 and my little finger tells me that it
> > > could be so given a few code addition.
> >
> > Unless you have a really strange board I haven't seen, NetGear FA311 are
> > the natsemi DP83815/6 chips, handling by either "natsemi" or "fa311"
> > drivers, not "sis900" driver...
> >
> sis900 and natsemi are similar, probably both could be handled with one
> driver.
> e.g. freebsd has one driver for natsemi and sis900.
>
> But I'm not a big fan of huge drivers that handle multiple 99%
> compatible controllers and always break for one controller if you try to
> fix another controller, so I won't try to merge them.

So you would have preferred, for example, to have dozens of different
drivers for SYM53C8XX chips and probably as many for Adaptec aic7xxx ones.
And, probably, one set of different drivers per O/S. And why not one set
per O/S major version and even per adjacent ones of the same O/S.

Given all the different brands that use similar or compatibles chips, the
way you want drivers to be developped and maintained looks just
unrealistic to me.

  Gérard.

