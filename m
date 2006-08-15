Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbWHORr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbWHORr2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWHORr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:47:28 -0400
Received: from mail.everytruckjob.com ([198.87.235.158]:45236 "EHLO
	mail.everytruckjob.com") by vger.kernel.org with ESMTP
	id S1030404AbWHORr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:47:27 -0400
Message-ID: <44E208AC.2050906@everytruckjob.com>
Date: Tue, 15 Aug 2006 12:47:24 -0500
From: Mark Reidenbach <m.reidenbach@everytruckjob.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Phil Oester <kernel@linuxace.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to find a sick router with 2.6.17+ and tcp_window_scaling
 enabled
References: <44E1F0CD.7000003@everytruckjob.com> <1155661308.24077.297.camel@localhost.localdomain> <20060815173046.GA2034@linuxace.com>
In-Reply-To: <20060815173046.GA2034@linuxace.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Oester wrote:
> On Tue, Aug 15, 2006 at 06:01:47PM +0100, Alan Cox wrote:
>   
>> Ar Maw, 2006-08-15 am 11:05 -0500, ysgrifennodd Mark Reidenbach:
>>     
>>> Does anyone have a way to find the broken router if you are not running 
>>> the networks involved?  
>>>       
>> You are almost certainly looking for a broken/crap NAT box, firewall or
>> similar product. Routers that are just being routers don't touch the TCP
>> layer so even if they are broken/crap/ancient they won't do any harm to
>> it.
>>
>> The usual offenders are cheap NAT boxes and badly designed load
>> balancers. They may not even show up in a trace but you should expect
>> them to be at one end or the other, unless your ISP is providing you
>> with NATted addresses or some kind of managed security service.
>>     
>
> Certain versions of BSD ipfilter are also broken.  Try some of Apple's
> websites for examples.  
>
> Is the destination box BSD or behind a BSD firewall?
>
> Phil
>   
I'm not sure what OS the T1 provider's box is running.  I experience the 
same problems trying to access kernel.org or one of my servers hosted at 
Verio in Sterling, VA.

Alan Cox says it's most likely a broken NAT box or firewall.  I'm not 
aware of any firewalls in between my office and my servers in Sterling 
other than the Cisco 1811 here in the office, and it is performing NAT 
and firewall services for our office.  I'm going to try a few cheapo 
home routers and see if the problem remains.  I would think the Cisco 
router would be better off than a home Linksys or Xincom one, but I 
figure it's at least worth a try.

Thanks for your help.

Mark Reidenbach
EveryTruckJob.com
M.Reidenbach@EveryTruckJob.com
Phone: (205)722-9112
