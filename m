Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWIOTQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWIOTQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWIOTQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:16:59 -0400
Received: from opersys.com ([64.40.108.71]:19466 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1750822AbWIOTQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:16:58 -0400
Message-ID: <450AFE81.2020409@opersys.com>
Date: Fri, 15 Sep 2006 15:26:57 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060915132052.GA7843@localhost.usen.ad.jp> <Pine.LNX.4.64.0609151535030.6761@scrub.home> <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu>
In-Reply-To: <20060915181907.GB17581@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> well, Jes has that experience and Thomas too.
...
> so does Thomas and Jes. So what's the point?

Either I'm too stupid for you to bother replying to any of my emails
(which is very possible) or, shall we say politely, you're not
exactly humble. I've responded to half a dozen of your emails, yet
you have not deemed it worthwhile to talk to me directly.

First you came out screaming that static tracepoints are heresy, and
then when there was non-ltt-specific interest being voiced for code
markup, you viciously set out to fud ltt as best you can using your
experience at implementing kernel tracers as ammunition. So answer
this simple question, how many tracers did you actually write which
were geared for non-kernel-developer users? Based on your own
account from yesterday, the answer I conclude is: NONE. I'd say
you've got pretty strong opinions about something you've never
attempted to do. Of course you claim that all tracers are the same,
how could they be different? But that's where experience talks and
hubris walks.

> i judge LTT by its current code quality, not by its proponents shouting 
> volume - and that quality is still quite poor at the moment.

You're either skillfully trying to steer arguments in your direction
or you're simply unaware of the basic rules of debating. You started
by saying that static instrumentation of any kind is evil, yet this
is demonstrably false, if nothing else by the outpour of experience
from those who have had to maintain non-inlined instrumentation. Then
you proceed to try to amalgamate this attack with a vicious attack on
ltt. I'll say it one more time: the ltt code gets posted to lkml
*for review*. If you're that concerned about the code, then go ahead
look at it and tell the maintainers what you'd like to see fixed.

Instead, you run out and come back and conclude "The best that Frank
and me came up ..." and then you present your own nomenclature for
static instrumentation. I mean, if nothing, else, have a little
decency for those who have put effort in trying to make this stuff work.

I mean, at least explain to me why you insist on using such a tone
against a project that is now within its 7th year of existence (a
pretty long lifetime if you ask me for something that has been
labeled useless all over this thread.) Do you actually realize the
lkml's past reluctance to admitting a standard tracing mechanism
into the kernel has actually contributed in doing great harm to those
who had put substantial personal and financial investment in getting
something to work. I'll spare you the political debates, but look at
past involvement of major corporate users in ltt and ask yourself why
they've decided to put their efforts elsewhere. We were basically told:
we cannot justify investing any further funds in a project which does
not seem to gain any sort of acceptance by the kernel developers.
I've never complained about this before because I don't like whining.
Do, however, realize that the fact that there are 4 separate teams
working on this in parallel (ltt, lkst, systemtap, lket, off the top
of my head) is directly due to the lack of success ltt has had in
being admitted into the kernel. Do, at least, realize that this is
huge miscarriage of the lkml process.

And finally, do realize that in 2000 I personally contacted the head
of the DProbes project IBM in order to foster common development,
following which ltt was effectively modified in order to allow
dynamic instrumentation of the kernel ...

cheesh ...

Karim
