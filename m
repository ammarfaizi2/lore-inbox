Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316909AbSEVJoV>; Wed, 22 May 2002 05:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316910AbSEVJoU>; Wed, 22 May 2002 05:44:20 -0400
Received: from [195.63.194.11] ([195.63.194.11]:51470 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316909AbSEVJoS>; Wed, 22 May 2002 05:44:18 -0400
Message-ID: <3CEB598E.1090100@evision-ventures.com>
Date: Wed, 22 May 2002 10:40:46 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SLC82C105 IDE driver: missing __init
In-Reply-To: <20020522091648.GB312@pazke.ipt> <20020522103602.A15750@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Russell King napisa?:
> On Wed, May 22, 2002 at 01:16:48PM +0400, Andrey Panin wrote:
> 
>>slc82c105_bridge_revision() functions lacks __init modifier.
>>Attached patch (against 2.5.17) fixes it.
>>Compiles, but untested. Please consider applying.
> 
> 
> I'm surprised it compiles. 

I'm not :-). I wouldn't be even surprised if it works by accident...

> I've got a rather major update to it here,
> but I need to find time to pull it out of the ARM patch, and I need IDE
> to settle down a bit so the two are actually in sync with each other.
> (Martin messed up my DMA changes which'd prevent sl82c105 linking - I'm
> waiting for the fix to emerge, which I think is in 2.5.17, but the TLB

It should indeed be all in place right now. Other then this: If you feel like
something in the generic code has to be changed - don't hessitate just
do it. We can always sort it out.

> stuff in 2.5.17 has broken all my ARM builds, so I'm unable to build or
> test anything on 2.5 currently.)

Just to make it clean - this time it was not me ;-).

> 
> Too many things to do... too many problems to solve... too many patches
> to look at... too much email... not enough hours in the day... not enough
> fast machines to build kernels on... not enough rmk clones to run kernel
> tests... 8)

