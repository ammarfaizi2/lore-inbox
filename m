Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbUKDMxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbUKDMxQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbUKDMxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 07:53:16 -0500
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:26508 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262191AbUKDMxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 07:53:12 -0500
Message-ID: <418A2638.1080909@blueyonder.co.uk>
Date: Thu, 04 Nov 2004 12:53:12 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.8 (X11/20040914)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
References: <4189108C.2050804@blueyonder.co.uk> <41892899.6080400@cybsft.com> <41897119.6030607@blueyonder.co.uk> <418988A6.4090902@cybsft.com> <20041104100634.GA29785@elte.hu>
In-Reply-To: <20041104100634.GA29785@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Nov 2004 12:53:39.0140 (UTC) FILETIME=[4E23A840:01C4C26D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>>include/asm/vsyscall.h:48: error: previous declaration of `__xtime_lock'
>>
>>Does the patch below fix the above error?
> 
> 
> i applied your earlier patch but many more changes were needed to port
> PREEMPT_REALTIME (and in particular, PREEMPT_HARDIRQS) to x64. You can
> check out the x64 bits in -V0.7.8 which can be downloaded from the usual
> place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> Sid, does this one build/work for you? (i had to disable CPUFREQ in the
> .config to get it to build - an -mm bug i suspect.)
> 
> 	Ingo
> 
> 
> 
I shall be applying this latest and the other patch that followed later 
today.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====
