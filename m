Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316237AbSEZSCr>; Sun, 26 May 2002 14:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316238AbSEZSCr>; Sun, 26 May 2002 14:02:47 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:2062 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S316237AbSEZSCp>; Sun, 26 May 2002 14:02:45 -0400
Message-ID: <3CF122CA.EFE2D328@opersys.com>
Date: Sun, 26 May 2002 14:00:42 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Roman Zippel <zippel@linux-m68k.org>,
        David Woodhouse <dwmw2@infradead.org>, Larry McVoy <lm@bitmover.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Linus Torvalds <torvalds@transmeta.com>, Wolfgang Denk <wd@denx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <20020526082142.C18843@hq.fsmlabs.com> <Pine.LNX.4.21.0205261722570.17583-100000@serv> <20020526105506.A20002@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


yodaiken@fsmlabs.com wrote:
> If you are using purely GPL software or some other non-commercial software
> then you don't need a lawyer. If you are using standard Linux software
> that does not make use of the method, you don't need a a lawyer.

Not needing a lawyer != not needing to purchase a license.

Hence, would it be fair to rephrase this last portion as follows:
"If you are using purely GPL software or some other non-commercial software
then you don't need __to purchase a license from FSMLabs__. If you are using
standard Linux software that does not make use of the method, you don't need
__to purchase a license from FSMLabs__.

A simple yes/no will suffice.

> If you
> are developing commercial RT software that does make use of the method, then
> there is no generic and simple rule,

What is "use of the method"? Can you provide a list of approved uses, a
list of uncertain uses, and a list of uses requiring a license? Surely
FSMLabs' business records contain enough information to provide future
potential users with clear-case scenarios.

> just as there is no generic and simple
> rule for what is "derived work" and what is "simple aggregation".
> People who are developing such software can (A) ask us for specific
> information about whether we think the software is covered or
> (B) get their own legal advice.

(A) has been attempted before and I know people to which you provided
unclear answer over the phone to the following question:
"Do I need to purchase a license from FSMLabs if I write an RTAI rt applications?"

Care to answer it now? This is a fairly straight-forward non-convoluted
case.

(B) does not preclude you from suing the users. So lawyers will always
bet on the safe side and say "don't use Linux".

> If we say that a commercial license is not
> required, they can rely on it. What we cannot offer is a rule that
> can be defeated by syntactic means.

Why not? Don't you have enough practical examples within your day
to day business to provide us with clear no-nonense example scenarios?

> For example, writing a chunk of code
> that is practicing the method, and splitting it into parts so you
> can hide the  valuable IP in one component while GPL'ing the
> rest, is not acceptable. Taking what is certainly an OS module that
> is required to be GPL and turning on the "user mode" bit and calling it
> an "application" does not work either.

What is the "user mode" bit? Does your statement apply to the RTAI hard-rt
user-space applications which have been described earlier on this list?

> Similarly, I doubt
> as one  can write a non-GPL module for gcc, run it under NetBSD as a BSD
> kernel module and claim benefit of the BSD License to close it.

I don't think that such a comparison can be applied. For one thing, the
FSF does not own a patent on gcc. Your particular case is quite unique in
the open source world. You're the only open source contributor who has
decided to license his software in GPL and then use a patent to collect
royalties on the commercial use of this work.

> Our patent is a US patent: people in Europe who say they are worried about
> RTLinux patent issues may really have more to worry about if they are
> using code that should be inheriting our GPL license and are incorporating
> it in non-GPL software without our permission.
> Well, there are also some
> somewhat similar German software patents that might also worry them.

So too should your clients be very worried as to the code you are selling
them. Any one of the current RTAI developers can now sue you and your
clients for code theft. Not only is this based on the RTAI team's
assesment, but this is now publicly substantiated by your own employees.

RTAI developers may have mislabeled some licenses, but they sure as hell
don't sell closed-source versions of the resulting code.

> Embedded software is one of the most highly patented areas. It is beyond
> irony when our European friends tell us that companies like Schneider
> are horrified by the existence of the patent.  Please forgive my
> cynicism, but most of the complaints seem to come from people who want to
> write software for money for customers that own
> huge patent portfolios.  If you are engaged in such a business, then you
> clearly have no principled disagreement with patent and other
> software licenses. As Churchill put it, we have established what you are,
> we are only quibbling about the price.

Clearly, you have no moral leg to stand on Victor. The fact that no
other open source contributor or company established by said contributor
has chosen to license his software in GPL and then use a patent to
collect royalties clearly shows that you are at odds with the spirit
of open source.

Long gone is the time when this debate was about "moral purity".
This debate is about how your patent is causing Linux not to be used
in an entire application field and what are the possible future avenues.

At this point, I would like to point out that an ex-parte patent reexamination
costs 2,000USD to be started and any member of the public can participate
in providing "prior art" once the process has started. The only issue
to watch out for here is that the initiating party can only use this
process once. After that, he is forbiden to ever start another ex-parte
patent reexamination on said patent. So whoever thinks about trying this
should better be well prepared and have good counsel. One thing that this
is certain, however, is that there is no lack of "prior art" as I am sure
anyone on this list can testify.

There's also the inter-partes reexamination, but I don't think it can
be applied to this patent given the timeline of its passing into law.
But I may be wrong.

> I don't claim to be writing software in order to benefit mankind. We
> have a business that, like old-fashioned businesses, stresses
> profits although I hope very much we are living up to our ethical
> principles as well.

As I was telling Larry earlier. The software industry as we know it is an
endangered species. You have established your business of very shaky
foundations and are endangering both you, your users/clients and Linux.

> For  both ethical and practical business reasons, we are
> in no way inclined to try to strangle off competing uses of the patented
> method. Our commercial license fees are _low_ and we have not turned down
> anyone who asked for licenses.

The problem isn't the price of your license, it is its very existence.

BTW, you still haven't answered my questions.

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
