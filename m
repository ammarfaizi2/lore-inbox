Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWISIVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWISIVu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 04:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWISIVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 04:21:50 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:16537 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751331AbWISIVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 04:21:49 -0400
Date: Tue, 19 Sep 2006 10:13:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060919081307.GA32108@elte.hu>
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060919081124.GA30394@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > +choice
> > +	prompt "MARK code marker behavior"
> 
> > +config MARK_KPROBE
> > +config MARK_JPROBE
> > +config MARK_FPROBE
> > +	Change markers for a function call.
> > +config MARK_PRINT
> 
> as indicated before in great detail, NACK on this profileration of 
> marker options, especially the function call one. I'd like to see _one_ 
> marker mechanism that distros could enable, preferably with zero (or at 
> most one NOP) in-code overhead. (You can of course patch whatever 
> extension ontop of it, in out-of-tree code, to gain further performance 
> advantage by generating direct system-calls.)
                                    ^---function

	Ingo
