Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVGGXVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVGGXVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 19:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbVGGXVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 19:21:40 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:26675 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262316AbVGGXVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 19:21:39 -0400
Message-ID: <49943.192.168.1.5.1120778373.squirrel@www.rncbc.org>
In-Reply-To: <20050707194914.GA1161@elte.hu>
References: <1119299227.20873.113.camel@cmn37.stanford.edu>
    <20050621105954.GA18765@elte.hu>
    <1119370868.26957.9.camel@cmn37.stanford.edu>
    <20050621164622.GA30225@elte.hu>
    <1119375988.28018.44.camel@cmn37.stanford.edu>
    <1120256404.22902.46.camel@cmn37.stanford.edu>
    <20050703133738.GB14260@elte.hu>
    <1120428465.21398.2.camel@cmn37.stanford.edu>
    <24833.195.245.190.94.1120761991.squirrel@www.rncbc.org>
    <20050707194914.GA1161@elte.hu>
Date: Fri, 8 Jul 2005 00:19:33 +0100 (WEST)
Subject: Re: realtime-preempt-2.6.12-final-V0.7.51-11 glitches
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 07 Jul 2005 23:21:37.0945 (UTC) FILETIME=[9FA9C890:01C5834A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
>
>> Hi all,
>>
>> These are one of my latest consolidated results while using (my)
>> jack_test4.2 suite, against a couple of 2.6.12 kernels patched for
>> PREEMPT_RT, on my P4@2.5GHz/UP laptop.
>>
>> See anything funny?
>
> hm, you dont seem to have PREEMPT_RT enabled in your .config - it's set
> to PREEMPT_DESKTOP (config-2.6.12-RT-V0.7.51-11.0). OTOH, your 49-01
> config has PREEMPT_RT enabled. So it's not an apples to apples
> comparison. Just to make sure, could you check 51-11 with PREEMPT_RT
> enabled too?
>

Damn. You're right... grrr! I gotta spank myself later... I've been
running PREEMPT_DESKTOP all along since V0.7.5x . Anyway, all that seems
to show some pretty figures on the distinction between PREEMPT_DESKTOP and
PREEMPT_RT performance :)

> i have just done a jack_test4.1 run, and indeed larger latencies seem to
> have crept in. (But i forgot to chrt the sound IRQ above the network
> IRQ, so i'll retest.)
>

I will do my homework too ;)
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

