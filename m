Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbUCTEaS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 23:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbUCTEaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 23:30:17 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:23726 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263232AbUCTEaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 23:30:06 -0500
Message-ID: <405BC812.8070507@cyberone.com.au>
Date: Sat, 20 Mar 2004 15:26:58 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, markw@osdl.org, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
References: <20040314172809.31bd72f7.akpm@osdl.org>	<200403181737.i2IHbCE09261@mail.osdl.org>	<20040318100615.7f2943ea.akpm@osdl.org>	<20040318192707.GV22234@suse.de>	<20040318191530.34e04cb2.akpm@osdl.org>	<20040318194150.4de65049.akpm@osdl.org>	<20040319183906.I8594@osdlab.pdx.osdl.net>	<20040319185026.56db3bf7.akpm@osdl.org>	<20040319185345.A4610@osdlab.pdx.osdl.net>	<405BC003.6080507@cyberone.com.au> <20040319201450.5da6847a.akpm@osdl.org> <405BC760.9090107@cyberone.com.au>
In-Reply-To: <405BC760.9090107@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
>
> Andrew Morton wrote:
>
>> Nick Piggin <piggin@cyberone.com.au> wrote:
>>
>>>
>>> The oprofile for the 01 kernel says
>>> CPU: P4 / Xeon, speed 1497.76 MHz (estimated)
>>> while the 02 kernel says
>>> CPU: P4 / Xeon with 2 hyper-threads, speed 1497.57 MHz (estimated)
>>> What's going on there?
>>>
>>
>> Does the sched-domains patch break `acpi=off' or `noht'?
>>
>>
>
> Shouldnt.
>

sched-sibling-map-to-cpumask.patch may. Sorry I don't have time to
check it right now. Got to go.

