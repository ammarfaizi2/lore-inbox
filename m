Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263595AbRFAPp4>; Fri, 1 Jun 2001 11:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263591AbRFAPpg>; Fri, 1 Jun 2001 11:45:36 -0400
Received: from geos.coastside.net ([207.213.212.4]:52974 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S263218AbRFAPp3>; Fri, 1 Jun 2001 11:45:29 -0400
Mime-Version: 1.0
Message-Id: <p05100308b73d672c7f2b@[207.213.214.37]>
In-Reply-To: <20010601145900.C12402@khan.acc.umu.se>
In-Reply-To: <Pine.GSO.4.21.0105311555250.17748-100000@weyl.math.psu.edu>
 <3B178E0E.A4530D47@egenera.com> <20010601145900.C12402@khan.acc.umu.se>
Date: Fri, 1 Jun 2001 08:45:17 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Configure.help is complete
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2:59 PM +0200 2001-06-01, David Weinehall wrote:
>  > Not to open a what may be can of worms but ...
>>
>>  What's wrong with procfs?
>
>Imho, a procfs should be for process-information, nothing else.
>The procfs in its current form, while useful, is something horrible
>that should be taken out on the backyard and shot using slugs.
>
>Ehrmmm. No, but seriously, the non-process stuff should be separate
>from the procfs. Maybe call it kernfs or whatever.
>
>>  It allows a general interface to the kernel that does not require new
>>  syscalls/ioctls and can be accessed from user space without specifically
>>  compiled programs. You can use shell scripts, java, command line etc.
>
>Yes, and it's also totally non standardised.

It clearly fills a need, though, and has the distinct side benefit of 
cutting down on the proliferation of ioctls. Sure, it's non-standard 
and a mess. But it's semi-documented, easy to use, and v. general. 
What's the preferred alternative, to state the first question another 
way? For any single small project/driver, creating a new fs simply 
isn't going to happen.
-- 
/Jonathan Lundell.
