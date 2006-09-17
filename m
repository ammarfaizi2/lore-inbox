Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWIQR1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWIQR1V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 13:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWIQR1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 13:27:21 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:17339 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964894AbWIQR1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 13:27:20 -0400
Date: Sun, 17 Sep 2006 19:26:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       karim@opersys.com, Andrew Morton <akpm@osdl.org>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <450D7EF0.3020805@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0609171918430.6761@scrub.home>
References: <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home>
 <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home>
 <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home>
 <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home>
 <20060917084207.GA8738@elte.hu> <Pine.LNX.4.64.0609171627400.6761@scrub.home>
 <20060917152527.GC20225@elte.hu> <Pine.LNX.4.64.0609171744570.6761@scrub.home>
 <450D7EF0.3020805@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 18 Sep 2006, Nick Piggin wrote:

> > > > The foremost issue is still that there is only limited kprobes support.
> > > 
> > > > The main issue in supporting static tracers are the tracepoints and so
> > > > far I haven't seen any convincing proof that the maintainance overhead
> > > > of dynamic and static tracepoints has to be significantly different.
> 
> Above, weren't you asking about static vs dynamic trace-*points*, rather
> than the implementation of the tracer itself. I think Ingo said that
> some "static tracepoints" (eg. annotation) could be acceptable.

No, he made it rather clear, that as far as possible he only wants dynamic 
annotations (e.g. via function attributes).

> > What you basically tell me is (rephrased to make it more clear): Implement
> > kprobes support or fuck off! You make it very clear, that you're unwilling
> > to support static tracers even to point to make _any_ static trace support 
> 
> Now it seems you are talking about compiled vs runtime inserted traces,
> which is different. And so far I have to agree with Ingo: dynamic seems
> to be better in almost every way. Implementation may be more complex,
> but that's never stood in the way of a better solution before, and I
> don't think anybody has shown it to be prohibitive ("I won't implement
> it" notwithstanding)

I don't deny that dynamic tracer are more flexible, but I simply don't 
have the resources to implement one. If those who demand I use a dynamic 
tracer, would also provide the appropriate funding, it would change the 
situation completely, but without that I have to live with the tools 
available to me.

bye, Roman
