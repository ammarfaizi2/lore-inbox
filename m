Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWIQPRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWIQPRE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 11:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWIQPRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 11:17:04 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:17850 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932300AbWIQPRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 11:17:02 -0400
Date: Sun, 17 Sep 2006 17:16:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060917084207.GA8738@elte.hu>
Message-ID: <Pine.LNX.4.64.0609171627400.6761@scrub.home>
References: <20060915204812.GA6909@elte.hu> <Pine.LNX.4.64.0609152314250.6761@scrub.home>
 <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home>
 <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home>
 <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home>
 <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home>
 <20060917084207.GA8738@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 17 Sep 2006, Ingo Molnar wrote:

> > If they are useful and not hurting anyone, why should we?
> 
> FYI, whether it is true that "they not hurting anyone" is one of those 
> "secondary issues" that I analyzed in great detail in the emails 
> yesterday, and which you opted not to "further dvelve into":

Ingo, you happily still ignore my primary issues, how serious do you 
expect me to take this?

> so at least to me the rule in such a situation is clear: if we have the
> choice between two approaches that are useful in similar ways [*] but
> one has a larger flexibility to decrease the total maintainance cost,
> then we _must_ pick that one.

That would assume the choices are mutually exclusive, which you haven't 
proven at all.

To put everything in yet another perspective: We have the kernel full of 
security hooks, which are likely more invasive than any trace marker ever 
will be. These security hooks are well hated by a few developers, but we 
merged them anyway, because they are useful.
So the big question is now, why should it be impossible to create and 
merge a well defined set of markers, which can be used by any tracer?

bye, Roman
