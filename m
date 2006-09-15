Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWIOU2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWIOU2I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWIOU2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:28:08 -0400
Received: from [209.226.175.184] ([209.226.175.184]:45281 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751371AbWIOU2E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:28:04 -0400
Date: Fri, 15 Sep 2006 16:22:34 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915202233.GA23318@Krystal>
References: <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20060915200559.GB30459@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:19:38 up 23 days, 17:28,  2 users,  load average: 0.24, 0.51, 0.42
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please Ingo, stop repeating false argument without taking in account people's
corrections :

* Ingo Molnar (mingo@elte.hu) wrote:
> sorry, but i disagree. There _is_ a solution that is superior in every 
> aspect: kprobes + SystemTap. (or any other equivalent dynamic tracer)
> 

I am sorry to have to repeat myself, but this is not true for heavy loads.

> > At this point you've been rather uncompromising [...]
> 
> yes, i'm rather uncompromising when i sense attempts to push inferior 
> concepts into the core kernel _when_ a better concept exists here and 
> today. Especially if the concept being pushed adds more than 350 
> tracepoints that expose something to user-space that amounts to a 
> complex external API, which tracepoints we have little chance of ever 
> getting rid of under a static tracing concept.
> 
>From an earlier email from Tim bird :

"I still think that this is off-topic for the patch posted.  I think we
should debate the implementation of tracepoints/markers when someone posts a
patch for some.  I think it's rather scurrilous to complain about
code NOT submitted.  Ingo has even mis-characterized the not-submitted
instrumentation patch, by saying it has 350 tracepoints when it has no
such thing.  I counted 58 for one architecture (with only 8 being
arch-specific)."

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
