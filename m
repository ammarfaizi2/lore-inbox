Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318575AbSGZUTY>; Fri, 26 Jul 2002 16:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318578AbSGZUTY>; Fri, 26 Jul 2002 16:19:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:11764 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318575AbSGZUSu>; Fri, 26 Jul 2002 16:18:50 -0400
Subject: Re: [Lse-tech] Re: [RFC] Scalable statistics counters using
	kmalloc_percpu
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@zip.com.au>, Ravikiran G Thirumalai <kiran@in.ibm.com>,
       linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
       riel@conectiva.com.br, Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20020726201526.GZ2907@holomorphy.com>
References: <20020726204033.D18570@in.ibm.com>
	<3D41990A.EDC1A530@zip.com.au> <20020726194643.GX2907@holomorphy.com>
	<1027713012.2443.49.camel@sinai>  <20020726201526.GZ2907@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 26 Jul 2002 13:22:02 -0700
Message-Id: <1027714922.928.8.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 13:15, William Lee Irwin III wrote:

> On Fri, Jul 26, 2002 at 12:50:12PM -0700, Robert Love wrote:
> > In current 2.5?  I thought Andrew and I fixed all those issues and
> > pushed them to Linus...
> > The `configurable NR_CPUS' patch works fine for me.  I always boot with
> > NR_CPUS=2.
> 
> No idea who it works for, it sure doesn't work here. Behold:

Hmm, is your CPU-space sparse?

If that is the case, and the max APIC ID is set to NR_CPUS, and the
kernel expects a 1:1 between NR_CPU value and logical CPU #... boom.

	Robert Love

