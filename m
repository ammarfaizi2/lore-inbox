Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVFQCG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVFQCG3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 22:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVFQCG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 22:06:29 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:37557 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261895AbVFQCG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 22:06:27 -0400
Date: Thu, 16 Jun 2005 22:06:23 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <20050616204358.GA4656@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Message-id: <200506162206.23637.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050608112801.GA31084@elte.hu> <42B1BDF7.1000700@cybsft.com>
 <20050616204358.GA4656@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 June 2005 16:43, Ingo Molnar wrote:
>* K.R. Foley <kr@cybsft.com> wrote:
>> >>[...] That works to get the system booted. Although I am getting
>> >> many soft lockups now, minutes after the boot. Log attached.
>> >> [...]
>> >
>> >hm, do you get actual lockups, or only the messages about them?
>> > I.e. does the system work fine if you [the sounds of careful
>> > thinking to get the word right] disable
>> > CONFIG_DETECT_SOFTLOCKUP, or does it lock up silently?
>>
>> There doesn't seem to be any actual lockups, just messages. I will
>> try disabling the above when I get home this evening. Can't get to
>> the system right now.
>
>i tweaked the softlockup detector in the last patch a bit (to fix
> false positives under very high loads), might have broken it on
> SMP.
>
> Ingo

I noticed that -33 seems to have a measurable lifetime, so I did the 
edits mentioned in this thread and built it.  Running now.  Gotcha's 
if any, reported later.  Preempt Mode=3

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
