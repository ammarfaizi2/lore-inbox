Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313826AbSDQICg>; Wed, 17 Apr 2002 04:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314082AbSDQICf>; Wed, 17 Apr 2002 04:02:35 -0400
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:23717 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S313826AbSDQICd>;
	Wed, 17 Apr 2002 04:02:33 -0400
Date: Wed, 17 Apr 2002 08:59:52 +0100
Message-Id: <200204170759.g3H7xqW02590@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <1019023303.1670.37.camel@phantasy>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1019023303.1670.37.camel@phantasy> you wrote:
> On Wed, 2002-04-17 at 01:34, Linus Torvalds wrote:
> 
>> No, it also makes it much easier to convert to/from the standard UNIX time
>> formats (ie "struct timeval" and "struct timespec") without any surprises,
>> because a jiffy is exactly representable in both if you have a HZ value
>> of 100 or 100, but not if your HZ is 1024.
> 
> Exactly - this was my issue.  So what _was_ the rationale behind Alpha
> picking 1024 

I seem to remember that this was for allowing True64 unix binaries to run
as well, those expect HZ to be 1024.....

-- 
But when you distribute the same sections as part of a whole which is a work 
based on the Program, the distribution of the whole must be on the terms of 
this License, whose permissions for other licensees extend to the entire whole,
and thus to each and every part regardless of who wrote it. [sect.2 GPL]
