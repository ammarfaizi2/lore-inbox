Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVAWOlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVAWOlD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 09:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVAWOlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 09:41:03 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:22481 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261206AbVAWOk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 09:40:57 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None, usuallly detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.36-00
Date: Sun, 23 Jan 2005 09:40:56 -0500
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, andyliu <liudeyan@gmail.com>
References: <20041122005411.GA19363@elte.hu> <aad1205e05012301271de3e365@mail.gmail.com> <20050123113111.GA11965@elte.hu>
In-Reply-To: <20050123113111.GA11965@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501230940.56420.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.47.137] at Sun, 23 Jan 2005 08:40:57 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 January 2005 06:31, Ingo Molnar wrote:
>* andyliu <liudeyan@gmail.com> wrote:
>> hi , ingo
>>
>> i am trying to understand your patch,but the patch file is so long
>> and complex. i am wondering is there some documents about your
>> patch?
>>
>> :)
>
>well, it mainly offers the PREEMPT_RT feature, which is a 'no
>compromises' variant of kernel preemption: virtually everything
>(including normal spinlocked sections) is preemptable, with the goal
> of providing hard-realtime category ~10-20 usecs maximum scheduling
> latency guarantees on a typical PC (or embedded platform). Those
> long and complex changes are almost all needed to achieve this
> goal.
>
>this tree is mainly an experiment to see what it takes to achieve
> that latency goal, and to see how much of that can go upstream
> (without having to decide whether upstream wants to have the
> PREEMPT_RT feature or not). (A couple of dozen patches were already
> split out of this patch and are in the current upstream kernel -
> they already made a latency difference for the 2.6.10 kernel.)
>
> Ingo

Hijacking the thread here Ingo, but did you see my build failure 
message of yesterday?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.32% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
