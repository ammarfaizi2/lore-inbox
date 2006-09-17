Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWIQTcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWIQTcV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 15:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWIQTcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 15:32:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:3541 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932371AbWIQTcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 15:32:20 -0400
Date: Sun, 17 Sep 2006 21:23:59 +0200
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
Message-ID: <20060917192359.GA24016@elte.hu>
References: <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home> <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home> <20060917084207.GA8738@elte.hu> <Pine.LNX.4.64.0609171627400.6761@scrub.home> <20060917152527.GC20225@elte.hu> <Pine.LNX.4.64.0609171744570.6761@scrub.home> <450D7EF0.3020805@yahoo.com.au> <Pine.LNX.4.64.0609171918430.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609171918430.6761@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4999]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > [...] I think Ingo said that some "static tracepoints" (eg. 
> > annotation) could be acceptable.
> 
> No, he made it rather clear, that as far as possible he only wants 
> dynamic annotations (e.g. via function attributes).

what you say is totally and utterly nonsensical misrepresentation of 
what i have said. I always said: i support in-source annotations too (I 
even suggested APIs how to do them), as long as they are not a total 
_guaranteed_ set destined for static tracers, i.e. as long as they are 
there for the purpose of dynamic tracers. I dont _care_ about static 
annotations as long as they are there for dynamic tracers, because they 
can be moved into scripts if they cause problems. But static annotations 
for static tracers are much, much harder to remove. Please go on and 
read my "tracepoint maintainance models" email:

 Message-ID: <20060917143623.GB15534@elte.hu>

	Ingo
