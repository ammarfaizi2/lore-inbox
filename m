Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTJDJxU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 05:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbTJDJxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 05:53:20 -0400
Received: from dyn-ctb-203-221-74-2.webone.com.au ([203.221.74.2]:57356 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261968AbTJDJxR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 05:53:17 -0400
Message-ID: <3F7E986D.2060903@cyberone.com.au>
Date: Sat, 04 Oct 2003 19:52:45 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Tom Sightler <ttsig@tuxyturvy.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problems caused by scheduler tweaks in 2.6.0-test6?
References: <1065188297.2660.17.camel@iso-8590-lx.zeusinc.com> <3F7E8EC0.7080008@cyberone.com.au> <200310041950.44011.kernel@kolivas.org>
In-Reply-To: <200310041950.44011.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Sat, 4 Oct 2003 19:11, Nick Piggin wrote:
>
>>Did you see this Con?
>>
>>By the way Tom, I have my scheduler patch available for test6 here:
>>http://www.kerneltrap.org/~npiggin/v15a/sched-rollup-v15a-260t6.gz
>>
>>Tom Sightler wrote:
>>
>>>Hi All,
>>>
>>>Over the last few months I have tested many different scheduler tweaks
>>>mostly by testing the -mm kernels and also by applying Nick's patches
>>>against vanilla kernels.  Up until recently I have been very happy with
>>>2.6.0-test5 with Nick's scheduler patches.
>>>
>>>Then I decided to try 2.6.0-test6 which seems to include a lot of Con's
>>>work and, while overall this seems nice, I'm having two relatively
>>>serious side effects that seem to be related to this inclusion.
>>>
>>>1.  VMware performance varies wildly.  I can't put my finger on this
>>>exact issue, but I have found as way to repeatably trigger bad
>>>performance.  When running VMware in fullscreen mode, enable window
>>>animation and repeatedly minimize/maximize a window.  Under 2.4.x and
>>>2.6.0-test5 w/Nick's patches this process runs reasonably smooth,
>>>although noticably slower than native speed.  With stock 2.6.0-test6
>>>after only a few seconds the minimize/maximize animiation slows to a
>>>complete crawl, take 20+ seconds to complete the minimize opertaion.
>>>I've tried tuning VMware with priorities but no luck.
>>>
>>>2.  I also use Wine to run various Windows programs on occasion,
>>>particularly Outlook 2000 (mainly when attempting to help other running
>>>this application on Windows).  The program runs fine, but always hangs
>>>on exit.  I didn't originally think this was related to the scheduler,
>>>but interestingly, after applying Nick's patches to 2.6.0-test6, which
>>>back out Con's changes, this problem goes away.
>>>
>>>Is there any help out there for these type of issues?  I know that many
>>>people seem to think these changes make life better, and I'll admidt
>>>that playing MP3's and DVD's is better with these changes, but I'd
>>>rather have my system preform well at other tasks.  I would think having
>>>a way to turn off all the fancy interactivity detection would be ideal
>>>but there always seems to be opposition to adding tuning knobs.
>>>
>>>
>
>Please send a rundown of what top shows during these occurrences, and please 
>define "hangs". I can't see how the scheduler tweaks can bring the machine 
>down.
>

Could be unrelated. Might be a livelock or priority inversion spinning 
thingy


