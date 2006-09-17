Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbWIQWVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbWIQWVw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 18:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbWIQWVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 18:21:52 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:12509 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965136AbWIQWVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 18:21:51 -0400
Date: Mon, 18 Sep 2006 00:13:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060917221328.GA8791@elte.hu>
References: <20060917084207.GA8738@elte.hu> <Pine.LNX.4.64.0609171627400.6761@scrub.home> <20060917152527.GC20225@elte.hu> <Pine.LNX.4.64.0609171744570.6761@scrub.home> <450D7EF0.3020805@yahoo.com.au> <Pine.LNX.4.64.0609171918430.6761@scrub.home> <20060917192359.GA24016@elte.hu> <Pine.LNX.4.64.0609172144200.6761@scrub.home> <20060917205628.GA2145@elte.hu> <Pine.LNX.4.64.0609172319370.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609172319370.6761@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > I am really sorry that you were able to misunderstand and 
> > misrepresent such a simple sentence.
> 
> Considering the context, which is not exactly full of support for 
> static tracer, I think my understanding was and still is quite 
> correct.

this thought of you is still false. Nick said:

 ' I think Ingo said that some "static tracepoints" (eg. annotation) 
   could be acceptable. '

to which you replied:

  ' No, he made it rather clear, that as far as possible he only wants 
    dynamic annotations (e.g. via function attributes). '

That "No" word at the beginning of your sentence, by its plain meaning, 
falsely questions Nick's correct interpretation of what I said. I ask 
you to retract or correct this false statement.

Nick is of course correct: i said before that some static markups could 
be acceptable. In fact, i even outlined a possible API for such static 
markups in 20060914231956.GB29229@elte.hu. Would I want to reduce the 
number of such static markups: of course, not wanting to reduce the 
number of subsystem-functionality unrelated source code lines would be 
foolish.

> > this makes it clear that i disagree with adding static markups for 
> > static tracers - but i of course still agree with static markups for 
> > _dynamic tracers_. The markups would be totally unusable for static 
> > tracers because there is no guarantee for the existence of static 
> > markups _everywhere_: the static markups would come and go, as per 
> > the "tracepoint maintainance model". Do you understand that or 
> > should i explain it in more detail?
> 
> Well, I rather just wait for the real patch, where you can show your 
> support for all possible users.

this answer of yours does not rectify the false statement you did.

Your sentence also introduces a new misrepresentation of my intentions: 
my intention with partial static markups (which intention i've written 
to you about before, so it was known to you when you wrote this 
stentence) is not to support "all possible users", but to support 
dynamic tracers. Static tracers cannot use static markups that go away 
into dynamic tracing scripts.

	Ingo
