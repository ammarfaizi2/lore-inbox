Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311735AbSC1G2K>; Thu, 28 Mar 2002 01:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311739AbSC1G1u>; Thu, 28 Mar 2002 01:27:50 -0500
Received: from bitmover.com ([192.132.92.2]:27117 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S311735AbSC1G1k>;
	Thu, 28 Mar 2002 01:27:40 -0500
Date: Wed, 27 Mar 2002 22:27:38 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: bkbits.net down
Message-ID: <20020327222738.B16149@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203271853.g2RIrRv11812@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We did indeed lose the primary disk (IBM 40GB, I am starting to lose all
the respect I had for IBM drives, this is one of many that has failed on
me personally).  I have restored from the backup disk, and in the process
redone hardlinks across all the linux kernel trees, which saved about 5GB
(nice).  All trees which are now on bkbits.net check clean, which means
BK thinks all the files are there and that the checksums are correct,
a fairly reasonable indication that we are in good shape.

I wouldn't be a bit surprised if we have some permissions problems,
mail support@bitmover.com if you hit any and we'll fix things as we
become aware of them.  In fact, I know we have permissions problems but
given that I've been working on this for 12 hours straight, I'll get to
it tomorrow.

There are a couple of trees which are missing files, both in Rik's 
linuxvm.bkbits.net, I suspect an interrupted clone.  They are:
	bk://linuxvm.bkits.net/linux-2.5-vmtidbits
	bk://linuxvm.bkits.net/linux-2.5-writethrot
Rik, ping me if you need help cleaning these up.

The ppc tree seems to be missing linuxppc_2_4, Paul/Tom/Troy/Cort,
where is this tree?  You'll want to get a copy back here, I suspect,
so if you are a PPC person and you have a recently updated version of
linuxppc_2_4, hang on to it.  We'll sort it out on the ppc mailing list.

We have lost a number of ssh keys.  We backed these up a while back but
we did not catch all of these.  The list is below, send me mail with your
ssh key / project name and I will restore them by hand.  We already had
plans in place for dealing with this problem so that it doesn't reoccur.

Sorry about the long downtime,  we are struggling with the economic
downturn like everyone else and hadn't put a hot spare in place yet.
We bought them, in fact, I bought ten spare boxes for this sort of
thing, but I have been too busy to put them in place.  We'll get on
it, we're aware that people depend on this.

--lm

Here's the list of projects missing ssh keys:
	bcrlbits
	freebsd-dvb (probably not Linux, eh? :)
	lia64
	linux-mtd
	linux-srn
	linux24 (I think this one is dead, right Marcelo?)
	ltr
	misc
	nonblock
	palinux
	test1
If you are the admin for any of these projects, drop me a mail with your
ssh key and I'll add it back in.

On Wed, Mar 27, 2002 at 10:53:27AM -0800, root wrote:
> It looks like we have a bad disk, I'm checking them now to figure out if 
> it is the the primary or backup data drive.  I'll run checks in all the
> repositories if fsck doesn't find the problem so it may take a couple of 
> hours before we are back up.
> 
> In the not so distant future, we're moving the backup drive to a different
> machine such that we can just flip machines when this happens but for now
> you'll have to wait for a bit.
> 
> --lm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
