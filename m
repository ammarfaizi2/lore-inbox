Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVF0FoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVF0FoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 01:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVF0FoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 01:44:09 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:4801 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S261828AbVF0Fnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 01:43:50 -0400
Date: Mon, 27 Jun 2005 01:43:44 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <20050625041453.GC6981@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, William Weston <weston@sysex.net>,
       "K.R. Foley" <kr@cybsft.com>, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Message-id: <200506270143.47690.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org>
 <Pine.LNX.4.58.0506241510040.32173@echo.lysdexia.org>
 <20050625041453.GC6981@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 June 2005 00:14, Ingo Molnar wrote:
>* William Weston <weston@sysex.net> wrote:
>> On Fri, 24 Jun 2005, Ingo Molnar wrote:
>> > do you have the NMI watchdog enabled? Find below
>> > serial-logging-earlyprintk-nmi.txt.
>>
>> I had a serial console up, but not NMI watchdog until now.  Here's
>> some NMI watchdog traces from both -50-17 and -50-18:
>
>all of these traces seem to have lockupcli involved - is that
> correct? lockupcli is just a userspace test-app to artificially
> trigger a hard-lockup (it disables interrupts and goes into an
> infinite loop). So the NMI watchdog triggering on lockupcli would
> be normal and expected. So once this works, it would be nice to
> reproduce whatever hard lockup you are seeing and see whether the
> NMI watchdog produces any output to the serial log. (if such log is
> supposed to be included in your dmesg then it somehow got
> intermixed with lockupcli logs)
>
> Ingo

In the FWIW category, I booted 50-23 about an hour & a half ago, same 
mode 3, no hardirq's, everything seems to be working fine except for 
kmails total lack of threading causeing composer hangs while a mail 
fetch/spamassassin run is in progress.  But thats not anything new to 
this patchset, its an equal opportunity annoyer.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
