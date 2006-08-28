Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWH1Ouv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWH1Ouv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWH1Ouv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:50:51 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:8 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750882AbWH1Ouu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:50:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 28 Aug 2006 14:50:46.0485 (UTC) FILETIME=[5839E850:01C6CAB1]
Content-class: urn:content-classes:message
Subject: Re: Serial custom speed deprecated?
Date: Mon, 28 Aug 2006 10:50:45 -0400
Message-ID: <Pine.LNX.4.61.0608281047360.388@chaos.analogic.com>
In-Reply-To: <1156775994.6271.28.camel@localhost.localdomain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Serial custom speed deprecated?
Thread-Index: AcbKsVhggsH+ieTESj2TIblolUIp5w==
References: <20060826181639.6545.qmail@science.horizon.com> <Pine.LNX.4.61.0608280817030.32531@chaos.analogic.com> <1156775994.6271.28.camel@localhost.localdomain>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux@horizon.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Aug 2006, Alan Cox wrote:

> Ar Llu, 2006-08-28 am 08:17 -0400, ysgrifennodd linux-os (Dick Johnson):
>> On Sat, 26 Aug 2006 linux@horizon.com wrote:
>>
>>>> Or we could just add a standardised extra set of speed ioctls, but then
>>>> we need to decide what occurs if I set the speed and then issue a
>>>> termios call - does it override or not.
>>>
>>> Actually, we're not QUITE out of bits.  CBAUDEX | B0 is not taken.
>>
>> B0 is not a bit (there are no bits in 0). It won't work.
>
> Well that is how it is implemented and everyone else seems happy. If it
> violates your personal laws of physics you'll just have to cope.

It has nothing to do with 'personal laws of physics'. On all recent
implementations, B0 is 0, i.e., the absence of any bits set. Therefore,
there is no observable difference between CBAUDEX and CBAUDEX | B0,
as shown above. Therefore, as I stated, it won't work.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
