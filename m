Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbWIQVce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWIQVce (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 17:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbWIQVce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 17:32:34 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:6805 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965113AbWIQVcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 17:32:33 -0400
Date: Sun, 17 Sep 2006 23:23:45 +0200
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
Message-ID: <20060917212345.GB2145@elte.hu>
References: <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home> <20060917084207.GA8738@elte.hu> <Pine.LNX.4.64.0609171627400.6761@scrub.home> <20060917152527.GC20225@elte.hu> <Pine.LNX.4.64.0609171744570.6761@scrub.home> <450D7EF0.3020805@yahoo.com.au> <Pine.LNX.4.64.0609171918430.6761@scrub.home> <450D8C58.5000506@yahoo.com.au> <Pine.LNX.4.64.0609172027120.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609172027120.6761@scrub.home>
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

> > For example people wanted pluggable (runtime and/or compile time CPU 
> > scheduler in the kernel. This was rejected (IIRC by Linus, Andrew, 
> > Ingo, and myself). No doubt it would have been useful for a small 
> > number of people but it was decided that it would split testing and 
> > development resources. The STREAMS example is another one.
> 
> Comparing it to STREAMS is an insult and Ingo should be aware of this. 
> :-(

so in your opinion Nick's mentioning of STREAMS is an insult too? I 
certainly do not understand Nick's example as an insult. Is STREAMS now 
a dirty word to you that no-one is allowed to use as an example in 
kernel maintanance discussions?

Let me recap how I mentioned STREAMS for the first time: it was simply 
the best example i could think of when you asked the following question:

> > Why don't you leave the choice to the users? Why do you constantly 
> > make it an exclusive choice? [...]
>
> [...]
>
> the user of course does not care about kernel internal design and 
> maintainance issues. Think about the many reasons why STREAMS was 
> rejected - users wanted that too. And note that users dont want 
> "static tracers" or any design detail of LTT in particular: what they 
> want is the _functionality_ of LTT.

(see <20060915231419.GA24731@elte.hu> for the full context. Tellingly, 
that point of mine you have left unreplied too.)

btw., you still have not retracted or corrected your false suggestion 
that "concessions" or a "compromise" were possible and you did not 
retract or correct your false accusation that i "dont want to make 
them":

> It's impossible to discuss this with you, because you're absolutely 
> unwilling to make any concessions. What am I supposed to do than it's 
> very clear to me, that you don't want to make any compromise anyway?

while, as i explained it before, such a concession simply does not exist 
- so i am not in the position to "make such a concession". There are 
only two choices in essence: either we accept a generic static tracer, 
or we reject it.

(see <Pine.LNX.4.64.0609171744570.6761@scrub.home>)

	Ingo
