Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbTIKQZV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbTIKQZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:25:21 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:40593 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261356AbTIKQZM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:25:12 -0400
Date: Thu, 11 Sep 2003 17:25:10 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Virtual alias cache coherency results (was: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this)
Message-ID: <20030911162510.GA29532@mail.jlokier.co.uk>
References: <20030910210416.GA24258@mail.jlokier.co.uk> <20030910233951.Q30046@flint.arm.linux.org.uk> <20030910233720.GA25756@mail.jlokier.co.uk> <20030911010702.W30046@flint.arm.linux.org.uk> <20030911123535.GB28180@mail.jlokier.co.uk> <20030911160929.A19449@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911160929.A19449@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Maybe those StrongARM chips don't exhibit the write buffer bug?  Remember,
> I said _SOME_ StrongARM-110 chips exhibit the problem.  I did not say
> _ALL_ StrongARM-110 chips exhibit the problem.

I never assumed they all have the bug.  Credit me with at least
reading what you wrote before! :)

The results indicate some StrongARM-110 systems which _don't_ exhibit
the write buffer bug _do_ exhibit some _other_ cause of non-coherence.

> > It means that your VIVT explanation and workaround does not explain
> > those results, so I cannot have confidence that your workaround fixes
> > those particular ARM devices.
> 
> Well, as far as I'm concerned, I completely believe that I have explained
> it entirely, and I still don't know why you're trying to make this more
> difficult than it factually is.

I'm thinking the same of you! :)

All I asked is whether _all_ ARMs appear coherent to userspace now, and
you replied with:

> It's relatively simple, and I'm not sure why its causing such
> misunderstanding.  Let me try one more time:

and proceeding to answer a different question to the one I asked.

So, neither of us knows if all ARMs appear coherent to userspace, with
the latest kernel, ...

> Well, once you collect the kernel information and forward it to me, I
> can have a look.

...until we learn what kernel versions the Netwinder folks are
running, or they kindly run the test on a new kernel.

Thanks,
-- Jamie
