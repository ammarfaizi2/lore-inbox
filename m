Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWDAAWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWDAAWy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 19:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWDAAWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 19:22:54 -0500
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:51304 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751452AbWDAAWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 19:22:53 -0500
Message-ID: <442DC7DB.10406@bigpond.net.au>
Date: Sat, 01 Apr 2006 11:22:51 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: ck@vds.kolivas.org, Thorsten Will <thor_w@arcor.de>,
       linux list <linux-kernel@vger.kernel.org>
Subject: Re: [ck] Re: Staircase test patch
References: <200603312307.58507.kernel@kolivas.org> <20060331213106.GA6905@lliwnetsroht.news.arcor.de> <200604010917.09413.kernel@kolivas.org>
In-Reply-To: <200604010917.09413.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 1 Apr 2006 00:22:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Saturday 01 April 2006 07:31, Thorsten Will wrote:
>> On Friday 31 March 2006 23:07 +1000, Con Kolivas wrote:
>>> Hi Thorsten et al
>> Hi, Con.
>>
>>> Thorsten could you please test to see if this fixes the problem for you?
>> Oh boy, oh boy, oh boy.
>>
>> Against a bash loop:
>> |# dd bs=1M count=2048 </dev/hdb >/dev/null
>> |2048+0 records in
>> |2048+0 records out
>> |2147483648 bytes transferred in 35.497603 seconds (60496582 bytes/sec)
>>
>> Yes! Success! And the crowd goes wild! :-)
>>
>> I think you finally nailed it. Thank you so much!
> 
> No, thank _you_ for bringing it to my attention and testing :)

Should I apply this to staircase in PlugSched?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
