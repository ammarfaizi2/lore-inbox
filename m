Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWCVC1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWCVC1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 21:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWCVC1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 21:27:18 -0500
Received: from mxsf01.cluster1.charter.net ([209.225.28.201]:9380 "EHLO
	mxsf01.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750791AbWCVC1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 21:27:18 -0500
X-IronPort-AV: i="4.03,116,1141621200"; 
   d="scan'208"; a="917917492:sNHT58316154"
Message-ID: <4420B5F0.6000201@cybsft.com>
Date: Tue, 21 Mar 2006 20:26:56 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt1
References: <20060320085137.GA29554@elte.hu> <441F8017.4040302@cybsft.com> <20060321211653.GA3090@elte.hu>
In-Reply-To: <20060321211653.GA3090@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
>> I haven't had a chance to look into it yet but this combination brings 
>> with it a significant latency regression, at least as measured by the 
>> rtc histogram stuff.
> 
> can you also measure it via rtc_wakeup, a'ka:
> 
>  chrt -f -p 98 `pidof 'IRQ 8'`
>  ./rtc_wakeup -f 8192 -t 100000
> 
> ? I have just tried it, and -rt4 looks pretty good on the latency front 
> (with all debugging disabled).
> 
> 	Ingo
> 
Sorry I have been onsite and completely buried today. Am running an
initial test on both UP and SMP now with 2.6.16-rt1. UP doesn't look bad
at all. SMP on the other hand doesn't look so good. I will give -rt4 a
spin when these are done.

-- 
   kr
