Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbTI0T6Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 15:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbTI0T6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 15:58:24 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.102]:58822 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261639AbTI0T6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 15:58:22 -0400
Message-ID: <3F75EC3B.4030305@softhome.net>
Date: Sat, 27 Sep 2003 21:59:55 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030831
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] No Swap. Re: [BUG 2.6.90-test5] kernel shits itself with
 48mb ram under moderate load
References: <ArQ0.821.23@gated-at.bofh.it> <ArQ0.821.25@gated-at.bofh.it> <ArQ0.821.21@gated-at.bofh.it> <ArZC.8f1.9@gated-at.bofh.it>
In-Reply-To: <ArZC.8f1.9@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:
> On Sat, 27 Sep 2003 20:13:48 +0200, Ihar 'Philips' Filipau wrote:
> 
>>Roger Luethi wrote:
>>
>>>On Sun, 28 Sep 2003 01:26:34 +1000, Jason Lewis wrote:
>>>
>>>>0 12      0   3424    816   6008    0    0 19712     0 5519  3184  0 12  
>>>>0 87
>>>
>>>         ^^^^
>>>Looks like you don't have swap enabled. Are successful 2.4 runs with or
>>>without swap?
>>
>>   I'm running RH stock 2.4.20-20.9 without swap for around month.
>>   OOo, Mozilla, eDonkey & heaps of xterms. Even evaluation of VMware 
>>with Win2K inside was Ok.
>>   On average: much better experience.
> 
> Better than with swap? Or better than 2.6?
> 

   Better than with swap. This is production workstation - I cannot test 
something on it :-(

> 
>>$ free
>>             total       used       free     shared    buffers     cached
>>Mem:        513872     507128       6744          0      32784     341404
> 
> The initial post was about a 48 MB machine. 10% of what you have. The
> poster's system is paging like crazy -- since all dirty pages without a
> mapping are pinned in memory, it must shuffle around the rest.
> 

    Sorry, I even marked $subject as [OT].
    I'm answering the question '2.4 without swap' - Yes. It is. Works. 
No  problems.

    <rant>'Paging like crazy' became for me a synonym of Linux. It 
doesn't matter how much memory you have. Less == worse. Developers 
stopped testing VMM regression on low-memory computers long time ago. 
<sarcasm>We have now fashion for clusters and numas. And a lot of swap 
on very fast raids. <sarcasm size=+100%>After all it is cheap. Just 
couple of thousands greenbacks. </sarcasm> </sarcasm> It was really 
funny when developers on LKML were sugesting to buy another hdd for 
swap. Very funny.</rant>

    Unfortunately I'm not a specialist in VMM...
    As I see there is not that much edge case testing going around.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

