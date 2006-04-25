Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWDYRyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWDYRyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWDYRyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:54:54 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:35336 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750747AbWDYRyy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:54:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <444E5A3E.1020302@argo.co.il>
X-OriginalArrivalTime: 25 Apr 2006 17:54:39.0374 (UTC) FILETIME=[52B46AE0:01C66891]
Content-class: urn:content-classes:message
Subject: Re: Compiling C++ modules
Date: Tue, 25 Apr 2006 13:54:38 -0400
Message-ID: <Pine.LNX.4.61.0604251347120.29056@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compiling C++ modules
thread-index: AcZokVK7GaU2hxoCRsqYWBCZrRVbEw==
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>  <1145911546.1635.54.camel@localhost.localdomain>  <444D3D32.1010104@argo.co.il>  <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com>  <444DCAD2.4050906@argo.co.il>  <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com>  <444E524A.10906@argo.co.il> <d120d5000604251010kd56580fl37a0d244da1eaf45@mail.gmail.com> <444E5A3E.1020302@argo.co.il>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Avi Kivity" <avi@argo.co.il>
Cc: <dtor_core@ameritech.net>, "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Apr 2006, Avi Kivity wrote:

> Dmitry Torokhov wrote:
>>>>     TakeLock l(&lock);
>>>>
>>>>     do_something();
>>>>     do_something_else();
>>>>
>>>> First of all, that extra TakeLock object chews up stack, at least 4 or
>>>> 8 bytes of it, depending on your word size.
>>>>
>>> No, it's optimized out. gcc notices that &lock doesn't change and that
>>> 'l' never escapes the function.
>>>
>>
>> "l" that propects critical section gets thrown away???
> Calm down, the storage for 'l' is thrown away, but its effects remain.
>> What is the
>> name of the filesystem you ported? I mean, I need to know so I don't
>> use it by accident.
>>
> It's very expensive, you can't use it by accident.

Class Kernel
{
public:
     virtual void starter(Scheduler *current) = 0x00;
};

Okay, I just started your new C++ kernel! Please send email when it
is done. I will help test it.

> --
> Do not meddle in the internals of kernels, for they are subtle and quick to panic.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
