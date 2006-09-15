Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWIOTL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWIOTL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWIOTL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:11:27 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:13991 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750729AbWIOTL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:11:26 -0400
Date: Fri, 15 Sep 2006 21:10:44 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Frank Ch. Eigler" <fche@redhat.com>,
       karim@opersys.com, Tim Bird <tim.bird@am.sony.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060915181208.GA17581@elte.hu>
Message-ID: <Pine.LNX.4.64.0609152046350.6761@scrub.home>
References: <Pine.LNX.4.64.0609151339190.6761@scrub.home>
 <1158323938.29932.23.camel@localhost.localdomain> <Pine.LNX.4.64.0609151425180.6761@scrub.home>
 <1158327696.29932.29.camel@localhost.localdomain> <Pine.LNX.4.64.0609151523050.6761@scrub.home>
 <1158331277.29932.66.camel@localhost.localdomain> <450ABA2A.9060406@opersys.com>
 <1158332324.29932.82.camel@localhost.localdomain> <y0mmz91f46q.fsf@ton.toronto.redhat.com>
 <1158345108.29932.120.camel@localhost.localdomain> <20060915181208.GA17581@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Sep 2006, Ingo Molnar wrote:

> > Ar Gwe, 2006-09-15 am 13:08 -0400, ysgrifennodd Frank Ch. Eigler:
> > > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > > - where 1000-cycle int3-dispatching overheads too high
> > 
> > Why are your despatching overheads 1000 cycles ? (and if its due to 
> > int3 why are you using int 3 8))
> 
> this is being worked on actively: there's the "djprobes" patchset, which 
> includes a simplified disassembler to analyze common target code and can 
> thus insert much faster, call-a-trampoline-function based tracepoints 
> that are just as fast as (or faster than) compile-time, static 
> tracepoints.

Who is going to implement this for every arch?
Is this now the official party line that only archs, which implement all 
of this, can make use of efficient tracing?

bye, Roman
