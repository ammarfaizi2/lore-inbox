Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWIOTT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWIOTT0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWIOTT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:19:26 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53387 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751393AbWIOTTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:19:25 -0400
Date: Fri, 15 Sep 2006 21:10:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Frank Ch. Eigler" <fche@redhat.com>,
       karim@opersys.com, Tim Bird <tim.bird@am.sony.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915191031.GA26754@elte.hu>
References: <Pine.LNX.4.64.0609151425180.6761@scrub.home> <1158327696.29932.29.camel@localhost.localdomain> <Pine.LNX.4.64.0609151523050.6761@scrub.home> <1158331277.29932.66.camel@localhost.localdomain> <450ABA2A.9060406@opersys.com> <1158332324.29932.82.camel@localhost.localdomain> <y0mmz91f46q.fsf@ton.toronto.redhat.com> <1158345108.29932.120.camel@localhost.localdomain> <20060915181208.GA17581@elte.hu> <Pine.LNX.4.64.0609152046350.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609152046350.6761@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4750]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> On Fri, 15 Sep 2006, Ingo Molnar wrote:
> 
> > this is being worked on actively: there's the "djprobes" patchset, 
> > which includes a simplified disassembler to analyze common target 
> > code and can thus insert much faster, call-a-trampoline-function 
> > based tracepoints that are just as fast as (or faster than) 
> > compile-time, static tracepoints.
> 
> Who is going to implement this for every arch?

someone who is interested enough in that arch growing that capability?

> Is this now the official party line that only archs, which implement 
> all of this, can make use of efficient tracing?

that's certainly my preference - kprobes have lots of other advantages 
besides tracing. Whether that becomes the "official party line" depends 
on the technological analysis of the situation which will ultimately 
shape the outcome of this discussion.

	Ingo
