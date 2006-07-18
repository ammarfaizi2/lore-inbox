Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWGRNdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWGRNdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWGRNdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:33:22 -0400
Received: from spirit.analogic.com ([204.178.40.4]:51717 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932200AbWGRNdV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:33:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 18 Jul 2006 13:33:19.0520 (UTC) FILETIME=[BB7B9200:01C6AA6E]
Content-class: urn:content-classes:message
Subject: Re: [patch 5/6] s390: .align 4096 statements in head.S
Date: Tue, 18 Jul 2006 09:33:19 -0400
Message-ID: <Pine.LNX.4.61.0607180929340.12146@chaos.analogic.com>
In-Reply-To: <1153227104.9681.2.camel@localhost>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 5/6] s390: .align 4096 statements in head.S
Thread-Index: AcaqbruhTKp87p3+T/mQJpqha9ERew==
References: <20060718115622.GE20884@skybase> <Pine.LNX.4.61.0607180825240.11870@chaos.analogic.com> <1153227104.9681.2.camel@localhost>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <heiko.carstens@de.ibm.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Jul 2006, Martin Schwidefsky wrote:

> On Tue, 2006-07-18 at 08:43 -0400, linux-os (Dick Johnson) wrote:
>> Hardcoading like that can cause hard to find errors. It looks like
>> you wrote something in 'C' and tried to use its assembly code. You
>> should know that you don't need ".fill" if you have correctly
>> allocated
>> data.
>
> Huh ?!? We are talking about head.S here. That is pure assembler, no C
> anywhere. It is the startup code of the kernel, and we do want to
> control where things end up.
>
> --
> blue skies,
>  Martin.
>
> Martin Schwidefsky
> Linux for zSeries Development & Services
> IBM Deutschland Entwicklung GmbH

Yes, I know exactly what I am saying and I mentioned the reference
to 'C' because the ".Labels" start with ".L" as 'C' does it. Humans
generally use human-readable names.

If you BOTHERED to read the rest of the email, I instructed one
how to use the assembler 'gas' so I certainly know that it is not
'C'. Thank you.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.63 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
