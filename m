Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751857AbWIRQyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbWIRQyu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWIRQyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:54:50 -0400
Received: from tomts43.bellnexxia.net ([209.226.175.110]:5315 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751857AbWIRQys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:54:48 -0400
Date: Mon, 18 Sep 2006 12:54:45 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jes Sorensen <jes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060918165445.GA13702@Krystal>
References: <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916173035.GA705@Krystal> <450E55BB.80208@sgi.com> <20060918145335.GD15605@Krystal> <20060918151713.GA11495@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060918151713.GA11495@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 12:51:26 up 26 days, 14:00,  5 users,  load average: 0.92, 0.38, 0.33
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> 
> > You are late (I don't blame you about it, considering the size of this 
> > thread). It has been posted in the following email :
> > 
> > http://linux.derkeiler.com/Mailing-Lists/Kernel/2006-09/msg04492.html
> 
> yeah - and i dont think the kprobes overhead is a fundamental thing - i 
> posted a few kprobes-speedup patches as a reply to your measurements.
> 

Hi Ingo,

Yes, and I replied that I really don't think that a few cycles saved here and
there by a predicted branch will change anything significant compared to the
int3 cost. As my test bench is really not that hard to deploy (I have given the
precise instructions to do so), I assume that the burden of the proof is on your
side there.

Anyhow, I prefer to move to a more constructive matter than testing kprobes
branch optimisations.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
