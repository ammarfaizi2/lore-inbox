Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287249AbRL2XdS>; Sat, 29 Dec 2001 18:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287243AbRL2XdJ>; Sat, 29 Dec 2001 18:33:09 -0500
Received: from mail008.syd.optusnet.com.au ([203.2.75.232]:60623 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S287246AbRL2Xcy>; Sat, 29 Dec 2001 18:32:54 -0500
Date: Sun, 30 Dec 2001 10:32:47 +1100
Subject: Re: RFC: Linux Bug Tracking & Feature Tracking DB
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
Cc: linux-kernel@vger.kernel.org
To: timothy.covell@ashavan.org
From: Stewart Smith <stewart@softhome.net>
In-Reply-To: <200112290657.fBT6vMSr008000@svr3.applink.net>
Message-Id: <5DF55AEA-FCB4-11D5-880A-00039350C45A@softhome.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.480)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about instead of tracking bugs and if they've been squashed. Why 
don't we build a database of known bugs with different kernel versions. 
i.e. You can go to the site and get a complete list of every single bug 
that people have entered about 2.0.36 you're still running on that box 
under the stairs.

People could then 'vote' on the bug, so we could keep track of what's a 
big problem for a lot of people, and what's something that just one 
person found not to work.

This would also help people pick 'stable' kernels for their own systems.

Kept seperate from kernel development (i.e. bugs never have to be 
'closed') it means that Linus et al wouldn't have to spend half their 
time there (esp if it wasn't the way they wanted to work), unless they 
wanted to of course :)

just my 2 Australian peso



On Saturday, December 29, 2001, at 05:53  PM, Timothy Covell wrote:

>
> I'm sure that this has been proposed and discussed
> before, and I'm sure that some of the software houses
> like RedHat must do this internally, but here goes again....
>
>
> First the obvious problem:
>
> Just today, I had a problem with a system lockup on 2.4.16
> which was fixed in 2.4.17.  Although, I try to read the changelogs,
> most of them are so terse as to be worthless to anyone but the
> kernel hackers themselves.   And few people beside the hackers
> have time to read through all the patches just in case the pertinant
> fix might be there (and if said person could readily do this, he
> could probably code his own fixes!)
>
>
> Present solution:
>
> Kernel hackers spend lots of time reading email and replying.
> This requires that kernel hackers are user friendly, can easily
> recognize bugs, and easily recall fixes, have lots of time on
> their hands, etc.
>
>
>
> Proposed Solution:
>
> A kernel bug and feature tracking system.  This would similar
> to what you all know (like Bugtraq).   Entries might look something 
> like:
>
> Example bug:
>
> bug #13697
> Synopsys: Hard kernel lockup on 2.4.16 with ieee1394 SBP-2.
> Solution: Patch file: pdrv54678
>             
> http://patches.linux.org./pub/linux/v2.4/patches/p/drv/54678.diff
> Platform: x86
> Section: drivers
> Subsection: ieee1394
> Contact: joe_hacker@linux-ieee1394.sourceforge.net.
> Web URL: http://linux1394.sourceforge.net
>
> Note: All patches in 'diff -urc' format.
>
> Example Feature:
>
> Search Results on Keyword: SBP-2 	Platform: x86
>
> Topic: SBP-2
> Platform: x86
> Section: drivers
> Subsection: ieee1394
> Support on 2.2.x-2.2.y and 2.4.x-2.4.present
> Maturity: 7 (of 10)
> Relevant Bug Reports:   #13697, #14999
> Contact: joe_hacker@linux-ieee1394.sourceforge.net.
> Web URL: http://linux1394.sourceforge.net
>
>
>
>
> The outstanding issues:
>
> 1. The maintainer of this DB would need to receive patches
> along with patch.lsm and feature.lsm like files from the code
> maintainers.   That means  that Linus, Alan, Marcello, Dave
> Jones, et al.,  might have to be involved.
>
> 2. DB would be a high volume site (at least that's the idea!)
>
> 3. Would would pay for and maintain it?  (I know, since I'm
> the one putting forth the idea, it's mine to run with.  However,
> a. I ain't rich.  b. following from a., I have no bandwidth 24kbps
> dialup.)
>
>
>
>
> That's my RFC.
>
>
> timothy.covell@ashavan.org.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
------------------------------
Stewart Smith
stewart@softhome.net
Ph: +61 4 3884 4332
ICQ: 6734154

