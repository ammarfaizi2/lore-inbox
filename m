Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317577AbSFRTrZ>; Tue, 18 Jun 2002 15:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317582AbSFRTrY>; Tue, 18 Jun 2002 15:47:24 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:23017 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317577AbSFRTrX>; Tue, 18 Jun 2002 15:47:23 -0400
Date: Tue, 18 Jun 2002 21:19:40 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
In-Reply-To: <20020618152949.B16091@redhat.com>
Message-ID: <Pine.LNX.4.44.0206182118310.1263-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Benjamin LaHaise wrote:

> > 	/* -1 = remove affinity */
> > 	sys_sched_setaffinity(pid_t pid, int cpu);
> > 
> > This will work everywhere, and doesn't require userspace to know the
> > size of the cpu bitmask etc.
> 
> That doesn't work.  Think of SMT CPU pairs (aka HyperThreading) or 
> quads that share caches.

Hmm i don't understand, mind explaining why it wouldn't work on HT?

Cheers,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

