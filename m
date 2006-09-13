Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWIMOAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWIMOAT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 10:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWIMOAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 10:00:18 -0400
Received: from mail.everytruckjob.com ([198.87.235.158]:23976 "EHLO
	mail.everytruckjob.com") by vger.kernel.org with ESMTP
	id S1750781AbWIMOAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 10:00:16 -0400
Message-ID: <45080EE2.8030602@everytruckjob.com>
Date: Wed, 13 Sep 2006 09:00:02 -0500
From: Mark Reidenbach <m.reidenbach@everytruckjob.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: How to find a sick router with 2.6.17+ and tcp_window_scaling
 enabled
References: <44E1F0CD.7000003@everytruckjob.com> <20060815180634.GB15957@s2.yuriev.com> <20060815181938.GK8776@1wt.eu> <44E2263D.4010909@everytruckjob.com> <20060815202029.GM8776@1wt.eu>
In-Reply-To: <20060815202029.GM8776@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Tue, Aug 15, 2006 at 02:53:33PM -0500, Mark Reidenbach wrote:
>   
>> Willy Tarreau wrote:
>>     
>>> He may very well have an IOS based 1600 or equivalent doing a very dirty 
>>> NAT.
>>>
>>> Willy
>>>
>>>  
>>>       
>> Willy, I am in fact running an IOS based NAT/firewall on a 1811.   It's 
>> IOS version 12.3(8)YI1.  Do you know if this version has a "very dirty 
>> NAT" implementation?   If you don't, I think I'll just try a few spare 
>> home routers and see if their NAT implementation is cleaner than my Cisco's.
>>     
>
> I have absolutely no idea. If they borrowed the session tracking code from
> the PIX, you might have window tracking inside it, which might cause what
> you observe if it's buggy. But that's just supposition from me.
>
>   
>> Mark Reidenbach
>> EveryTruckJob.com
>> M.Reidenbach@EveryTruckJob.com
>> Phone: (205)722-9112
>>     
>
> Regards,
> willy
>
>   

I'm just posting this as a follow-up in case anyone runs across the same 
problem I experienced and couldn't find a solution.  My problem was the 
old Cisco IOS [Version 12.3(8)YI1] that came installed on my Cisco 1811 
router I purchased in March 2006.   I believe this is still the default 
shipping version for this router, so anyone who buys one really needs to 
get a Cisco support contract for it from a Cisco reseller so they can 
download a new/working IOS [Version 12.4(9)T1 was the most recent as of 
this email and was the one I used]. 
Mark Reidenbach
EveryTruckJob.com
M.Reidenbach@EveryTruckJob.com
Phone: (205)722-9112


