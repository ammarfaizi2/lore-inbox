Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVHHT1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVHHT1z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 15:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVHHT1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 15:27:55 -0400
Received: from spirit.analogic.com ([208.224.221.4]:30737 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932208AbVHHT1y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 15:27:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <005501c59c4a$f6210800$a20cc60a@amer.sykes.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
References: <005501c59c4a$f6210800$a20cc60a@amer.sykes.com>
X-OriginalArrivalTime: 08 Aug 2005 19:27:53.0849 (UTC) FILETIME=[45DE8E90:01C59C4F]
Content-class: urn:content-classes:message
Subject: RE: Wireless support
Date: Mon, 8 Aug 2005 15:27:01 -0400
Message-ID: <Pine.LNX.4.61.0508081514160.21163@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Wireless support
thread-index: AcWcT0Xlb+zmCM+JSRaccdgYuThDuQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Alejandro Bonilla" <abonilla@linuxwireless.org>
Cc: "Lee Revell" <rlrevell@joe-job.com>, "Andreas Steinmetz" <ast@domdv.de>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Denis Vlasenko" <vda@ilport.com.ua>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Aug 2005, Alejandro Bonilla wrote:

>>>> Any idea how much hardware is out there that needs
>> ndiswrapper to work?
>>>
>>> No real idea but an educated guess: too much...
>>>
>>
>> I like the idea of blacklisting anything with a native driver (even a
>> partially working one), but leaving alone the stuff that is completely
>> unsupported.
>>
>> Lee
>
> 	The Point is!!! We like more Open Source, I use open Source hardware, I use
> hardware that works in Linux, I use hardware were the manufacturer cares
> about Linux. And people that use ndiswrapper is because the manufacturer
> does not care about Linux.
>
> 	I wouldn't even buy hardware from people that think they don't need to make
> Drivers or release info for Linux because most of his customers are using
> Windows.
>
> Again, the point is that ndiswrapper is a great project, but people uses it
> for the leftovers! We *shouldn't* buy leftovers or from Manuf that don't
> care about Linux.
>
> .Alejandro

But for many, the emphasis is upon functionality. I should be able
to go to a "computer store" and pick up a WIFI device, plug it
in, and install the driver that comes with it. It may not
be the "optimum" solution, but it should work. You see, "Open
Source" is about politics (not meant to be a bad word), we need
to have stuff work first, then we can deal with politics. The
NDIS stuff is an excellent way to beat M$ with their own whip.
Also, the interface to the OS, with a proper NDIS Wrapper, can
protect against common coding problems like buffer-overwrites
and trashing memory. The only compatibility problems I see is
that NDIS code can do bad things in interrupts (like spin).
You can test for these compatibility issues and make a learned
cost v.s. performance trade-off. Right now, you can't test
what you don't have.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
