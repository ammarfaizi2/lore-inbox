Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318466AbSGZTrE>; Fri, 26 Jul 2002 15:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318468AbSGZTrE>; Fri, 26 Jul 2002 15:47:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:13303 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318466AbSGZTrD>; Fri, 26 Jul 2002 15:47:03 -0400
Subject: Re: [RFC] Scalable statistics counters using kmalloc_percpu
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@zip.com.au>, Ravikiran G Thirumalai <kiran@in.ibm.com>,
       linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
       riel@conectiva.com.br, Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20020726194643.GX2907@holomorphy.com>
References: <20020726204033.D18570@in.ibm.com>
	<3D41990A.EDC1A530@zip.com.au>  <20020726194643.GX2907@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 26 Jul 2002 12:50:12 -0700
Message-Id: <1027713012.2443.49.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 12:46, William Lee Irwin III wrote:
> On Fri, Jul 26, 2002 at 11:46:34AM -0700, Andrew Morton wrote:
> > Oh dear.  Most people only have two CPUs.
> > Rusty, can we *please* fix this?  Really soon?
> 
> I'll post the panic triggered by lowering NR_CPUS shortly. There's
> an ugly showstopping i386 arch code issue here.

In current 2.5?  I thought Andrew and I fixed all those issues and
pushed them to Linus...

The `configurable NR_CPUS' patch works fine for me.  I always boot with
NR_CPUS=2.

	Robert love

