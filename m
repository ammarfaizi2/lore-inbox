Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317586AbSFRTzZ>; Tue, 18 Jun 2002 15:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317587AbSFRTzZ>; Tue, 18 Jun 2002 15:55:25 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:234 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317586AbSFRTzX>; Tue, 18 Jun 2002 15:55:23 -0400
Date: Tue, 18 Jun 2002 21:27:41 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
In-Reply-To: <20020618154915.C16091@redhat.com>
Message-ID: <Pine.LNX.4.44.0206182124140.1263-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Benjamin LaHaise wrote:

> On HyperThreading, you want to specify that either cpu in a pair is 
> okay.  In larger SMP machines that share a cache between 4 CPUs, the 
> mask is likely to contain all 4 CPUs in each quad.

Hmm so you want to apply the same 'node' principal to HT? The way HT works 
i can see why that would be a good idea. Node affinity on the quads makes 
sense and distinguishing which cpus belong to which quads would also help 
for irq affinity.

Thanks,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

