Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317692AbSFLNF7>; Wed, 12 Jun 2002 09:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317697AbSFLNF6>; Wed, 12 Jun 2002 09:05:58 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:11434 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S317692AbSFLNF6>;
	Wed, 12 Jun 2002 09:05:58 -0400
Date: Wed, 12 Jun 2002 09:00:08 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Lincoln Dale <ltd@cisco.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        "David S. Miller" <davem@redhat.com>,
        Ben Greear <greearb@candelatech.com>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: RFC: per-socket statistics on received/dropped packets 
In-Reply-To: <5.1.0.14.2.20020612224038.0251bd08@mira-sjcm-3.cisco.com>
Message-ID: <Pine.GSO.4.30.0206120853320.799-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jun 2002, Lincoln Dale wrote:

> At 08:33 AM 12/06/2002 -0400, jamal wrote:
> > > i know of many many folk who use transaction logs from HTTP caches for
> > > volume-based billing.
> > > right now, those bills are anywhere between 10% to 25% incorrect.
> > >
> > > you call that "extremely limited"?
> >
> >Surely, you must have better ways to do accounting than this -- otherwise
> >you deserve to loose money.
>
> many people don't have better ways to do accounting than this.
>

Then they dont care about loosing money.
There's nothing _more important_ to a service provider than ability to do
proper billing. Otherwise, they are a charity organization.

> in the case of Squid and Linux, they're typically using it because its
> open-source and "free".

I am hoping you didnt mean to say squid was only good because it has
these perks.

>
> they want to use HTTP Caching to save bandwidth (and therefore save money),
> but they also live in a regime of volume-based billing.  (not everywhere on
> the planet is fixed-$/month for DSL).
>
> the unfortunate solution is to use HTTP Transaction logs, which count
> payload at layer-7, not payload+headers+retransmissions at layer-3.
>

Look at your own employers eqpt if you want to do this right.
And then search around freshmeat so you dont reinvent the wheel.

> > > of course, i am doing exactly what Dave said to do -- maintaining my own
> > > out-of-kernel patch -- but its a pain, i'm sure it will soon conflict with
> > > stuff and is a damn shame - it isn't much code, but Dave seems pretty
> > > steadfast that he isn't interested.
> >
> >You havent proven why its needed. And from the looks of it you dont even
> >need it.
>
> i don't need it because i already have it in my kernel.
> but thats where it ends -- its destined to forever be a private patch.
>

And until you prove it is worth it and useful to other people then
forever thats where it belongs. I now of nobody serious about billing
who is using sockets stats as the transaction point.

> >If 3 people need it, then i would like to ask we add lawn mower
> >support that my relatives have been asking for the last 5 years.
>
> lawn-mower support sounds like a userspace application to me.
>

But we need a new system call support

cheers,
jamal

