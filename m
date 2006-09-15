Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWIOVRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWIOVRb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWIOVRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:17:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:61854 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932269AbWIOVRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:17:30 -0400
Date: Fri, 15 Sep 2006 23:08:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915210849.GA11291@elte.hu>
References: <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <Pine.LNX.4.64.0609152252540.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609152252540.6761@scrub.home>
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

> Hi,
> 
> On Fri, 15 Sep 2006, Ingo Molnar wrote:
> 
> > i'm also looking at it this way too: you already seem to be quite 
> > reluctant to add kprobes to your architecture today. How reluctant 
> > would you be tomorrow if you had static tracepoints, which would 
> > remove a fair chunk of incentive to implement kprobes?
> 
> If I see that whole teams spend years to implement efficient dynamic 
> tracing, do you really think that your "incentive" makes any 
> difference?

oh, being the first mover is the hardest part. Finding the right 
solution is a hard, it is blind Brownian motion in untested waters. Once 
good solutions have been found and once they have been integrated 
upstream, an architecture 'only' has to follow straight through the 
example. (which is _still_ far from trivial, but it certainly doesnt 
take years.)

	Ingo
