Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315620AbSECJdP>; Fri, 3 May 2002 05:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315621AbSECJdO>; Fri, 3 May 2002 05:33:14 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:29702 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315620AbSECJdN>; Fri, 3 May 2002 05:33:13 -0400
Date: Fri, 3 May 2002 11:33:04 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Andrea Arcangeli <andrea@suse.de>, Ralf Baechle <ralf@uni-koblenz.de>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: discontiguous memory platforms
In-Reply-To: <E173MyQ-00028q-00@starship>
Message-ID: <Pine.LNX.4.21.0205031115100.23113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2 May 2002, Daniel Phillips wrote:

> I'll accept 'not needed for 68K', though I guess config_nonlinear will work
> perfectly well for you and be faster than the loops.  However, some of the
> problems that config_nonlinear solves cannot be solved by any existing kernel
> mechanism.  We've been over the NUMA-Q and mips32 cases in detail, so I won't
> reiterate.

Maybe I missed that, but could you give me an example of a memory
configuration, which would be difficult to handle with the current
vm? Could you describe, how in your model the physical address space would
be mapped to the logical and virtual address space and how they are mapped
into the pgdat nodes?
Some real numbers would help me a lot to understand, what you have in
mind. I have a rough idea of it, but I want to be sure we are talking
about the same thing.

bye, Roman

