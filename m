Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946213AbWKJJcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946213AbWKJJcH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946209AbWKJJcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:32:07 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:28770 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1946213AbWKJJcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:32:04 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CABLUU0VZmGJA/2dsb2JhbAA
X-IronPort-AV: i="4.09,408,1157324400"; 
   d="scan'208"; a="138398945:sNHT17779311"
Message-ID: <26540.194.65.103.1.1163151084.squirrel@www.rncbc.org>
In-Reply-To: <1162808795.23683.2.camel@Homer.simpson.net>
References: <454BC8D1.1020001@rncbc.org> <454BF608.20803@rncbc.org> 
    <454C714B.8030403@rncbc.org> <454E0976.8030303@rncbc.org> 
    <454E15B0.2050008@rncbc.org> 
    <1162742535.2750.23.camel@localhost.localdomain> 
    <454E2FC1.4040700@rncbc.org>
    <1162797896.6126.5.camel@Homer.simpson.net> 
    <20061106093815.GB14388@elte.hu> 
    <1162807371.13579.4.camel@Homer.simpson.net> 
    <20061106101117.GA20616@elte.hu>
    <1162808795.23683.2.camel@Homer.simpson.net>
Date: Fri, 10 Nov 2006 09:31:24 -0000 (WET)
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Mike Galbraith" <efault@gmx.de>, "Daniel Walker" <dwalker@mvista.com>,
       "Karsten Wiese" <fzu@wemgehoertderstaat.de>,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 10 Nov 2006 09:32:02.0166 (UTC) FILETIME=[13CFE960:01C704AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, November 6, 2006 10:26, Mike Galbraith wrote:
> On Mon, 2006-11-06 at 11:11 +0100, Ingo Molnar wrote:
>
>> * Mike Galbraith <efault@gmx.de> wrote:
>>
>>
>>>> could you try the patch below, does it help? (a quick review seems
>>>> to suggest that all codepaths protected by kretprobe_lock are
>>>> atomic)
>>>
>>> Ah, so I did do the right thing.  Besides the oops, I was getting a
>>> pretty frequent non-deadly...
>>
>> yeah ...
>>
>>> ...so turned it back into a non-sleeping lock.
>>>
>>>
>>> You forgot kprobes.h
>>>
>>
>> so the patch solves this problem for you?
>
> Yeah, seems to.  I'll let it run make check in a loop for a while to
> make sure the fatal oops stays gone too though.  If you don't hear from
> me, all is peachy (it will be methinks)
>

So far so good for this pester ;)

Thanks.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
