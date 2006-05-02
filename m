Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWEBLmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWEBLmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 07:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWEBLmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 07:42:00 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:47883 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964784AbWEBLl7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 07:41:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <445741F5.6060204@argo.co.il>
X-OriginalArrivalTime: 02 May 2006 11:40:31.0378 (UTC) FILETIME=[378C4F20:01C66DDD]
Content-class: urn:content-classes:message
Subject: Re: Compiling C++ modules
Date: Tue, 2 May 2006 07:40:21 -0400
Message-ID: <Pine.LNX.4.61.0605020732410.23949@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compiling C++ modules
thread-index: AcZt3TeT/FSyN07eQ0+t+AsfI8TQAQ==
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <mj+md-20060502.111446.9373.atrey@ucw.cz> <445741F5.6060204@argo.co.il>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Avi Kivity" <avi@argo.co.il>
Cc: "Martin Mares" <mj@ucw.cz>, "Willy Tarreau" <willy@w.ods.org>,
       "David Schwartz" <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 May 2006, Avi Kivity wrote:

> Martin Mares wrote:
>> Hello!
>>
>>
>>> Perhaps people who developed kernel-level code in _both_ C and C++ would
>>> be qualified to speculate on that (I have, but apparently I don't have a
>>> clue).
>>>
>>
>> Well, what about just showing an example of kernel code in C++, which
>> you consider nice?
>>
>
> I don't have access to that code (which was closed source anyway).
>
> But it executed C++ code within a few cycles of entering the reset
> vector (no standard BIOS), including but not limited to: programming the
> memory controller (430MX chipset), servicing interrupts, hardware
> accelerated 2D graphics (C&T 65550), IDE driver, simple filesystem,
> simple windowing GUI, network driver (Tulip) etc.
>

Oh wow! I'm impressed. You, know back in the '50s we did something
like that. It was a dynamic abacus for fast math. Since it's
proprietary, I can't disclose its exact nature. It's even used
by the CIA.

> More recently I participated in writing a filesystem in C++. That's in
> userspace, but many of the techniques used in writing kernel code are
> necessary there (extreme robustness, can't assume infinite memory,
> locking, etc.)

Sure, kernel code is probably written using symbols, too. It's a
lot like user-space as well.

>
> There are C++ embedded kernels in http://www.zipworld.com.au/~akpm/ and
> http://ecos.sourceware.org/, but I haven't looked at them, so I can't
> say whether I consider them nice or not.
>

While you are at it, look at:

http://www.google.com/search?hl=en&q=bullshit

> --
> error compiling committee.c: too many arguments to function
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
