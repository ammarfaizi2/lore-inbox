Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261481AbSJUQKd>; Mon, 21 Oct 2002 12:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261499AbSJUQKd>; Mon, 21 Oct 2002 12:10:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38587 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261481AbSJUQKc>;
	Mon, 21 Oct 2002 12:10:32 -0400
Date: Mon, 21 Oct 2002 18:16:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: Crunch time continues: the merge candidate list v1.1
Message-ID: <20021021161620.GH10141@suse.de>
References: <200210202303.46848.landley@trommello.org> <20021021144656.GF11594@suse.de> <3DB42008.5000906@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB42008.5000906@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21 2002, Hans Reiser wrote:
[snipped]
> It is marked experimental.  This is not an upgrade to "reiserfs", this 
> is a completely separate "reiser4" filesystem with no code in common 
> that you won't even be aware of unless you click on experimental drivers 
> desired.   Please remember that we do a good job with QA, so in 
> evangelical efforts to impose a sense of severe feature freeze, please 
> target past offenders we won't name here who deserve the attention.  I 
> see no point in burdening users when there are bugs we are able to hit 
> ourselves, and that is part of why the delay.

My point is that no code gets into the kernel without having a
significant amount of exposure first. This means exposure to other
developers, and exposure to users. Why do you think reiser4 is different
from other projects in this regard? It definitely is not.

> Also, last time I spoke with Linus I said that freezes for filesystems 
> should occur not less than 6 weeks after freezes for VM and VFS, and he 
> agreed with that.  I would prefer not to hold him to his past 
> statements, but if I must then I will try to.;-)

I can sort-of agree with that. Fixing file systems bugs is like fixing
driver bugs, a freeze doesn't stop that in any way.

> On the other hand, if there are persons who would like to give us a hand 
> with debugging and tweaking reiser4, we will be happy to send them 
> tarballs.  Such tarballs would be for developers, not users.   What we 
> need help with on reiser4 is probably just the sort of thing a weekend 
> coder can enjoy.  We need people hitting and patching bugs, and we need 
> persons carefully employing a profiler and tweaking code paths.  Persons 
> who are interested in that would be very appreciated.

Sure yes, I'd like to see the code. If for nothing else than to give it
a test spin on a rainy day. And I'm curious about several things.

> So, in summary, we should be included because we harm no other code (we 
> are non-core), marked experimental, you know from the past that we will 
> get it debugged, by next week we really will be in need of feedback from 
> others, and because increasing Linux filesystem performance by 50-105% 
> is worth some inconvenience.  

Sorry I don't agree. reiser4 _may_ get it when it has proved itself
ready.

-- 
Jens Axboe

