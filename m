Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268598AbRGZSBh>; Thu, 26 Jul 2001 14:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268607AbRGZSB1>; Thu, 26 Jul 2001 14:01:27 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:22291 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268598AbRGZSBO>; Thu, 26 Jul 2001 14:01:14 -0400
Message-ID: <3B605A3B.6E95AE36@namesys.com>
Date: Thu, 26 Jul 2001 21:58:19 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Andre Pang <ozone@algorithm.com.au>
CC: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010726174844.W17244@emma1.emma.line.org> <E15PnTJ-0003z0-00@the-village.bc.nu> <9jpftj$356$1@penguin.transmeta.com> <20010726095452.L27780@work.bitmover.com> <996167751.209473.2263.nullmailer@bozar.algorithm.com.au>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Andre Pang wrote:
> 
> On Thu, Jul 26, 2001 at 09:54:52AM -0700, Larry McVoy wrote:
> 
> > What I'm trying to say is that I think Daniel is one of the good guys,
> > even though his user interface could stand improvement (a common thing
> > amongst smart people) and it looks like it would be smart to figure out
> > how to work with him.
> 
> there's a work-in-progress called ReiserSMTP[1] which rewrites
> some bits of qmail so it works better with ReiserFS, although i
> can imagine that it would improve things on Linux as a whole.

It stopped due to flakiness on the part of all parties including myself, the programmer, and the
sponsor, but it would be nice if a sponsor and programmer came along to restart it.

> 
> this is getting off-topic, but since the various parties involved
> (Linux vs djb/Wietse/etc[2]) are probably never going to agree
> on semantics, i'm wondering if it's possible to ask them to
> write the software in such a way that it's possible to 'drop in'
> your own functions relevant for sync'ing.  then the MTA writers
> can go and use their traditional filesystem assumptions and
> Linux users can produce very small patches to support the
> correct behaviour under Linux.
> 
> it would be _nice_ if the ext3 guys would be more willing to
> implement directory-syncing on link/rename/etc, though, even as
> an option.  a 'mount -o dirsync' would be enough; no need for
> chattr +D stuff.  Linux tends to have a bad name as a platform
> as an MTA just because of all this, which is a shame.  it would be
> nice if a fix is possible.  *nudge nudge Mr. Morton* :)
> 
>     [1] http://www.jedi.claranet.fr/reisersmtp.html
> 
>     [2] hey, this might be the first time they agree on
>         anything!
> 
> --
> #ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


No, Linus is right and the MTA guys are just wrong.  The mailers are the place to fix things, not
the kernel.  If the mailer guys want to depend on the kernel being stupidly designed, tough. 
Someone should fix their mailer code and then it would run faster on Linux than on any other
platform.

Hans
