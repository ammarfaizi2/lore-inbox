Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVAXKmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVAXKmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 05:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVAXKmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 05:42:22 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:61065 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S261407AbVAXKmP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 05:42:15 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None, usuallly detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.36-00
Date: Mon, 24 Jan 2005 05:42:14 -0500
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>
References: <20041122005411.GA19363@elte.hu> <200501221622.24273.gene.heskett@verizon.net> <20050124080254.GA7753@elte.hu>
In-Reply-To: <20050124080254.GA7753@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501240542.14637.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.47.137] at Mon, 24 Jan 2005 04:42:14 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 January 2005 03:02, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@verizon.net> wrote:
>> On Saturday 22 January 2005 07:29, Ingo Molnar wrote:
>> >i have released the -V0.7.36-00 Real-Time Preemption patch, which
>> > can be downloaded from the usual place:
>> >
>> >  http://redhat.com/~mingo/realtime-preempt/
>> >
>> >this is mainly a merge to 2.6.11-rc2.
>>
>> Humm, by the time I went after the patch it was up to -02.
>>
>> And I'm getting a couple of error exits:
>> -------------------
>> net/sched/sch_generic.c: In function `qdisc_restart':
>> net/sched/sch_generic.c:128: error: label `requeue' used but not
>> defined
>
>indeed - !PREEMPT_RT compilation broke. I've uploaded -03 with the
> fix (and other fixes).
>
> Ingo

Thanks a bunch for your work, Ingo.  I'm having fun running this 
stuff, and it really does seem to help everything but 
kmail/spamassassin.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.32% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
