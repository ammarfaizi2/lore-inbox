Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965281AbWIRPGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965281AbWIRPGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965282AbWIRPGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:06:25 -0400
Received: from tomts40-srv.bellnexxia.net ([209.226.175.97]:39662 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S965281AbWIRPGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:06:24 -0400
Date: Mon, 18 Sep 2006 11:01:15 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Jes Sorensen <jes@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060918150115.GE15605@Krystal>
References: <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <450E59D3.8070003@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <450E59D3.8070003@sgi.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 10:57:14 up 26 days, 12:05,  4 users,  load average: 0.59, 0.73, 1.05
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jes Sorensen (jes@sgi.com) wrote:
> Mathieu Desnoyers wrote:
> > The bottom line is :
> > 
> > LTTng impact on the studied phenomenon : 35% slower
> > 
> > LTTng+kprobes impact on the studied phenomenon : 73% slower
> > 
> > Therefore, I conclude that on this type of high event rate workload, kprobes
> > doubles the tracer impact on the system.
> 
> For this specific benchmark, for which we have not seen the code, nor
> do we know what system configuration it was run on. Sorry, but even M$'s
> sham benchmarks generally tell you which system they used for their
> tests.
> 
> In addition, some profiling would be interesting so we can see exactly
> where things go wrong and fix it. Ingo seems to be doing a good job at
> that even without you providing this basic info....
> 

Hi Jes,

I did not repeat my system configuration from the previous email in the thread
as it seemed redundant. Ingo asked me politely to tell more about my config
and tests, which I have done. Please read on further down this thread to get
that information.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
