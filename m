Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313816AbSDPSRQ>; Tue, 16 Apr 2002 14:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313817AbSDPSRP>; Tue, 16 Apr 2002 14:17:15 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:51697
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313816AbSDPSRO>; Tue, 16 Apr 2002 14:17:14 -0400
Date: Tue, 16 Apr 2002 11:19:36 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
Message-ID: <20020416181936.GC23513@matchmail.com>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020416013016.GA23513@matchmail.com> <Pine.LNX.3.96.1020416095729.26684A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 10:00:36AM -0400, Bill Davidsen wrote:
> On Mon, 15 Apr 2002, Mike Fedyk wrote:
> 
> > No matter how much someone can go through their own code and say "it's
> > ready" there's always a good chance there is some bug that will trigger
> > under testing.  Also, Andrew found a problem with your locking changes when
> > he split up your patch, and at the time you were saying it is ready and
> > there were no bug reports against in...
> 
> If you are going to reject code from people who send in code which turns
> out to have bugs you are going to have a VERY small set of submitters.

No that's not what I was saying.

> It's good to have someone else read the code, for breakup or whatever, but
> to avoid cleanup in a stable kernel seems long term the wrong direction.
> 

Exactly.  I'm just saying that you will get more eyes on the code and less
possible detrimental impact (if any, which I doubt) if the patches don't all
go into one set of -pre patches but spread out over a few releases
(2.4.19,20 and possibly 21).  The -pre kernels get testing, but not nearly
as much as the releases do.  Test the -pre and -rc kernels as much as
possible, but also know that something might be flushed out by some people
that only use the released kernels (non -pre or -rc).

Mike
