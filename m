Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVCJMy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVCJMy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 07:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVCJMy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 07:54:26 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:23503 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S262588AbVCJMyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 07:54:16 -0500
Date: Thu, 10 Mar 2005 07:54:14 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.11.2
In-reply-to: <20050309231156.GB31064@kroah.com>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503100754.14711.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050309083923.GA20461@kroah.com>
 <20050309210631.GY3163@waste.org> <20050309231156.GB31064@kroah.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 March 2005 18:11, Greg KH wrote:
>On Wed, Mar 09, 2005 at 01:06:31PM -0800, Matt Mackall wrote:
>> On Wed, Mar 09, 2005 at 12:39:23AM -0800, Greg KH wrote:
>> > And to further test this whole -stable system, I've released
>> > 2.6.11.2. It contains one patch, which is already in the -bk
>> > tree, and came from the security team (hence the lack of the
>> > longer review cycle).
>> >
>> > It's available now in the normal kernel.org places:
>> >  kernel.org/pub/linux/kernel/v2.6/patch-2.6.11.2.gz
>> > which is a patch against the 2.6.11.1 release.
>>
>> Argh! @*#$&!!&!
>>
>> > If consensus arrives
>> > that this patch should be against the 2.6.11 tree, it will be
>> > done that way in the future.
>>
>> Consensus arrived back when 2.6.8.1 came out.
>
>It did?  So, what was it agreed to be?  Any pointers to that
> agreement?
>
>> Please, folks, there are automated tools that "know" about kernel
>> release numbering and so on. Said tools broke with 2.6.11.1
>> because it wasn't in the same place that 2.6.8.1 was and now this
>> breaks with all precedent by being an interdiff along a branch.
>
>2.6.11.1 is now in the proper place, sorry for any inconvience that
>caused.  This happened yesterday.
>
>> Fixing it in the future is too #*$%* late because you've now
>> turned it into a special case.
>
>No, I can always respin the patch, and re-release it if it's a
> problem.

Somewhat Greg, it caught me out.  OTOH, once we know that .2 needs .1, 
we'll be ok.  And it does give a quick method for us frogs to define 
if one of them is a regression.  The only thing that should break if 
we leave one out of the squence is the EXTRAVERSION path in the 
Makefile & we can certainly fix that easily enough for testing.

Question?  Is it a given that these, if they don't have warts, will be 
in mainline 2.6.12?

>thanks,
>
>greg k-h
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
