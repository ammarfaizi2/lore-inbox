Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752046AbWG1RGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbWG1RGT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbWG1RGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:06:18 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:63753 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1752046AbWG1RGS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:06:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 28 Jul 2006 17:06:13.0447 (UTC) FILETIME=[2177A570:01C6B268]
Content-class: urn:content-classes:message
Subject: Re: Driver timeout
Date: Fri, 28 Jul 2006 13:06:13 -0400
Message-ID: <Pine.LNX.4.61.0607281304580.5357@chaos.analogic.com>
In-Reply-To: <1154105732.13509.157.camel@localhost.localdomain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Driver timeout
Thread-Index: AcayaCGWyFJpfRlBQdCfdKplo1XT/A==
References: <Pine.LNX.4.61.0607281152030.5161@chaos.analogic.com> <1154105732.13509.157.camel@localhost.localdomain>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>,
       "Larson, Greg" <GLarson@analogic.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Jul 2006, Alan Cox wrote:

> Ar Gwe, 2006-07-28 am 11:54 -0400, ysgrifennodd linux-os (Dick Johnson):
>>
>> Hello list,
>> What is the correct error code for a driver to return if
>> the requested operation timed out?
>
> If the operation is blocking then
> 	ETIMEDOUT - if a timeout occurred
>
> possibly also
> 	ETIME	  - if a timer of some kind expired
>
> If you know why it timed out you may want to return that instead to
> provide more information (eg the net code returns things like 'Host
> down')
>

Okay, thanks. We are trying to standardize everything here.

Also, thanks to the others who answered.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
