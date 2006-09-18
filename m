Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965330AbWIRDjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965330AbWIRDjG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 23:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWIRDjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 23:39:06 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:42927 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751327AbWIRDjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 23:39:03 -0400
Date: Mon, 18 Sep 2006 05:30:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Nicholas Miell <nmiell@comcast.net>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060918033027.GB11894@elte.hu>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy> <20060917230623.GD8791@elte.hu> <450DEEA5.7080808@opersys.com> <20060918005624.GA30835@elte.hu> <450DFFC8.5080005@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450DFFC8.5080005@opersys.com>
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


* Karim Yaghmour <karim@opersys.com> wrote:

> > [...] if i removed a few dozen static markups with dynamic scripts 
> > (which change too would be transparent to users of dynamic tracers), 
> > that in this case users of static tracers would /not/ claim that 
> > tracing broke?

> 2- removed markups are not transparent to "static" tracers:
> 
> False. LTTng couldn't care less. [...]

Amazing! So the trace data provided by those removed static markups 
(which were moved into dynamic scripts and are thus still fully 
available to dynamic tracers) are still available to LTT users? How is 
that possible, via quantum tunneling perhaps? ;-)

	Ingo
