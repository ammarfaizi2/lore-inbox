Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316214AbSEQMzz>; Fri, 17 May 2002 08:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316215AbSEQMzy>; Fri, 17 May 2002 08:55:54 -0400
Received: from slip-202-135-75-243.ca.au.prserv.net ([202.135.75.243]:21385
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S316214AbSEQMzx>; Fri, 17 May 2002 08:55:53 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: Your message of "Fri, 17 May 2002 13:58:53 +0100."
             <E178hJt-0006Rb-00@the-village.bc.nu> 
Date: Fri, 17 May 2002 22:58:08 +1000
Message-Id: <E178hJU-0002GS-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E178hJt-0006Rb-00@the-village.bc.nu> you write:
> > No, the 400+ are all of form:
> > 
> > 	/* of course this returns 0 or -EFAULT! */
> > 	return copy_from_user(xxx);
> 
> So lets verify and fix them. Post the list to the kenrel janitors

Again, like we did 12 months ago you mean?

We could do that, or, we could fix the actual problem, which is the
HUGE FUCKING BEARTRAP WHICH CATCHES EVERY SINGLE NEW PROGRAMMER ON THE
WAY THROUGH.

Not fixing earlier was criminal, not fixing it today is insane.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
