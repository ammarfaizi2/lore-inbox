Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVACWse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVACWse (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVACWWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:22:12 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:22169 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261911AbVACWTl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:19:41 -0500
Message-ID: <41D9C53A.3030503@tmr.com>
Date: Mon, 03 Jan 2005 17:20:42 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "L. A. Walsh" <law@tlinx.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reviving the concept of a stable series (was Re: starting with
 2.7)
References: <20050102232102.GN26717@gallifrey><20050102232102.GN26717@gallifrey> <41D91707.6040102@tlinx.org>
In-Reply-To: <41D91707.6040102@tlinx.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

L. A. Walsh wrote:
> I don't know about #3 below, but #1 and #2 are certainly true.
> I always preferred to run a vanilla stable kernel as I did not
> trust the vendors' kernels because their patches were not as well
> eyed as the vanilla kernel.  I prefer to compile a kernel for
> my specific machines, some of which are old and do better with a
> hand-configured kernel rather than a Microsoftian monolith that
> is compiled with all possible options as modules.

Same conclusion from another direction. If I make a patch which I know 
can't (or won't) be accepted into the mainline, it's easier for me to 
carry it forward on a mainline kernel. I'm happy to say I haven't had to 
do that for a while, although I will probably rehack the network code a 
little this summer.

> Nevertheless, it would be nice to see a no-new-features, stable series
> spun off from these development kernels, maybe .4th number releases,
> like 2.6.10 also becomes a 2.6.10.0 that starts a 2.6.10.1, then 2.6.10.2,
> etc...with iteritive bug fixes to the same kernel and no new features
> in such a branch, it might become stable enough for users to have 
> confidence
> installing them on their desktop or stable machines.
> 
> It wouldn't have to be months upon months of diverging code, as jumps
> to a new stable base can be started upon any fairly stable development
> kernel, say 2.6.10 w/e100 fixed, tracing fixed, the slab bug fix, and
> the capabilities bugs fixed going into a 2.6.10.1 that has no new features
> or old features removed.  Serious bug fixes after that could go into a
> 2.6.10.2, etc.  Such point releases would be easier to manage and only
> be updated/maintained as long as someone was interested enough to do it.
> 
> The same process would be applied to a future dev-kernel that appears to be
> mostly stable after some number of weeks of alpha testing.  It may be
> the case that a given furture dev-kernel has no stable branch off of it
> because it either a) didn't need one, or b) was too far from stable to 
> start
> one.

If the -rc process were in place, new feature freeze until the big green 
bugs were fixed just before the next release, that actually might be 
most of a solution.

No one bug akpm can accurately asses how well fixes come back from 
vendors, but I suspect that the kernel is moving too fast and vendors 
"pick one" and stabilize that, by which time the kernel.org is 
generations down the road. It's possible that some fixes are then 
rediffed against the current kernel and fed, but I have zero information 
on that happening or not.

>>  3) In some cases the commercial vendors don't seem to release
>>  source to some of the kernels except to people who have bought
>>  the packages, so those vendor kernel fixes aren't 'publically'
>>  visible.

That shouldn't happen, and in practice it's rare. But you may have to 
search a bit to find the sources...

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
