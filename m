Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318433AbSGaSYP>; Wed, 31 Jul 2002 14:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318434AbSGaSYP>; Wed, 31 Jul 2002 14:24:15 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:6158 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318433AbSGaSYP>; Wed, 31 Jul 2002 14:24:15 -0400
Date: Wed, 31 Jul 2002 14:21:43 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: jeff millar <wa1hco@adelphia.net>
cc: Jakob Oestergaard <jakob@unthought.net>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RAID problems
In-Reply-To: <004501c23841$03265a30$6a01a8c0@wa1hco>
Message-ID: <Pine.LNX.3.96.1020731135724.10066D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, jeff millar wrote:

> In the 3 weeks since installing Linux software raid-5 (3 x 80 GB), I had to
> reinitialize the raid devices twice (mkraid --force)...once due to an abrupt
> shutdown and once due to some weird ATA/ATAPI/drive problem that caused a
> disk to begin "clicking" spasmodically...and left the raid array all out of
> whack..
> 
> Linux software raid seems very fragile and very scary to recover.  I feel a
> much stronger need for backup with raid than without it.

I'm happy to say my experience has been better, when swraid was a patch I
built a kernel:
-rw-r--r--   1 root       763429 Dec 14  1999 k2.2.13s3r

And set up a four drive RAID-0+1. It has recovered from every problem with
nothing more that a hot add. You certainly have had bad luck, but I don't
think it's typical.

The situation when a drive fails and the system stays up seems to be
pretty good, back in the days of 340MB IDE drives I tested it more than I
wanted;-) As you note, recovery if the system goes down is somewhat
painful and manual.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

