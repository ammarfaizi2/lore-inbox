Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbWHOSHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbWHOSHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWHOSHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:07:30 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:39172 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030430AbWHOSHW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:07:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 15 Aug 2006 18:07:20.0681 (UTC) FILETIME=[A6BEA590:01C6C095]
Content-class: urn:content-classes:message
Subject: Re: How to find a sick router with 2.6.17+ and tcp_window_scaling enabled
Date: Tue, 15 Aug 2006 14:07:20 -0400
Message-ID: <Pine.LNX.4.61.0608151404220.29941@chaos.analogic.com>
In-Reply-To: <44E208AC.2050906@everytruckjob.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to find a sick router with 2.6.17+ and tcp_window_scaling enabled
thread-index: AcbAlabFllpjEcAPSN6E+Jnk33OmGQ==
References: <44E1F0CD.7000003@everytruckjob.com> <1155661308.24077.297.camel@localhost.localdomain> <20060815173046.GA2034@linuxace.com> <44E208AC.2050906@everytruckjob.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Mark Reidenbach" <m.reidenbach@everytruckjob.com>
Cc: "Phil Oester" <kernel@linuxace.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Aug 2006, Mark Reidenbach wrote:

> Phil Oester wrote:
>> On Tue, Aug 15, 2006 at 06:01:47PM +0100, Alan Cox wrote:
>>
>>> Ar Maw, 2006-08-15 am 11:05 -0500, ysgrifennodd Mark Reidenbach:
>>>
>>>> Does anyone have a way to find the broken router if you are not running
>>>> the networks involved?
>>>>
>>> You are almost certainly looking for a broken/crap NAT box, firewall or
>>> similar product. Routers that are just being routers don't touch the TCP
>>> layer so even if they are broken/crap/ancient they won't do any harm to
>>> it.
>>>
>>> The usual offenders are cheap NAT boxes and badly designed load
>>> balancers. They may not even show up in a trace but you should expect
>>> them to be at one end or the other, unless your ISP is providing you
>>> with NATted addresses or some kind of managed security service.
>>>
>>
>> Certain versions of BSD ipfilter are also broken.  Try some of Apple's
>> websites for examples.
>>
>> Is the destination box BSD or behind a BSD firewall?
>>
>> Phil
>>
> I'm not sure what OS the T1 provider's box is running.  I experience the
> same problems trying to access kernel.org or one of my servers hosted at
> Verio in Sterling, VA.
>
> Alan Cox says it's most likely a broken NAT box or firewall.  I'm not
> aware of any firewalls in between my office and my servers in Sterling
> other than the Cisco 1811 here in the office, and it is performing NAT
> and firewall services for our office.  I'm going to try a few cheapo
> home routers and see if the problem remains.  I would think the Cisco
> router would be better off than a home Linksys or Xincom one, but I
> figure it's at least worth a try.
>
> Thanks for your help.
>
> Mark Reidenbach
> EveryTruckJob.com
> M.Reidenbach@EveryTruckJob.com
> Phone: (205)722-9112

Some older Ciscos need to be upgraded to handle the ECN bit. If
your router is a couple years old and has not been upgraded, this
might be the problem. A few years ago, vger started running a
new kernel that used ECN. The result was chaos for a few weeks.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
