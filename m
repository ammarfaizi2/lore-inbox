Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWIONpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWIONpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWIONpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:45:13 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:46795 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751439AbWIONpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:45:10 -0400
Message-ID: <450AAE39.4040205@sgi.com>
Date: Fri, 15 Sep 2006 15:44:25 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com> <20060915132052.GA7843@localhost.usen.ad.jp> <Pine.LNX.4.64.0609151535030.6761@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0609151535030.6761@scrub.home>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> The claim that these tracepoints would be maintainance burden is pretty 
> much unproven so far. The static tracepoint haters just assume the kernel 
> will be littered with thousands of unrelated tracepoints, where a good 
> tracepoint would only document what already happens in that function, so 
> that the tracepoint would be far from something obscure, which only few 
> people could understand and maintain.

How do you propose to handle the case where two tracepoint clients wants
slightly different data from the same function? I saw this with LTT
users where someone wanted things in different places in schedule().

It *is* a nightmare to maintain.

You still haven't explained your argument about kprobes not being
generally available - where?

Cheers,
Jes



