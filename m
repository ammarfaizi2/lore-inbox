Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277255AbRJIO2Q>; Tue, 9 Oct 2001 10:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277253AbRJIO2G>; Tue, 9 Oct 2001 10:28:06 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:34972 "EHLO
	pimout4-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S277255AbRJIO1s>; Tue, 9 Oct 2001 10:27:48 -0400
Date: Tue, 9 Oct 2001 10:28:18 -0400 (EDT)
From: Bill Davidsen <davidsen@prodigy.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] again: Re: Athlon kernel crash (i686 works)
In-Reply-To: <3BC2F4FA.B29F2546@leoninedev.com>
Message-ID: <Pine.LNX.4.21.0110091021230.11335-100000@deathstar.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Bryan Mayland wrote:

> I'm happy with this patch too, as it stops my machine from crashing when switching to user-space.
> I've run several LMbench tests against both 686-optimized and Athlon-optimized kernels.  The
> results waver across multiple tests, one kernel winning some tests one time and losing the next,
> but the values are all close.  I can post the results of any benchmarks 686 vs Athlon anyone wants
> me to run if we can get this patch in soon!

That's what I see... the patch doesn't make things faster, it prevents the
system from failing due to user space code. If it was just a speed thing I
wouldn't feel strongly about getting it in production.

The other thing is that I don't buy "some people don't need it" when some
people can't run without it and no one yet has stated that it impaired the
function of their system.

Given that some systems are vulnerable to user code induced failuers
without the patch, and there are no reports that the patch causes problems
on any system, and it's optional in config anyway, why the resistance. The
"we know what you need" attitude belongs in that other o/s, not
Linux. Make it experimental, there are lots of other "use at your own
risk" options in config!

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe

