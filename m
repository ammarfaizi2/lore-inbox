Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261967AbSJDWZN>; Fri, 4 Oct 2002 18:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261968AbSJDWZN>; Fri, 4 Oct 2002 18:25:13 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:35577 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261967AbSJDWZM>; Fri, 4 Oct 2002 18:25:12 -0400
Date: Fri, 04 Oct 2002 15:26:34 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] 2.6 not 3.0 - (NUMA)
Message-ID: <512380000.1033770394@flay>
In-Reply-To: <Pine.LNX.4.44.0210030852330.2066-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0210030852330.2066-100000@home.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only policy for major numbers has always been "major capability
> changes". 1.0 was "networking is stable and generally usable" (by the
> standards of that time), while 2.0 was "SMP and true multi-architecture
> support". My planned point for 3.0 was NuMA support, but while we actually
> have some of that, the hardware just isn't relevant enough to matter.

When you say we have "some of" that (NuMA support) ... what else would you 
like to see? The main things on the planned list as far as I'm concerned are:

1. NUMA aware scheduler.
2. multipath IO with NUMA support
3. per-node slabcache.
4. NUMA aware multidrop networking.

The first 3 of these three are floating around as patches, and I'm still hoping to get 
them merged before 2.5 (none are quite ready for merge yet, but should be in time).
I'll admit that people weren't desperately keen on doing multipath IO in the SCSI 
layer, but it seems like the only feasible way short term ....

I'd be most curious as to what else you think should be done (short or long term)
in this area, and any comments on the above 4 items?

Thanks,

Martin.

