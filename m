Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263444AbRFFPcf>; Wed, 6 Jun 2001 11:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263445AbRFFPcZ>; Wed, 6 Jun 2001 11:32:25 -0400
Received: from cloven-ext.nks.net ([216.139.204.130]:23065 "EHLO
	homer.mkintl.com") by vger.kernel.org with ESMTP id <S263444AbRFFPcJ>;
	Wed, 6 Jun 2001 11:32:09 -0400
Message-ID: <3B1E4CD0.D16F58A8@illusionary.com>
Date: Wed, 06 Jun 2001 11:31:28 -0400
From: Derek Glidden <dglidden@illusionary.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Funny. I can count many ways in which 4.3BSD, SunOS{3,4} and post-4.4 BSD
> systems I've used were broken, but I've never thought that swap==2*RAM rule
> was one of them.

Yes, but Linux isn't 4.3BSD, SunOS or post-4.4 BSD.  Not to mention, all
other OS's I've had experience using *don't* break severely if you don't
follow the "swap==2*RAM" rule.  Except Linux 2.4.

> Not that being more kind on swap would be a bad thing, but that rule for
> amount of swap is pretty common. ISTR similar for (very old) SCO, so it's
> not just BSD world. How are modern Missed'em'V variants in that respect, BTW?

Yes, but that has traditionally been one of the big BENEFITS of Linux,
and other UNIXes.  As Sean Hunter said, "Virtual memory is one of the
killer features of
unix."  Linux has *never* in the past REQUIRED me to follow that rule. 
Which is a big reason I use it in so many places.

Take an example mentioned by someone on the list already: a laptop.  I
have two laptops that run Linux.  One has a 4GB disk, one has a 12GB
disk.  Both disks are VERY full of data and both machines get pretty
heavy use.  It's a fact that I just bumped one laptop (with 256MB of
swap configured) from 128MB to 256MB of RAM.  Does this mean that if I
want to upgrade to the 2.4 kernel on that machine I now have to back up
all that data, repartition the drive and restore everything just so I
can fastidiously follow the "swap == 2*RAM" rule else the 2.4 VM
subsystem will break?  Bollocks, to quote yet another participant in
this silly discussion.

I'm beginning to be amazed at the Linux VM hackers' attitudes regarding
this problem.  I expect this sort of behaviour from academics - ignoring
real actual problems being reported by real actual people really and
actually experiencing and reporting them because "technically" or
"theoretically" they "shouldn't be an issue" or because "the "literature
[documentation] says otherwise - but not from this group.  

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
