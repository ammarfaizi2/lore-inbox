Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272242AbTHNIBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 04:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272244AbTHNIBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 04:01:21 -0400
Received: from [205.208.236.2] ([205.208.236.2]:10503 "EHLO
	applegatebroadband.net") by vger.kernel.org with ESMTP
	id S272242AbTHNIBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 04:01:19 -0400
Message-ID: <3F3B41C7.1000906@mvista.com>
Date: Thu, 14 Aug 2003 01:01:11 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rob@landley.net
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <3F32C752.4000403@wmich.edu> <3F355F12.4040609@mvista.com> <200308132024.36967.rob@landley.net>
In-Reply-To: <200308132024.36967.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Saturday 09 August 2003 16:52, George Anzinger wrote:
> 
>>Ed Sweetman wrote:
>>
>>>the problem is you want a process that works like it was run on a single
>>>tasking OS on an operating system that is built from the ground up to be
>>> a multi-user multi-tasking OS
> 
> 
> Considering the multi-tasking OS has 1000 times the CPU power, memory, and 
> disk space as the single-tasking OS did when it debuted, yet still loses to 
> it in some areas, isn't it at least worth looking at?
> 
> 
>>>and you want both to work perfectly at peak performance
> 
> 
> We're pondering various heuristics with which to to improve the situation and 
> you say we're persuing perfection.  From heuristics.
> 
> Do you say these sort of things to the virtual memory people?  (Since you 
> can't do it perfectly, why bother to swap at all?  The perfect being the 
> enemy of the good, and all that.)
> 
> 
>>>and you want it to know when you want which to work at
>>>peak performance automatically.
> 
> 
> I know for a fact that automatic determination of interactivity is possible.  
> In OS/2 you could speed up a compile by  moving the mouse pointer over its 
> window repeatedly to give it extra clock ticks.  (So far we've managed to 
> avoid anything quite so disgusting in Linux, but there exist OSes where it 
> was done.  Having the keyboard and mouse and display be local devices is 
> actually the common case.  It took X about ten years to finally start 
> optimizing for the common case on the output side with MIT shared memory 
> extensions and such...)
> 
> The scheduler actually has a lot of information to work with.  Ingo's patches 
> strive to give it more information, and and Con's patches make much better 
> use of that information.  This is a good thing.
> 
> 
>>Well said :)
> 
> 
> Actually, I didn't really consider that list of straw man arguments to be 
> worth commenting on the first time around.  (I thought he was being 
> sarcastic...)

Well, I think he was too, but I am trying to say (as I think you are 
too) that it is not far from being a realistic goal.

As to timing, I just changed ISPs and was off line for a few days...
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


