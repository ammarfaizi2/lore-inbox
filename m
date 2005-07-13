Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVGMRzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVGMRzn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVGMRxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:53:44 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:53007 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261995AbVGMRvI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:51:08 -0400
Message-ID: <42D55562.3060908@tmr.com>
Date: Wed, 13 Jul 2005 13:54:42 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
References: <200507122110.43967.kernel@kolivas.org>	<Pine.LNX.4.62.0507120446450.9200@qynat.qvtvafvgr.pbz> <200507122202.39988.kernel@kolivas.org>
In-Reply-To: <200507122202.39988.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Tue, 12 Jul 2005 21:57, David Lang wrote:
> 
>>this looks very interesting, however one thing that looks odd to me in
>>this is the thought of comparing the results for significantly different
>>hardware.
>>
>>for some of the loads you really are going to be independant of the speed
>>of the hardware (burn, compile, etc will use whatever you have) however
>>for others (X, audio, video) saying that they take a specific percentage
>>of the cpu doesn't seem right.
>>
>>if I have a 400MHz cpu each of these will take a much larger percentage of
>>the cpu to get the job done then if I have a 4GHz cpu for example.
>>
>>for audio and video this would seem to be a fairly simple scaleing factor
>>(or just doing a fixed amount of work rather then a fixed percentage of
>>the CPU worth of work), however for X it is probably much more complicated
>>(is the X load really linearly random in how much work it does, or is it
>>weighted towards small amounts with occasional large amounts hitting? I
>>would guess that at least beyond a certin point the liklyhood of that much
>>work being needed would be lower)
> 
> 
> Actually I don't disagree. What I mean by hardware changes is more along the 
> lines of changing the hard disk type in the same setup. That's what I mean by 
> careful with the benchmarking. Taking the results from an athlon XP and 
> comparing it to an altix is silly for example.

I'm going to cautiously disagree. If the CPU needed was scaled so it 
represented a fixed number of cycles (operations, work units) then the 
effect of faster CPU would be shown. And the total power of all attached 
CPUs should be taken into account, using HT or SMP does have an effect 
of feel.

Disk tests should be at a fixed rate, not all you can do. That's NOT 
realistic.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
