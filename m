Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbULPCUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbULPCUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 21:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbULPCU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 21:20:29 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:30400 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S262566AbULPCRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 21:17:23 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, linux-os@analogic.com
Subject: Re: dynamic-hz
Date: Wed, 15 Dec 2004 21:17:20 -0500
User-Agent: KMail/1.7
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Stefan Seyfried <seife@suse.de>, Con Kolivas <kernel@kolivas.org>,
       Pavel Machek <pavel@suse.cz>, Andrea Arcangeli <andrea@suse.de>
References: <20041211142317.GF16322@dualathlon.random> <1103133841.3180.1.camel@localhost.localdomain> <Pine.LNX.4.61.0412151448580.4365@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0412151448580.4365@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412152117.20568.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.42.94] at Wed, 15 Dec 2004 20:17:21 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 December 2004 14:54, linux-os wrote:
>On Wed, 15 Dec 2004, Alan Cox wrote:
>> On Maw, 2004-12-14 at 00:16, Eric St-Laurent wrote:
>>> Alan,
>>>
>>> On a related subject, a few months ago you posted a patch which
>>> added a nice add_timeout()/timeout_pending() API and converted
>>> many (if not most) drivers to use it.
>>>
>>> If I remember correctly it did not generate much comments and the
>>> work was not pushed into mainline.
>>>
>>> I think it's a nice cleanup, IMHO the
>>> time_(before|after)(jiffies, ...) construct is horrible.
>>>
>>> Any chance to resurrect this work ?
>>
>> I plan to ressurect it when I have a little time but with some
>> small additions from the original work. Several people said "it
>> should be mS not HZ" and someone at OLS proposed that the API also
>> includes an accuracy guide so that systems using programmed
>> wakeups can aggregate timers when accuracy doesn't matter.
>
>I sure hope it isn't mS. Transconductance or its reciprocal doesn't
>work very well for timing unless you supply the capacitor ;^)

Me sticks hand up and waves at teacher.

And what does 'Transconductance' have to do with this?

That may be the wrong terminology to apply here.

In vacuum tube (remember those?) specifications, this is the gain of
the tube, which AIR is stated as the change in plate current for a
one volt change in grid bias, and is normally stated in micromho's as
they are high voltage, low current devices, with the highest gain
tube that I'm aware of being the 7788.   Using the same measurement
technique applied to modern relatively highed power field effect
transistors where the currents can be many amperes, readings best
stated in mho's are fairly common today. A 'mho' of course, is the
reciprocal of an ohm.

>FYI, mS means milli-Siemens. Seconds is lower-case --always.

Yup.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

