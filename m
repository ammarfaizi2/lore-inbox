Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVF0VUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVF0VUi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVF0VS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:18:56 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:21893 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261855AbVF0VRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:17:41 -0400
Date: Mon, 27 Jun 2005 17:17:28 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <20050627195405.GB16804@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, William Weston <weston@sysex.net>,
       "K.R. Foley" <kr@cybsft.com>, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Message-id: <200506271717.28968.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org>
 <200506271329.14562.gene.heskett@verizon.net> <20050627195405.GB16804@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 June 2005 15:54, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@verizon.net> wrote:
>> On Monday 27 June 2005 04:17, Ingo Molnar wrote:
>> >* Gene Heskett <gene.heskett@verizon.net> wrote:
>> >> In the FWIW category, I booted 50-23 about an hour & a half
>> >> ago, same mode 3, no hardirq's, everything seems to be working
>> >> fine except for kmails total lack of threading causeing
>> >> composer hangs while a mail fetch/spamassassin run is in
>> >> progress.  But thats not anything new to this patchset, its an
>> >> equal opportunity annoyer.
>> >
>> >does the patch below make the kmail starvation go away?
>>
>> I put in the comment and its building now.  I rather doubt its
>> going to make a huge diff though as its probably the single most
>> repeated bitch on the kmail lists, and has been for a long, very
>> long as in years, time.  From hints dropped here and there, it
>> might finally be fixed with kde-3.5.  But we'll give this a shot
>> nontheless.  I'll add more after I reboot to test.
>
>ah, ok - so kmail behaves similarly on vanilla kernels too? 

Yeaup...

>I 
> thought this might be some -RT-specific degradation.
>
> Ingo

As I just posted in another thread, with this boot I am now getting a 
huge amount of almost strace like detail being output to VT1 from 
kde's/kmails activities.  VT1 being the console I did the startx 
from.  Could this be related to commenting out that line in sched.c?

Sorta new subject next.

Getting all that detail being output to VT1, is there any way I can 
enlarge the VT's scrollback memory buffer?  It's only about 2kb, 
maybe less, less than 2 full screens full.  I'm used to haveing about 
a 10 meg scrollback buffer available for traceing purposes in an x 
console.  I'd appreciate the same length of scrollback for the VT's.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
