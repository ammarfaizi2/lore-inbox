Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317851AbSGVUyn>; Mon, 22 Jul 2002 16:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSGVUym>; Mon, 22 Jul 2002 16:54:42 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11786 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317851AbSGVUyk>; Mon, 22 Jul 2002 16:54:40 -0400
Date: Mon, 22 Jul 2002 16:50:07 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Jones <davej@suse.de>
cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
In-Reply-To: <20020718222229.B21997@suse.de>
Message-ID: <Pine.LNX.3.96.1020722163826.28574H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Dave Jones wrote:

> On Thu, Jul 18, 2002 at 12:46:43PM -0400, Bill Davidsen wrote:

>  > > o Full compliance with IPv6                       (Alexey Kuznetzov, Jun Murai, Yoshifuji Hideaki, USAGI team)
>  > 	could ease in 2.6.x if not?
> 
> Davem's call I guess. ISTR the USAGI work was a rather large patch which
> if in Davem's shoes, I'd be rather dubious about taking 'all-in-one'.

Before the freeze it should be fine, after all if working IDE is optional
in a development kernel IPV6 is certainly not a must-have (unless it
seriously break IPV4, obviously).
 
>  > > o Add support for NFS v4                          (NFS v4 team)
>  > 	This really shouldn't wait for 2.8!
> 
> Last I saw of this patch it was still against something like 2.4.1,
> so they have a lot of catch up to do. This fact asides, if it doesn't
> touch common code, there's no reason it can't go in post-feature freeze
> in the same way as a driver/additional fs. Depends how much it touches.
> That said, are there really that many NFSv4 hosts out there that make
> this a *must have* feature ? Are any other *nix vendors shipping NFSv4 yet?

Not that I have used, this was more of a preemptive effort to get it in
2.6 rather than 2.8, since most vendors will be shipping in less than a
year if you believe their unofficial comments. And if the benefits are
there it would be a good thing to have first, perhaps.

>  > > o Overhaul PCMCIA support                         (David Woodhouse, David Hinds)
>  > 	Sure would be nice if it worked on desktops as well as laptops
> 
> "works for me". Admittedly I've not played with pcmcia much, but it
> seems at least if you choose the right hardware it works fine.

I haven't had it work since about 2.6 on a BP6 with an adaptor, but it did
work in 2.4.early. Of course it could be related to the new IDE stuff
making compact flash fail, but even building a uni kernel doesn't help. I
bought a cheap used laptop just to use as a card reader, but I'd rather
not stay that way ;-) Guess for now that's the "right hardware."

Thanks for all the additional feedback.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

