Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274065AbRISOF6>; Wed, 19 Sep 2001 10:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274066AbRISOFj>; Wed, 19 Sep 2001 10:05:39 -0400
Received: from dsl-64-34-35-93.telocity.com ([64.34.35.93]:44433 "HELO
	tigger.rogueind.com") by vger.kernel.org with SMTP
	id <S274065AbRISOFg>; Wed, 19 Sep 2001 10:05:36 -0400
Date: Wed, 19 Sep 2001 10:05:57 -0400 (EDT)
From: Tom Diehl <tdiehl@rogueind.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <Pine.GSO.4.21.0109191619570.22381-100000@skiathos.physics.auth.gr>
Message-ID: <Pine.LNX.4.33.0109190953570.5560-100000@tigger.rogueind.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Liakakis Kostas wrote:

>
> I am just opposing to be forced to use a fix when a fix isn't really
> needed on my setup.

If it causes no performance hit I do not see the problem. Since I have
not seen all of this thread I have to ask what is/are the downsides to
blindly enabling this? What are the real concerns? If the concern is
just to keep your machine "factory fresh" do you have anything that says
this is not just a screw up on the bios writers part? Look at all of the
known and documented BIOS bugs there are.

> On Wed, 19 Sep 2001, VDA wrote:
>
> > Look into pci-pc.c amd quirks.c: do you want to make all those
> > config options too?
>
> I will, and if I find something done not needed I might complain again.

You are free to modify things to your preferences. I think the real point
is to fix it for the largest possible audience. Making it a compile option
IMO serves no real benefit and has some potential rather large downsides.
People like to fiddle. If someone turns it off and does not know what they
are doing the next thing you know is they are complaining here about something
that they should not be playing with anyway.

> > Also, do you want people to spend days finding out why their
> > once stable system with their brand new, faster processor
> > started to oops, finally giving up and posting about this to lkml?
>
> I don't suppose it will take more than an hour for somebody to notice that
> under the "Optimized for K7" option there is another called "Enable 55.7=0
> fix for K7 that oops all over the place"

Depends on the skill set that person possesses. some people will find it
some will not. Murphy definitely will be at work here.

Enjoy,

-- 
......Tom		BLAME: The Secret To Success is Knowing who
tdiehl@rogueind.com	to Blame for Your Failures.

