Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSGXGV2>; Wed, 24 Jul 2002 02:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316887AbSGXGV2>; Wed, 24 Jul 2002 02:21:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:12480 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316878AbSGXGV1>;
	Wed, 24 Jul 2002 02:21:27 -0400
Date: Wed, 24 Jul 2002 08:24:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
       Bill Davidsen <davidsen@tmr.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020724082458.A1109@suse.de>
References: <20020723113923.H800@suse.de> <Pine.LNX.4.44.0207231435190.4586-100000@best.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207231435190.4586-100000@best.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23 2002, Peter Osterlund wrote:
> On Tue, 23 Jul 2002, Jens Axboe wrote:
> 
> > On Fri, Jul 19 2002, Peter Osterlund wrote:
> > > Peter Osterlund <petero2@telia.com> writes:
> > > 
> > > > Dave Jones <davej@suse.de> writes:
> > > > 
> > > > > On Thu, Jul 18, 2002 at 12:46:43PM -0400, Bill Davidsen wrote:
> > > > > 
> > > > >  > > o UDF Write support for CD-R/RW (packet writing)  (Jens Axboe, Peter Osterlund)
> > > > >  > 	Hopefully this is close as well
> > > > > 
> > > > > This has been around for an age, but I haven't seen anything for 2.5
> > > > > yet. Then again, I dropped off the packet-writing mailing list a long
> > > > > time ago, so I'm not sure how up to date those folks are.
> > > > 
> > > > Patches for 2.5 can be found here:
> > > > 
> > > >         http://w1.894.telia.com/~u89404340/patches/packet/2.5/
> > > > 
> > > > The most recent patch is for 2.5.25. As far as I know, there are only
> > > > two remaining problems with the 2.5 patch:
> > > 
> > > Btw, there is one more potential problem. A new block major number is
> > > allocated for the pktcdvd device. Is this still forbidden? Are there
> > > better ways to do this now?
> > 
> > Why a new number? What's wrong with the official 97?
> 
> It is still using 97. I didn't know it was official until it got into the
> kernel tree. I think Linus once said he wouldn't accept patches adding
> device numbers, because he wanted people to think up something better than
> device numbers.
> 
> I was thinking about this old message:
> 
> 	http://www.uwsg.indiana.edu/hypermail/linux/kernel/0105.1/1042.html
> 
> If that's no longer a problem, then fine.

97 was allocated a loong time ago, it predates the above message.

-- 
Jens Axboe

