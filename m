Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWIOS1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWIOS1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWIOS1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:27:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:32234 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932145AbWIOS1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:27:48 -0400
Date: Fri, 15 Sep 2006 20:19:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915181907.GB17581@elte.hu>
References: <20060915132052.GA7843@localhost.usen.ad.jp> <Pine.LNX.4.64.0609151535030.6761@scrub.home> <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915111644.c857b2cf.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> What Karim is sharing with us here (yet again) is the real in-field 
> experience of real users (ie: not kernel developers).

well, Jes has that experience and Thomas too.

> I mean, on one hand we have people explaining what they think a 
> tracing facility should and shouldn't do, and on the other hand we 
> have a guy who has been maintaining and shipping exactly that thing to 
> (paying!) customers for many years.

so does Thomas and Jes. So what's the point?

i judge LTT by its current code quality, not by its proponents shouting 
volume - and that quality is still quite poor at the moment. (and then 
there are the conceptual problems too, outlined numerous times) I have 
quoted specific example(s) for that in this thread. Furthermore, LTT 
does this:

 246 files changed, 26207 insertions(+), 71 deletions(-)

and this gives me the shivers, for all the reasons i outlined.

	Ingo
