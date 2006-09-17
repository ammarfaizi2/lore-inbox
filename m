Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWIQTFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWIQTFw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 15:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWIQTFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 15:05:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:46779 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932367AbWIQTFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 15:05:51 -0400
Date: Sun, 17 Sep 2006 20:59:56 +0200 (CEST)
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
In-Reply-To: <450D8C58.5000506@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0609172027120.6761@scrub.home>
References: <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home>
 <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home>
 <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home>
 <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home>
 <20060917084207.GA8738@elte.hu> <Pine.LNX.4.64.0609171627400.6761@scrub.home>
 <20060917152527.GC20225@elte.hu> <Pine.LNX.4.64.0609171744570.6761@scrub.home>
 <450D7EF0.3020805@yahoo.com.au> <Pine.LNX.4.64.0609171918430.6761@scrub.home>
 <450D8C58.5000506@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 18 Sep 2006, Nick Piggin wrote:

> But equally nobody can demand that a feature go into the upstream
> kernel. Especially not if there is a more flexible alternative
> already available that just requires implementing for their arch.

I completely agree with you under the condition that these alternatives 
were mutually exclusive or conflicting with each other.

> This shouldn't be surprising, the kernel doesn't have a doctrine of
> unlimited choice or merge features because they exist.

Do we have a doctrine which forces us to design a feature in such way 
that has to be as difficult as possible to make it available to our users?
In this case it would be very easy to provide some basic functionality via 
static tracing and the full functionality via dynamic tracing. Where is 
the law that forbids this?

> For example
> people wanted pluggable (runtime and/or compile time CPU scheduler
> in the kernel. This was rejected (IIRC by Linus, Andrew, Ingo, and
> myself). No doubt it would have been useful for a small number of
> people but it was decided that it would split testing and development
> resources. The STREAMS example is another one.

Comparing it to STREAMS is an insult and Ingo should be aware of this. :-(

> As an aside, there are quite a number of different types of tracing
> things (mostly static, compile out) in the kernel. Everything from
> blktrace to various userspace notifiers to lots of /proc/stuff could
> be considered a type of static event tracing. I don't know what my
> point is other than all these big, disjoint frameworks trying to be
> pushed into the kernel. Are there any plans for working some things
> together, or is that somebody else's problem?

All the controversy around static tracing in general and LTT in specific 
has prevented this so far...

bye, Roman
