Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbTBTCR3>; Wed, 19 Feb 2003 21:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbTBTCR2>; Wed, 19 Feb 2003 21:17:28 -0500
Received: from holomorphy.com ([66.224.33.161]:50332 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264705AbTBTCR2>;
	Wed, 19 Feb 2003 21:17:28 -0500
Date: Wed, 19 Feb 2003 18:26:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots)
Message-ID: <20030220022627.GW29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Chris Wedgwood <cw@f00f.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>
References: <Pine.LNX.4.44.0302191527400.9786-100000@penguin.transmeta.com> <Pine.LNX.4.50.0302192113480.10247-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0302192113480.10247-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 09:22:42PM -0500, Zwane Mwaikambo wrote:
> 	Here is a triple fault case (2.5.62-pgcl) and since i'm not a Real 
> Man i had to use a simulator ;) Unfortunately i can't unwind the stack.
> 
> CR2=page fault linear address=0xf7f9bf8c
> CR3=0x00101000
>     PCD=page-level cache disable=0
>     PWT=page-level writes transparent=0

Looks like either a pagetable or physmap/vmalloc/fixmap screwup.
What do the bootlogs have for those things?


-- wli
