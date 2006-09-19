Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWISNS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWISNS4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 09:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWISNS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 09:18:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:27599 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030291AbWISNSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 09:18:55 -0400
Date: Tue, 19 Sep 2006 15:17:18 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Christoph Hellwig <hch@infradead.org>
cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Frank Ch. Eigler" <fche@redhat.com>, karim@opersys.com,
       Tim Bird <tim.bird@am.sony.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060919122933.GA11337@infradead.org>
Message-ID: <Pine.LNX.4.64.0609191444060.6761@scrub.home>
References: <Pine.LNX.4.64.0609151425180.6761@scrub.home>
 <1158327696.29932.29.camel@localhost.localdomain> <Pine.LNX.4.64.0609151523050.6761@scrub.home>
 <1158331277.29932.66.camel@localhost.localdomain> <450ABA2A.9060406@opersys.com>
 <1158332324.29932.82.camel@localhost.localdomain> <y0mmz91f46q.fsf@ton.toronto.redhat.com>
 <1158345108.29932.120.camel@localhost.localdomain> <20060915181208.GA17581@elte.hu>
 <Pine.LNX.4.64.0609152046350.6761@scrub.home> <20060919122933.GA11337@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 19 Sep 2006, Christoph Hellwig wrote:

> > Who is going to implement this for every arch?
> > Is this now the official party line that only archs, which implement all 
> > of this, can make use of efficient tracing?
> 
> Come on, stop trying to be an asshole.  It's always been the case that to
> use new functionality you have to add arch code where nessecary.

On the contrary I'm really trying my best to be reasonable.
If there were no way around implementing kprobes, I would completely agree 
with you.

Let's take an item from todo list: TLS support for m68k. This a language 
feature becoming more and more important and increasingly difficult to 
work around it. Considering the complexities of this feature it will take 
quite a bit of the time available to me and somehow I doubt someone will 
beat me to it. I'm not complaining about it, I even enjoy hacking on it, 
but I also have to take no shit on how I have to spend my time.

Considering this I hope you understand how important kprobes are to me, I 
admit it's a nice a feature, but it's far from being essential.

bye, Roman
