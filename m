Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbVIHTB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbVIHTB0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVIHTB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:01:26 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:13317 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964944AbVIHTBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:01:25 -0400
Message-ID: <43208B77.9060009@tmr.com>
Date: Thu, 08 Sep 2005 15:05:27 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Adrian Bunk <bunk@stusta.de>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Paul Misner <paul@misner.org>, linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
References: <20050904203725.GB4715@redhat.com> <20050902060830.84977.qmail@web50208.mail.yahoo.com> <200509041549.17512.vda@ilport.com.ua> <200509041144.13145.paul@misner.org> <84144f02050904100721d3844d@mail.gmail.com> <6880bed305090410127f82a59f@mail.gmail.com> <20050904193350.GA3741@stusta.de> <6880bed305090413132c37fed3@mail.gmail.com> <20050904203725.GB4715@redhat.com> <431F1778.5050200@tmr.com> <5.2.1.1.2.20050907194344.00c2bea8@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20050907194344.00c2bea8@pop.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> At 12:38 PM 9/7/2005 -0400, Bill Davidsen wrote:
> 
>> You must have something more useful to work on, which would ADD value 
>> to the kernel instead of breaking existing installations. Ripping out 
>> petty stuff which works is a waste of your time and talent, please 
>> find something better to do.
> 
> 
> Ahem. Please...
> 
>> Perhaps devise a way for programs like ndiswrapper to provide their 
>> own stack, for instance.
> 
> 
> ...follow your own suggestion instead of hammering someone else.
> 
> I've seen some discussion.  More of that, and less of this please.

Frankly this should be done by someone who really understands the code, 
and considering the time it's likely to take it would probably be (a) 
someone with a desparate need, (b) someone rich or retired who doesn't 
work for a living and has the time, or (c) someone who works for a 
company which sells Linux distributions and therefore could get paid to 
do this. That lets me out on all counts, I would resent wasting the time 
to patch 8KSTACKS back in as a patch, but I could do that to make 
laptops useful. As Andi pointed out some architectures can't run 4k 
stacks, and at the memory sizes people typically use there would 
probably be a performance gain to do memory in 8k or larger blocks anyway.

I just see this as a large hassle for many laptop users and people with 
unconverted drivers, and no significant gain for most. 4k stacks work 
fine on most machines, but some people just can't use them.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
