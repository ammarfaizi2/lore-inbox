Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWIOTn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWIOTn5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWIOTn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:43:57 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:26791 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751532AbWIOTn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:43:56 -0400
Date: Fri, 15 Sep 2006 21:43:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060915181907.GB17581@elte.hu>
Message-ID: <Pine.LNX.4.64.0609152111030.6761@scrub.home>
References: <20060915132052.GA7843@localhost.usen.ad.jp>
 <Pine.LNX.4.64.0609151535030.6761@scrub.home> <20060915135709.GB8723@localhost.usen.ad.jp>
 <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>
 <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com>
 <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org>
 <20060915181907.GB17581@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Sep 2006, Ingo Molnar wrote:

> > What Karim is sharing with us here (yet again) is the real in-field 
> > experience of real users (ie: not kernel developers).
> 
> well, Jes has that experience and Thomas too.
> 
> > I mean, on one hand we have people explaining what they think a 
> > tracing facility should and shouldn't do, and on the other hand we 
> > have a guy who has been maintaining and shipping exactly that thing to 
> > (paying!) customers for many years.
> 
> so does Thomas and Jes. So what's the point?

That only Karim's experience is being in question here?

> i judge LTT by its current code quality, not by its proponents shouting 
> volume - and that quality is still quite poor at the moment. (and then 
> there are the conceptual problems too, outlined numerous times) I have 
> quoted specific example(s) for that in this thread. Furthermore, LTT 
> does this:
> 
>  246 files changed, 26207 insertions(+), 71 deletions(-)
> 
> and this gives me the shivers, for all the reasons i outlined.

Well, I'm first to admit that LTT needs improvement, but that has never 
been the point.

We need to get to some kind of agreement what level of tracing Linux 
should support in general, preferably something that is easy to 
integrate and usable by everyone. Especially the latter means that there 
is not one true solution, so we need to figure out what kind of common
infrastructure can be implemented, from which all of them can benefit.

At this point you've been rather uncompromising contrary to every single 
argument from either side.

bye, Roman
