Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316729AbSERBCv>; Fri, 17 May 2002 21:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316733AbSERBCu>; Fri, 17 May 2002 21:02:50 -0400
Received: from slip-202-135-75-205.ca.au.prserv.net ([202.135.75.205]:45449
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S316729AbSERBCt>; Fri, 17 May 2002 21:02:49 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: Your message of "Fri, 17 May 2002 13:36:49 -0400."
             <200205171736.g4HHant04061@devserv.devel.redhat.com> 
Date: Sat, 18 May 2002 11:05:26 +1000
Message-Id: <E178sfK-0006dG-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200205171736.g4HHant04061@devserv.devel.redhat.com> you write:
> >[...]
> > We could do that, or, we could fix the actual problem, which is the
> > HUGE FUCKING BEARTRAP WHICH CATCHES EVERY SINGLE NEW PROGRAMMER ON THE
> > WAY THROUGH.
> 
> It is but one of many crooked interfaces. For example, Linux
> has outb() arguments swapped relatively to all other environments.

Yes, and they should all be fixed.  But the one which is never found
by the compiler or any simple testing is a clear winner in the "trap
for programmers" category.

> I think it may be the best to have Corbet to update the O'Reily
> book with a chapter of common traps and add a @-comment near
> the copy_from_user.
> 
> In the interest of full disclosure, I must admit that I used
> copy_from_user wrong once, many years ago. The lesson which
> I extracted was different though. I decided that I was arrogant
> and foolish to program without reading interface specifications
> or the code. It did not occur to me to shift the blame onto
> copy_from_user creators.

Please send me your mailing address.  I shall send you a copy of
"Design of Everyday Things" (Donald A Norman).  You should not blame
yourself for others' bad design.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
