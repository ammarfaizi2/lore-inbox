Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbWIQVhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbWIQVhS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 17:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWIQVhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 17:37:18 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:23997 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965120AbWIQVhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 17:37:16 -0400
Date: Sun, 17 Sep 2006 23:36:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060917205628.GA2145@elte.hu>
Message-ID: <Pine.LNX.4.64.0609172319370.6761@scrub.home>
References: <20060916230031.GB20180@elte.hu> <Pine.LNX.4.64.0609170310580.6761@scrub.home>
 <20060917084207.GA8738@elte.hu> <Pine.LNX.4.64.0609171627400.6761@scrub.home>
 <20060917152527.GC20225@elte.hu> <Pine.LNX.4.64.0609171744570.6761@scrub.home>
 <450D7EF0.3020805@yahoo.com.au> <Pine.LNX.4.64.0609171918430.6761@scrub.home>
 <20060917192359.GA24016@elte.hu> <Pine.LNX.4.64.0609172144200.6761@scrub.home>
 <20060917205628.GA2145@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 17 Sep 2006, Ingo Molnar wrote:

> > Some consistency would certainly help: 'my suggested API is not 
> > "barely usable" for static tracers but "totally unusable".'
> 
> I am really sorry that you were able to misunderstand and misrepresent 
> such a simple sentence.

Considering the context, which is not exactly full of support for static 
tracer, I think my understanding was and still is quite correct.
Let's take <20060915231419.GA24731@elte.hu>, where you suggest converting 
as much possible tracepoints to this API, thus excluding a lot of
information from static tracers.

> this makes it clear that i disagree with adding static markups for 
> static tracers - but i of course still agree with static markups for 
> _dynamic tracers_. The markups would be totally unusable for static 
> tracers because there is no guarantee for the existence of static 
> markups _everywhere_: the static markups would come and go, as per the 
> "tracepoint maintainance model". Do you understand that or should i 
> explain it in more detail?

Well, I rather just wait for the real patch, where you can show your 
support for all possible users.

bye, Roman
