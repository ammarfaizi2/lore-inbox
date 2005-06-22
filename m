Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVFVOIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVFVOIP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVFVOIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:08:15 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:8332 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261298AbVFVOIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:08:12 -0400
Date: Wed, 22 Jun 2005 10:08:10 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <200506220951.59512.gene.heskett@verizon.net>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Benjamin LaHaise <bcrl@kvack.org>,
       William Weston <weston@sysex.net>, "K.R. Foley" <kr@cybsft.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>, linux-ns83820@kvack.org,
       nhorman@redhat.com, Jeff Garzik <jgarzik@redhat.com>
Message-id: <200506221008.10384.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050608112801.GA31084@elte.hu>
 <200506220927.07874.gene.heskett@verizon.net>
 <200506220951.59512.gene.heskett@verizon.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 June 2005 09:51, Gene Heskett wrote:
>On Wednesday 22 June 2005 09:27, Gene Heskett wrote:
>>On Wednesday 22 June 2005 03:40, Ingo Molnar wrote:
>>>* Gene Heskett <gene.heskett@verizon.net> wrote:
>>>> FWIW, 50-06 is running clean here with mode 3 & no hardirq
>>>> threading. Uptime is about 9 hours.
>>>>
>>>> Would it do any good to try mode 4 & see if tvtime still runs?
>>>> Previously, I got the impression that was a dma problem & posted
>>>> some of the logs, but I've not noted any fixes for that go by.
>>>
>>>sure, any extra testing - even if it finds no problems, is just as
>>>useful. Especially if you have a .config where everything works.
>>> That way we'll know for sure that any regressions are related to
>>> PREEMPT_RT.
>>>
>>> Ingo
>>
>>I can report that mode 4 is not at all well here.  I turned it on
>> and changed the extraversion, built it, and when it booted, it got
>> to this line and hung:
>>
>>Checking to see if this processor honours the WP bit even in
>>supervisor mode... OK.
>>
>>And I had to use the hardware reset to recover & boot to a mode 3
>>version of 50-06.
>>
>>That .config is attached.
>
>I can also report that the modules did not get installed, I'd
>forgotten to rename the src tree to match the extraversion, so the
>final cd my script makes to install the modules failed.  I have a
> new version building to dbl-check this.

And that also resulted in the hang at the above lines completion.


-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
