Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWIPIcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWIPIcF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 04:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWIPIcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 04:32:05 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54984 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932322AbWIPIcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 04:32:02 -0400
Date: Sat, 16 Sep 2006 10:23:28 +0200
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
Message-ID: <20060916082328.GF6317@elte.hu>
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
	[score: 0.4998]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > > > Secondly, even people who intend to _eventually_ make use of 
> > > > tracing, dont use it most of the time. So why should they have 
> > > > more overhead when they are not tracing? Again: the point is not 
> > > > moot because even though the user intends to use tracing, but 
> > > > does not always want to trace.
> > > 
> > > I've used kernels which included static tracing and the perfomance 
> > > overhead is negligible for occasional use.
> > 
> > how does this suddenly make my point, that "a marker for dynamic 
> > tracing has lower performance impact than a static tracepoint, on 
> > systems that are not being traced", "moot"?
> 
> Why exactly is the point relevant in first place? How exactly is the 
> added (minor!) overhead such a fundamental problem?

how could a fundamental performance difference between two markup 
schemes be not relevant to kernel design decisions? Which performance 
difference i claim derives straight from the conceptual difference 
between the two approaches and is thus "unfixable" (and not an 
"implementational issue").

	Ingo
