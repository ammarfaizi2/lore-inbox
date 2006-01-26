Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWAZUEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWAZUEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWAZUEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:04:23 -0500
Received: from 8.ctyme.com ([69.50.231.8]:46221 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1751395AbWAZUEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:04:23 -0500
Message-ID: <43D92B45.1030601@perkel.com>
Date: Thu, 26 Jan 2006 12:04:21 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Chase Venters <chase.venters@clientec.com>
CC: Diego Calleja <diegocg@gmail.com>, Paul Jakma <paul@clubi.ie>,
       torvalds@osdl.org, linux-os@analogic.com, mrmacman_g4@mac.com,
       jmerkey@wolfmountaingroup.com, pmclean@cs.ubishops.ca,
       shemminger@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <43D114A8.4030900@wolfmountaingroup.com> <20060120111103.2ee5b531@dxpl.pdx.osdl.net> <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com> <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <Pine.LNX.4.64.0601261757320.3920@sheen.jakma.org> <20060126195323.d553a4b8.diegocg@gmail.com> <Pine.LNX.4.64.0601261255430.17225@turbotaz.ourhouse> <43D92175.6010804@perkel.com> <Pine.LNX.4.64.0601261344220.17514@turbotaz.ourhouse>
In-Reply-To: <Pine.LNX.4.64.0601261344220.17514@turbotaz.ourhouse>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chase Venters wrote:
> On Thu, 26 Jan 2006, Marc Perkel wrote:
>
>> There seems to be some confusion about licensing. I'm just going to 
>> see if I can define the problem and the issues.
>>
>> First - some people think all of Linux is under GPLv2 - but some 
>> people seem to think it's really GPLv2 or later. That needs to be 
>> resolved. Can different parts of Linux be controlled by multiple 
>> licenses. If so - that could create confusion because someone would 
>> have to agree to all the licenses within Linux in order to use it. 
>> The alternative is to say it's all GPLv2 and exclude GPLv3 from 
>> inclusion. Do we want to do that.
>
> I don't think there are any questions about what the "whole" of Linux 
> is governed under. It's governed by whatever the most 'restrictive' 
> license usage is, which is 'GPLv2 Only'. (The fact that GPLv2 Only 
> doesn't apply to the whole kernel or perhaps even to some past kernels 
> doesn't matter - you still can't package the whole as GPLv3)
If I write some code and that code becomes a critical part of the linux 
kernel and my code is GPLv3 then no one could use Linux unless they 
removed my code. (And all GPLv3 code) - Thus the inclusion of GPLv3 code 
would force the whole kernel to be effectively GPLv3. Unless Linus says 
nothing gets included unless it's GPLv2.
>
> The only discussion I see taking place any longer is basically 
> irrelevant to Linux and GPLv3 - it concerns whether or not other, 
> older kernel releases were legally GPLv2 Only or not. A disagreement 
> on either the intent, mechanism or action of parts of the GPL license, 
> if you will.
>
>> Second - is GPLv3 Linux compatible. If Linux were to start over today 
>> would it pick GPLv2 or GPLv3? Is there anything in GPLv3 that is not 
>> Linux compatible. I would at least like to see GPLv3 (final draft) to 
>> be 100% Linux compatible.
>
> What does Linux compatible mean? Linus expressed some frustrations 
> with some of the new terms, so perhaps in that sense the new license 
> is not compatible.
In this context Linux compatible means a license that Linus is happy with.
>
> If I'm reading him right, he doesn't want to restrain vendors like 
> TiVO from using the kernel and subsequently refusing to provide the 
> public with encryption keys necessary to build kernels to run on that 
> hardware (for example).
Yes - so perhaps GPLv3 is not Linux compatible. If so - then GPLv3 needs 
to be changed or excluded.
>
>> Suppose GPLv3 were Linux compatible and many existing authors and new 
>> authors adopted GPLv3 but dead authors and some stubborn people and 
>> people who can't be found are still at GPLv2. Lets also assume that 
>> critical parts of Linux code are licensed in both worlds. What dos 
>> that mean? Does that mean that GPLv3 prevails?
>
> It's mental masturbation at this point. Suppose Linus approved of 
> going to GPLv3... there may be some little technical gotchas in terms 
> of "dead authors", but in that hypothetical, how many people would 
> really be worried that the descendents of these dead authors would 
> actively act to stop Linux from being distributed under the new license?
Lawyers of big corporations. Greedy decendents who pull an SCO.
>
> The bigger issue is that no matter where you fall on GPL's section 9, 
> _lots_ of code is undoubtedly GPLv2 only. These living authors would 
> have to agree to GPLv3, and as we now know, Linus does not.
But if the Kernel contains GPLv3 code then that part of the kernel is 
subject to those restrictions. If the code is critical then it 
affectively makes Linux subjet to GPLv3. Perhaps the only way to avoid 
that is to require the same license for all kernel code?
>
>> This is something that might be worth doing some serious legal work 
>> on because if we do it wrong it could bite us hard in the future. But 
>> I want to try to properly raise the question here so that we all at 
>> least understand the problem.
>
> Why? I think it's pretty much a dead issue.
>
>
When lawyers get involved there is no such thing as a dead issue ..... sigh!

