Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWIPIat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWIPIat (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 04:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWIPIat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 04:30:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:65414 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932323AbWIPIar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 04:30:47 -0400
Date: Sat, 16 Sep 2006 10:22:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060916082214.GD6317@elte.hu>
References: <1158348954.5724.481.camel@localhost.localdomain> <450B0585.5070700@opersys.com> <1158351780.5724.507.camel@localhost.localdomain> <Pine.LNX.4.64.0609152236010.6761@scrub.home> <20060915204812.GA6909@elte.hu> <Pine.LNX.4.64.0609152314250.6761@scrub.home> <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609160139130.6761@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4976]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > > It's possible I missed something, but pretty much anything you 
> > > outlined wouldn't make the live of static tracepoints any easier.
> > 
> > sorry, but if you re-read the above line of argument, your sentence 
> > appears non-sequitor. I said "the markers needed for dynamic tracing are 
> > different from the LTT static tracepoints". You asked why they are so 
> > different, and i replied that i already outlined what the right API 
> > would be in my opinion to do markups, but that API is different from 
> > what LTT is offering now. To which you are now replying: "pretty much 
> > anything you outlined wouldn't make the life of static tracepoints any 
> > easier." Huh?
> 
> Yeah, huh?
>
> I have no idea, what you're trying to tell me. As you demonstrated 
> above your "right API" is barely usable for static tracers.

you raise a new point again (without conceding or disputing the point we 
were discussing, which point you snipped from your reply) but i'm happy 
to reply to this new point too: my suggested API is not "barely usable" 
for static tracers but "totally unusable". Did i tell you yet that i 
disagree with the addition of markups for static tracers?

	Ingo
