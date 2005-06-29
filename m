Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVF2UmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVF2UmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVF2UmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:42:04 -0400
Received: from smtp-1.llnl.gov ([128.115.250.81]:58361 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id S262629AbVF2Ul6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:41:58 -0400
Date: Wed, 29 Jun 2005 13:41:57 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
Subject: Re: Realtime Preemption - 2.6.12-final-RT-V0.7.50-35
In-reply-to: <20050629192916.GA6079@elte.hu>
To: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.63.0506291333420.22748@ghostwheel.llnl.gov>
Organization: Lawrence Livermore National Laboratory
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Pine/4.62 (X11; U; Linux i686; en-US; rv:2.6.11-rc2-mm1)
References: <Pine.LNX.4.63.0506291005390.4929@ghostwheel.llnl.gov>
 <20050629192916.GA6079@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005, Ingo Molnar wrote:

>
> * Chuck Harding <charding@llnl.gov> wrote:
>
>> still having sox hang with no messages about what is going on. I have
>> CONFIG_DEBUG_PREEMPT enabled. It did work without hanging for about 50
>> times of playing a sound file, so the problem seems to take a bit of
>> time to develop. What other info would you need to figure this out?
>
> could you chrt the sound IRQ thread to SCHED_OTHER (audio performance
> will suck, but it will be more debuggable) - when the lockup happens, do
> you see the IRQ thread looping? Do you have SOFTLOCKUP_DETECT turned on
> too?
>
> 	Ingo

Did that, the IRQ thread is not looping, it doesn't seem to be using any
CPU at all. And I do have SOFTLOCKUP_DETECT on.

(PS, I am subbed to the list so please, no need to CC me. Thanks)

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate         ICCD            Fax: 925-423-6961
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
------------------ http://tinyurl.com/5w5ey -----------------------
-- Oxymoron: Weather Forecast. --
