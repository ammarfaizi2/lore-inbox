Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSEYEyc>; Sat, 25 May 2002 00:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313512AbSEYEyb>; Sat, 25 May 2002 00:54:31 -0400
Received: from relay02.valueweb.net ([216.219.253.236]:40457 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S313508AbSEYEya>; Sat, 25 May 2002 00:54:30 -0400
Message-ID: <3CEF189C.2124DEC9@opersys.com>
Date: Sat, 25 May 2002 00:52:44 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205242059410.4177-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:
> Most people don't need that. In fact, most people could probably do
> perfectly well with just soft realtime, and to a lot of those people "hard
> realtime" is just a marketing term.

Actually, most people I know think that it's the other way around:
real-time==hard-real-time and soft-real-time==marketing buzzword.

> > Sure. I'm not contesting the merits of using GPL modules. True, this
> > is the best way to go. However, not everyone has this option and my
> > claim is that this is one of the facts that is putting Linux out in the
> > cold in front of the competition in regards to rt.
> 
> You know what? I don't care.

Fine by me, it's your kernel.

> If the RTAI people are trying to make it easy
> for non-GPL module people, I have absolutely zero interest.

Ok, so you think that having hard-rt in user-space was all done for evading
the patent?

FYI, this was designed and implemented in late 1999, early 2000. At the time,
all this patent crap hadn't surfaced yet!

So please, before declaring "zero interest" for our work, at least check it
out first.

> In contrast, I _am_ interested if the kernel module is required to be (a)
> small, (b) clear (c) GPL. You seem to not care about any of the three
> things _I_ care about.

I don't see where I said this. I do care about all of those things. Heck,
the entirety of the tools I developped are GPL. I sell 0$ of closed-source
software. >>>0$<<<

In addition to those a,b,c, I actually care about the proliferation of
the Linux kernel into a field which seriously needs it. What I have
witnessed in the field is that Linux is simply not used because of the
reasons I mentionned earlier.

It evades me, why you shouldn't care about Linux's proliferation in that
field and that you so easily dismiss the real-time Linux community's
worries which I am relaying to you.

> > Again, from a purely technical standpoint, there are many advantages in
> > having the hard-rt tasks in user-space.
> 
> That's simply not true.
> 
> In user space, you'll never get the kinds of low overheads for the _true_
> hard realtime, and to me that just says that what you're talking about is
> really mostly just a slightly hardened soft-realtime.

No. This is true hard-real-time. For God's sake, download RTAI and do
the measurements yourself if you don't want to take my word for it.
These hard-real-time processes are truely hard-hard-hard-realtime!!!

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
