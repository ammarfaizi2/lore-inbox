Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbSLHCKB>; Sat, 7 Dec 2002 21:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSLHCKB>; Sat, 7 Dec 2002 21:10:01 -0500
Received: from sun.cesr.ncsu.edu ([152.14.51.17]:31887 "EHLO sun.cesr.ncsu.edu")
	by vger.kernel.org with ESMTP id <S265097AbSLHCKA>;
	Sat, 7 Dec 2002 21:10:00 -0500
Date: Sat, 7 Dec 2002 21:17:38 -0500 (EST)
From: Anu <avaidya@unity.ncsu.edu>
X-X-Sender: avaidya@sun.cesr.ncsu.edu
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: writing to raw devices
In-Reply-To: <Pine.LNX.4.44.0212072004010.22902-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.GSO.4.44.0212072056460.7992-100000@sun.cesr.ncsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok -- what I meant is this:

I have a software RAID-5 array with 5 disks (sdd1,2,3,4, sdb1,2) and one
parity disk.. (sdb2). the device is md0.

I am trying to see if I can figure out the stripe size of the raid-5
(although I already know it because i configured it) by writing
consecutively larger blocks on the "/dev/md0" file.. But, I have some
bizare and random errors (I should get neat dips in the curve once it hits
the stripe size -- but at best, what I currently get is random).

So, I went and looked and figured out that the way it works is that there
are problems with the way the raid is set up.. and in this case, does
writing to /dev/md0 really do what I think it is doing?

I am not even sure that this is the right group to ask this question --
but, here it is


On Sat, 7 Dec 2002, Mark Hahn wrote:

> > 	can someone tell me where to read about writing to raw devices?
> > (like calling write() on /dev/md0).
>
> that's not a meaningful question - there's nothing to say about it:
> it works, you can do that, no problem.  do you mean "how do do this
> efficiently?"  or "what's the benefit to doing this?"
>
>
>

********************************************************************************

			     Think, Train, Be

*******************************************************************************



