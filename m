Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVHWLSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVHWLSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 07:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVHWLS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 07:18:29 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:65288 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932129AbVHWLS2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 07:18:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4309E07F.8010304@shaw.ca>
References: <4D8eT-4rg-31@gated-at.bofh.it> <4306A176.3090907@shaw.ca> <4306AF26.3030106@yahoo.com.au> <4307788E.1040209@symas.com> <4307D320.90902@shaw.ca> <Pine.LNX.4.61.0508220735370.18402@chaos.analogic.com> <4309E07F.8010304@shaw.ca>
X-OriginalArrivalTime: 23 Aug 2005 11:18:21.0836 (UTC) FILETIME=[5EFB4CC0:01C5A7D4]
Content-class: urn:content-classes:message
Subject: Re: sched_yield() makes OpenLDAP slow
Date: Tue, 23 Aug 2005 07:17:51 -0400
Message-ID: <Pine.LNX.4.61.0508230714180.22122@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sched_yield() makes OpenLDAP slow
Thread-Index: AcWn1F8c5IF9U6T5RlKddPJiI3xzmA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Aug 2005, Robert Hancock wrote:

> linux-os (Dick Johnson) wrote:
>> I reported thet sched_yield() wasn't working (at least as expected)
>> back in March of 2004.
>>
>>  		for(;;)
>>                      sched_yield();
>>
>> ... takes 100% CPU time as reported by `top`. It should take
>> practically 0. Somebody said that this was because `top` was
>> broken, others said that it was because I didn't know how to
>> code. Nevertheless, the problem was not fixed, even after
>> schedular changes were made for the current version.
>
> This is what I would expect if run on an otherwise idle machine.
> sched_yield just puts you at the back of the line for runnable
> processes, it doesn't magically cause you to go to sleep somehow.
>

When a kernel build is occurring??? Plus `top` itself.... It damn
well sleep while giving up the CPU. If it doesn't it's broken.

> --
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
>


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
