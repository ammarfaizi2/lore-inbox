Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318740AbSG0Lji>; Sat, 27 Jul 2002 07:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318741AbSG0Lji>; Sat, 27 Jul 2002 07:39:38 -0400
Received: from [196.26.86.1] ([196.26.86.1]:15035 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S318740AbSG0Ljg>; Sat, 27 Jul 2002 07:39:36 -0400
Date: Sat, 27 Jul 2002 14:00:09 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Robert Love <rml@tech9.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@zip.com.au>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>,
       <linux-kernel@vger.kernel.org>, lse <lse-tech@lists.sourceforge.net>,
       <riel@conectiva.com.br>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lse-tech] Re: [RFC] Scalable statistics counters using
 kmalloc_percpu
In-Reply-To: <1027714922.928.8.camel@sinai>
Message-ID: <Pine.LNX.4.44.0207271357540.20701-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jul 2002, Robert Love wrote:

> Hmm, is your CPU-space sparse?

If you're referring to APIC IDs, even on generic SMP boxes APIC IDs can be 
sparse, its not a requirment that they are consecutive (e.g. i have a dual 
rig here which has a BSP with an ID of 4

> If that is the case, and the max APIC ID is set to NR_CPUS, and the
> kernel expects a 1:1 between NR_CPU value and logical CPU #... boom.

the NR_CPU should only be used to satisfy the current running cpu count 
no?

Cheers,
	Zwane
-- 
function.linuxpower.ca

