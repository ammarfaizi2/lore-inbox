Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281327AbRKEUwm>; Mon, 5 Nov 2001 15:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281328AbRKEUwe>; Mon, 5 Nov 2001 15:52:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6920 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281327AbRKEUw2>; Mon, 5 Nov 2001 15:52:28 -0500
Date: Mon, 5 Nov 2001 12:49:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6
In-Reply-To: <20011102120108.A47@toy.ucw.cz>
Message-ID: <Pine.LNX.4.33.0111051241410.3682-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Nov 2001, Pavel Machek wrote:
>
> > Oh, and the first funny patches for the upcoming SMT P4 cores are starting
> > to show up. More to come.
>
> What is SMT P4?

It's the upcoming symmetric multi-threading on the P4 chips (disabled in
hardware in currently selling stuff, but apparently various Intel contacts
already have chips to test with).

Basically, you get two virtual CPU's per die, and each CPU can run two
threads at the same time. It slows some stuff down, because it makes for
much more cache pressure, but Intel claims up to 30% improvement on some
loads that scale well.

The 30% is probably a marketing number (ie it might be more like 10% on
more normal loads), but you have to give them points for interesting
technology <)

> > Anybody out there with cerberus?
> >
> > 		Linus "128MB of RAM and 1GB into swap, and happy" Torvalds
>
> Someone go and steal 64MB from Linus....

Hey, hey. I actually have spent a _lot_ of time with 40MB of RAM and KDE
over the last few weeks. And this is with DRI on a graphics card that also
seems to eat up 8MB just for the direct rendering stuff, _and_ with kernel
profiling enabled, so it actually had more like 30MB of "real" memory
available. In 1600x1200, 16-bit color.

Konqueror is a pig, but it's _usable_. I did real work, including kernel
compiles, with it.

Admittedly I do like the behaviour with 2GB a lot better. That way I can
cache every kernel tree I work on, and not ever think about "diff" times.

		Linus

