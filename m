Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWIAIiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWIAIiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 04:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWIAIiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 04:38:18 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:65490 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S932065AbWIAIiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 04:38:18 -0400
Date: Fri, 1 Sep 2006 09:38:15 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, haveblue@us.ibm.com,
       apw@shadowen.org, ak@muc.de, benh@kernel.crashing.org, paulus@samba.org,
       kmannth@gmail.com, tony.luck@intel.com, kamezawa.hiroyu@jp.fujitsu.com,
       y-goto@jp.fujitsu.com
Subject: Re: x86_64 account-for-memmap patch in 2.6.18-rc4-mm3 doesn't boot.
In-Reply-To: <20060831100156.24fc0521.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0609010933220.25057@skynet.skynet.ie>
References: <20060831034638.4bfa7b46.pj@sgi.com> <Pine.LNX.4.64.0608311650410.13392@skynet.skynet.ie>
 <20060831100156.24fc0521.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006, Paul Jackson wrote:

> Mel wrote:
>> Have you any idea why the console garbling is happening?
>
> Yeah - you're right - it's garbled.  Looks like its dropping chars.
>

Or writing some chars twice but at a different time. The system might be 
one of those that fakes serial console output on the assumption the 
operating system isn't doing the same thing. I've seen one or two blade 
systems that did something like this with mixed results.

> I don't know why, but I'm not surprised.  It's a lab system with a
> new (for us) way of rigging the console output.  I just got this
> particular x86_64's console connection to work at all yesterday.
>
> I've been working indirectly through my good lab tech.  I should
> drive in to the lab that has this rig (an hour away) and check it
> out in person, and see what can be done to get clean console output.
>

That is a bit of a sickener. It may be worth getting your good lab tech 
to check if there is a configuration setting in the hardware for 
simulating console output before you make the trip.

> This may take a day or three to yield results, unless I get lucky.
>

I have Keith's problem with reserve-based-hot-add to keep me occupied in 
the meantime. Whenever you get the chance will be fine. Thanks a lot

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
