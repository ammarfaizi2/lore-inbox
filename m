Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVLHQYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVLHQYg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVLHQYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:24:36 -0500
Received: from spirit.analogic.com ([204.178.40.4]:38671 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932201AbVLHQYf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:24:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1134058481.2867.85.camel@laptopd505.fenrus.org>
X-OriginalArrivalTime: 08 Dec 2005 16:24:34.0759 (UTC) FILETIME=[E04C1D70:01C5FC13]
Content-class: urn:content-classes:message
Subject: Re: How to enable/disable security features on mmap() ?
Date: Thu, 8 Dec 2005 11:24:34 -0500
Message-ID: <Pine.LNX.4.61.0512081118170.14156@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to enable/disable security features on mmap() ?
Thread-Index: AcX8E+BTN95Ox1hOTfa1KOo2skldGA==
References: <43983EBE.2080604@labri.fr> <1134051272.2867.63.camel@laptopd505.fenrus.org> <43984154.5050502@labri.fr>  <43984595.1090406@labri.fr> <1134053349.2867.65.camel@laptopd505.fenrus.org> <4398493E.50508@labri.fr> <Pine.LNX.4.61.0512081011020.32448@chaos.analogic.com> <1134056272.2867.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0512081051250.13997@chaos.analogic.com> <1134058481.2867.85.camel@laptopd505.fenrus.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: "Emmanuel Fleury" <emmanuel.fleury@labri.fr>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Dec 2005, Arjan van de Ven wrote:

>
>> 0xbfbb6d74	Stack
>> 0xb7e97008	Heap
>> 0x080495e8	_end[]
>>
>
> there is still a HUGE gap there....
>
Only because the test program didn't have any global data!
You can add the size of any global data to that offset and
watch them converge. We have medical imaging programs with
great gobs of global data.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
