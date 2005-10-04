Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbVJDSLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVJDSLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 14:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbVJDSLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 14:11:04 -0400
Received: from spirit.analogic.com ([204.178.40.4]:25605 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964895AbVJDSLC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 14:11:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.60.0510042001210.8210@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0510041924520.8210@kepler.fjfi.cvut.cz> <Pine.LNX.4.61.0510041329180.29678@chaos.analogic.com> <Pine.LNX.4.60.0510041945260.8210@kepler.fjfi.cvut.cz> <Pine.LNX.4.60.0510041957590.8210@kepler.fjfi.cvut.cz> <Pine.LNX.4.60.0510042001210.8210@kepler.fjfi.cvut.cz>
X-OriginalArrivalTime: 04 Oct 2005 18:11:00.0528 (UTC) FILETIME=[F9A96300:01C5C90E]
Content-class: urn:content-classes:message
Subject: Re: 2.4 in-kernel file opening
Date: Tue, 4 Oct 2005 14:11:00 -0400
Message-ID: <Pine.LNX.4.61.0510041408500.29815@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4 in-kernel file opening
Thread-Index: AcXJDvmwR47wB8E/RiiIKl8U/etwYg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Martin Drab" <drab@kepler.fjfi.cvut.cz>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Oct 2005, Martin Drab wrote:

> On Tue, 4 Oct 2005, Martin Drab wrote:
>
>> On Tue, 4 Oct 2005, Martin Drab wrote:
>> ...
>>> things within the driver before the mmap() - I guess that should be
>>> possibble to do from within the fops->mmap(), but I also need to do
>>> something upon munmap()ping. Where should I place that? There doesn't seem
>>> to be any function that would be called upon user munmap(). :(
>>
>> Should this be placed at vmops->close()?
>
> Or does there have to be a separate ioctl call for that after the munmap()
> anyway?
>
> Martin

Just grin and bear it. Do the right things at the right time. If you
need ioctl() just do it. It will save you loads of development and
debugging time. Further, somebody else will be able to maintain the
code when you get promoted.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
