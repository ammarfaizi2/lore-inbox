Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTIGOdF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 10:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263280AbTIGOdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 10:33:05 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:46224 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263277AbTIGOdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 10:33:03 -0400
Date: Sun, 07 Sep 2003 07:32:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>
cc: rml@tech9.net, jyau_kernel_dev@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Message-ID: <170520000.1062945124@[10.10.2.4]>
In-Reply-To: <3F5AD03E.5070506@cyberone.com.au>
References: <000101c374a3$2d2f9450$f40a0a0a@Aria>	<1062878664.3754.12.camel@boobies.awol.org>	<3F5ABD3A.7060709@cyberone.com.au> <20030906231856.6282cd44.akpm@osdl.org> <3F5AD03E.5070506@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IIRC my (equivalent to Andrew's CAN_MIGRATE) patch fixed this. There 
> was still a small (~8%?) performance regression, but idle times were 
> on par with -linus. I don't have easy access to a largeish NUMA box, 
> so I can't do much more.

The degredations were seen on SMP (though I can also see them on NUMA).
You should be able to get access to a largish SMP (or even NUMA) box
via OSDL. Alternatively, I should be able to run some tests on Monday,
once the power is back in our lab (grrrr). Sounds like test order of
the day is:

test4
test4 + "Andrew's patch" (whatever that was, and whichever Andrew ;-))
test4 + Andrew + Con
test4 + Andres + Nick.

Though the results weren't as extreme on my machine, they were 10% or
so, and I can probably beat jbb into running fairly easily, or Mark
can do that one.

M.

