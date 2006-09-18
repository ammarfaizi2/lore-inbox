Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbWIRO6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbWIRO6v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 10:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbWIRO6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 10:58:50 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:31425 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S965219AbWIRO6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 10:58:49 -0400
Date: Mon, 18 Sep 2006 10:53:35 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Jes Sorensen <jes@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060918145335.GD15605@Krystal>
References: <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916173035.GA705@Krystal> <450E55BB.80208@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <450E55BB.80208@sgi.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 10:47:22 up 26 days, 11:56,  4 users,  load average: 2.42, 1.66, 1.48
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jes Sorensen (jes@sgi.com) wrote:
> Mathieu Desnoyers wrote:
> > And about those extra cycles.. according to :
> > Documentation/kprobes.txt
> > "6. Probe Overhead
> > 
> > On a typical CPU in use in 2005, a kprobe hit takes 0.5 to 1.0
> > microseconds to process.  Specifically, a benchmark that hits the same
> > probepoint repeatedly, firing a simple handler each time, reports 1-2
> > million hits per second, depending on the architecture.  A jprobe or
> > return-probe hit typically takes 50-75% longer than a kprobe hit.
> > When you have a return probe set on a function, adding a kprobe at
> > the entry to that function adds essentially no overhead.
> [snip]
> > So, 1 microsecond seems more like 1500-2000 cycles to me, not 50.
> 
> So call it 2000 cycles, now go measure it in *real* life benchmarks
> and not some artificial I call this one syscall that hits the probe
> every time in a tight loop, kinda thing.
> 
> Show us some *real* numbers please.
> 

You are late (I don't blame you about it, considering the size of this thread).
It has been posted in the following email :

http://linux.derkeiler.com/Mailing-Lists/Kernel/2006-09/msg04492.html

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
