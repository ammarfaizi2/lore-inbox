Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318205AbSIBB7I>; Sun, 1 Sep 2002 21:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318207AbSIBB7I>; Sun, 1 Sep 2002 21:59:08 -0400
Received: from mercury.it.wmich.edu ([141.218.1.92]:3462 "EHLO
	mercury.localmail") by vger.kernel.org with ESMTP
	id <S318205AbSIBB7H>; Sun, 1 Sep 2002 21:59:07 -0400
Message-ID: <3D72C6F9.6000302@wmich.edu>
Date: Sun, 01 Sep 2002 22:03:37 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Benchmarks for performance patches (-ck) for 2.4.19
References: <1030929021.3d72ba7dadbe7@kolivas.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wouldn't the majority (to an undeniable extent) of the "responsiveness" 
of desktop usage be on X's code? if we are talking about that.  The 
problem with finding a benchmark is that first you have to have a 
definition of what you're benchmarking.  The "system responsiveness" 
term is far too vague. When there's a definition to the term there can 
be a benchmark made to measure it. I mean, besides making the kernel 
with as low latency as possible, what is bad about the responsiveness in 
the kernel?   If there's any lag in responsiveness that i see it's 
always something X related, particularly Xfree86.

You can't really benchmark something where everyone's issues are "things 
go slow when i use "some" benchmark and try using my computer at the 
same time" or "it feels better or worse."   I'd be quite interested in 
making a benchmark and/or using it to help responsiveness in linux, who 
wouldn't want that?  But I just think we have a fairly good kernel and 
the bottleneck is not it in the case of the majority of users and what 
they report as "system responsiveness."  As computers get faster and 
faster we expect to see that reflected in the software we use, perhaps 
it's just making some design issues with X more apparent ...perhaps not. 
  Just some food for thought.




Con Kolivas wrote:
> My merged patchset (http://kernel.kolivas.net) was designed to improve system
> responsiveness. I have yet to find a good benchmark that measures such a thing.
> However, in response to criticism about not providing benchmarks I have made
> available some standard benchmarks at the excellent resources of the open source
> development laboratory scalable test platform. They are available here:
> 
> http://www.osdl.org/stp
> 
> my patchsets are the following:
> -ck5 patch is patch #781
> -ck5-rmap is #782
> -ck5-ll is #783
> 
> I have conducted some basic tests on #781 and the numbers show it is at least
> equivalent to stock 2.4.19 (#747), although as I said none of these benchmarks
> are designed to test desktop system responsiveness.
> 
> Please feel free to conduct any tests you like on these patches. I would be
> interested to hear if anyone can suggest the most suitable benchmark. Please cc
> me to ensure I receive any comments.
> 
> Con Kolivas
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



