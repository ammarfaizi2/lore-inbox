Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWHCTtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWHCTtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 15:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWHCTtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 15:49:00 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:46085 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932501AbWHCTs7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 15:48:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 03 Aug 2006 19:48:49.0138 (UTC) FILETIME=[D6CA7520:01C6B735]
Content-class: urn:content-classes:message
Subject: Re: A proposal - binary
Date: Thu, 3 Aug 2006 15:48:48 -0400
Message-ID: <Pine.LNX.4.61.0608031532040.5638@chaos.analogic.com>
In-Reply-To: <44D23B84.6090605@vmware.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: A proposal - binary
Thread-Index: Aca3NdbU/cnFM/GER7WU2wPOfYwEtA==
References: <44D1CC7D.4010600@vmware.com> <1154603822.2965.18.camel@laptopd505.fenrus.org> <44D23B84.6090605@vmware.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Zachary Amsden" <zach@vmware.com>
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>, <greg@kroah.com>,
       "Andrew Morton" <akpm@osdl.org>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Rusty Russell" <rusty@rustcorp.com.au>, "Jack Lo" <jlo@vmware.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Aug 2006, Zachary Amsden wrote:

> Arjan van de Ven wrote:
>> Hi,
>>
>> you use a lot of words for saying something self contradictory. It's
>> very simple; based on your mail, there's no reason the VMI gateway page
>> can't be (also) GPL licensed (you're more than free obviously to dual,
>> tripple or quadruple license it). Once your gateway thing is gpl
>> licensed, your entire proposal is moot in the sense that there is no
>> issue on the license front. See: it can be very easy. Much easier than
>> trying to get a license exception (which is very unlikely you'll get)...
>>
>>
>> Now you can argue for hours about if such an interface is desirable or
>> not, but I didn't think your email was about that.
>>
>
> Arjan, thank you for reading my prolific manifesto.  I am not arguing
> for the interface being desirable, and I don't think I'm being self
> contradictory.  There was some confusion over technical details of the
> VMI gateway page that I wanted to make explicit.  Hopefully I have fully
> explained those.  I'm not trying to get a license exemption, I'm trying
> to come up with a model that current and future hardware vendors can
> follow when faced with the same set of circumstances.
>
> It was not 100% clear based on conversations at OLS that open-sourcing
> the VMI layer met the letter and intent of the kernel license model.
> There were some arguments that not having the source integrated into the
> kernel violated the spirit of the GPL by not allowing one to distribute
> a fully working kernel.  I wanted to show that is not true, and the
> situation is actually quite unique.  Perhaps we can use this to
> encourage open sourced firmware layers, instead of trying to ban drivers
> which rely on firmware from the kernel.
>
> Zach

Inside the kernel there is no protection whatsoever. Whatever executes
inside the kernel, or within the kernel's 'lack-of-protection' ring,
commonly called ring 0, needs to be viewable to anybody who might
be chasing kernel malfunctions. Otherwise, one doesn't know if the
problem is a kernel bug or some accident within a binary blob.

The bottom line is that these problems have nothing to do with
licensing at all. It's not a GPL issue. It's a troubleshooting
issue. There already exists a method of using proprietary modules.
You just don't report "bugs" if they are installed. It's really
just that simple. If you want to use some secret recipe that
can't be seen my kernel troubleshooters, just don't use them
in a kernel that is being debugged. It's really that simple.

Time-and-time-again, I've seen bug-reports with proprietary
video drivers installed. The respondent says; "Duplicate the
problem without that module installed." The result is usually
that the problem can't be duplicated, to wit: no kernel bug,
it's a proprietary driver bug.

Also, again-and-again, I read about some "new" thing that
requires hooks for some binary blob. They come in various
disguises. Certainly kernel developers are smart enough
to see the Trojan Horse just outside the gates. Give it up!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
