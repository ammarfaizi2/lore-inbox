Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbTBTCrr>; Wed, 19 Feb 2003 21:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbTBTCrr>; Wed, 19 Feb 2003 21:47:47 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:41287
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264724AbTBTCrr>; Wed, 19 Feb 2003 21:47:47 -0500
Date: Wed, 19 Feb 2003 21:55:47 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <20030220022627.GW29983@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0302192146580.10247-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0302191527400.9786-100000@penguin.transmeta.com>
 <Pine.LNX.4.50.0302192113480.10247-100000@montezuma.mastecende.com>
 <20030220022627.GW29983@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003, William Lee Irwin III wrote:

> On Wed, Feb 19, 2003 at 09:22:42PM -0500, Zwane Mwaikambo wrote:
> > 	Here is a triple fault case (2.5.62-pgcl) and since i'm not a Real 
> > Man i had to use a simulator ;) Unfortunately i can't unwind the stack.
> > 
> > CR2=page fault linear address=0xf7f9bf8c
> > CR3=0x00101000
> >     PCD=page-level cache disable=0
> >     PWT=page-level writes transparent=0
> 
> Looks like either a pagetable or physmap/vmalloc/fixmap screwup.
> What do the bootlogs have for those things?

Verified there were no overlapping regions. If you really really really 
want them i can put in some printks

	Zwane
-- 
function.linuxpower.ca
