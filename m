Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVANTIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVANTIJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVANTG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:06:57 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:39942 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261343AbVANS7g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:59:36 -0500
Message-ID: <41E8173F.2000805@tmr.com>
Date: Fri, 14 Jan 2005 14:02:23 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kasper Sandberg <lkml@metanurb.dk>
CC: Andrew Morton <akpm@osdl.org>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org><20050114002352.5a038710.akpm@osdl.org> <1105707861.6471.1.camel@localhost>
In-Reply-To: <1105707861.6471.1.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Sandberg wrote:
> On Fri, 2005-01-14 at 00:23 -0800, Andrew Morton wrote:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/
>>
>>
>>- Added bk-xfs to the -mm "external trees" lineup.
>>
>>- Added the Linux Trace Toolkit (and hence relayfs).  Mainly because I
>>  haven't yet taken as close a look at LTT as I should have.  Probably neither
>>  have you.
>>
>>  It needs a bit of work on the kernel<->user periphery, which is not a big
>>  deal.
>>
>>  As does relayfs, IMO.  It seems to need some regularised way in which a
>>  userspace relayfs client can tell relayfs what file(s) to use.  LTT is
>>  currently using some ghastly stick-a-pathname-in-/proc thing.  Relayfs
>>  should provide this service.
>>
>>  relayfs needs a closer look too.  A lot of advanced instrumentation
>>  projects seem to require it, but none of them have been merged.  Lots of
>>  people say "use netlink instead" and lots of other people say "err, we think
>>  relayfs is better".  This is a discussion which needs to be had.
>>
>>- The 2.6.10-mm3 announcement was munched by the vger filters, sorry.  One of
>>  the uml patches had an inopportune substring in its name (oh pee tee hyphen
>>  oh you tee).  Nice trick if you meant it ;)
>>
>>- Big update to the ext3 extended attribute support.  agruen, tridge and sct
>>  have been cooking this up for a while.  samba4 proved to be a good
>>  stress test.
>>
>>- davej's "2.6 post-Halloween features" document has been added to -mm as
>>  Documentation/feature-list-2.6.txt in the hope that someone will review it
>>  and help keep it up-to-date.
>>
>>- Added FUSE (filesystem in userspace) for people to play with.  Am agnostic
>>  as to whether it should be merged (haven't read it at all closely yet,
>>  either), but I am impressed by the amount of care which has obviously gone
>>  into it.  Opinions sought.
> 
> 
> i really believe fuse is a good thing to have merged, i use it, and it
> works really really good. my vote is to get it in

I like the idea, but I also like the practice of letting a feature like 
this sit in -mm for a few weeks or even a month until people have a 
chance to break^H^H^H^H^Htest it a bit.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
