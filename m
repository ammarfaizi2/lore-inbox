Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266278AbSKGCZR>; Wed, 6 Nov 2002 21:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266282AbSKGCZR>; Wed, 6 Nov 2002 21:25:17 -0500
Received: from web12908.mail.yahoo.com ([216.136.174.75]:61254 "HELO
	web12908.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266278AbSKGCZQ>; Wed, 6 Nov 2002 21:25:16 -0500
Message-ID: <20021107023155.69817.qmail@web12908.mail.yahoo.com>
Date: Thu, 7 Nov 2002 13:31:55 +1100 (EST)
From: =?iso-8859-1?q?dee=20jay?= <deejay2shoes@yahoo.com.au>
Subject: Re: build kernel for server farm
To: Matt Simonsen <matt_lists@careercast.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1036620009.1332.12.camel@mattsworkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually if they are exactly the same, why dont you just copy the
relevant files over? ie. /lib/modules/`uname -r`/*, and as mentioned
your bzImage, System.map, and lilo.conf (and of course remember to run
lilo)?

Any particular reasons why you would want to go through the process of
compiling again on each machine?

-dj

 --- Matt Simonsen <matt_lists@careercast.com> wrote: > I am pretty
familiar with the build process and kernel install for a
> single Linux box, but I wanted to confirm I'm doing things in a sane
> way
> for a large deployment. All the machines are the same hardware and
> running standard setups.
> 
> First, I plan on compiling the kernel on a development box. From
> there
> my plan is basically tar /usr/src/linux, copy to each box, untar,
> copy
> bzImage and System.map to /boot, run make modules_install, edit
> lilo.conf, run lilo.
> 
> Tips? Comments?
> 
> Thanks 
> Matt
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

http://careers.yahoo.com.au - Yahoo! Careers
- 1,000's of jobs waiting online for you!
