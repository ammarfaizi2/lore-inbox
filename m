Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVLEXdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVLEXdW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbVLEXdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:33:22 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:51438 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S964868AbVLEXdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:33:21 -0500
Date: Mon, 05 Dec 2005 18:33:19 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ntp problems
In-reply-to: <1133818753.7605.47.camel@cog.beaverton.ibm.com>
To: linux-kernel@vger.kernel.org
Message-id: <200512051833.19629.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200512050031.39438.gene.heskett@verizon.net>
 <1133818753.7605.47.camel@cog.beaverton.ibm.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 16:39, john stultz wrote:
>On Mon, 2005-12-05 at 00:31 -0500, Gene Heskett wrote:
>> Greetings everybody;
>>
>> I seem to have an ntp problem.  I noticed a few minutes ago that if
>> my watch was anywhere near correct, then the computer was about 6
>> minutes fast.  Doing a service ntpd restart crash set it back nearly
>> 6 minutes.
>
>Not sure exactly what is going on, but you might want to try dropping
>the LOCAL server reference in your ntp.conf. It could be you're just
>syncing w/ yourself.
>
>thanks
>-john

Joanne, bless her, pointed out that I had probably turned the ACPI
stuff in my kernel back on.  She was of course correct, shut it off &
ntpd works just fine.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

