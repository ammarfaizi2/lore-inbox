Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVLHQaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVLHQaT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVLHQaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:30:19 -0500
Received: from spirit.analogic.com ([204.178.40.4]:59141 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932204AbVLHQaQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:30:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1134058917.2867.89.camel@laptopd505.fenrus.org>
X-OriginalArrivalTime: 08 Dec 2005 16:30:15.0685 (UTC) FILETIME=[AB814B50:01C5FC14]
Content-class: urn:content-classes:message
Subject: Re: How to enable/disable security features on mmap() ?
Date: Thu, 8 Dec 2005 11:30:15 -0500
Message-ID: <Pine.LNX.4.61.0512081126130.14184@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to enable/disable security features on mmap() ?
Thread-Index: AcX8FKuK7R0Un7VQT26QTqIFjB9spQ==
References: <43983EBE.2080604@labri.fr> <1134051272.2867.63.camel@laptopd505.fenrus.org> <43984154.5050502@labri.fr>  <43984595.1090406@labri.fr> <1134053349.2867.65.camel@laptopd505.fenrus.org> <4398493E.50508@labri.fr> <Pine.LNX.4.61.0512081011020.32448@chaos.analogic.com> <1134056272.2867.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0512081051250.13997@chaos.analogic.com> <1134058814.1615.176.camel@capoeira> <1134058917.2867.89.camel@laptopd505.fenrus.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: "Xavier Bestel" <xavier.bestel@free.fr>,
       "Emmanuel Fleury" <emmanuel.fleury@labri.fr>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Dec 2005, Arjan van de Ven wrote:

> On Thu, 2005-12-08 at 17:20 +0100, Xavier Bestel wrote:
>> If you only randomize by one or two bytes, the attacker just has to
>> retry once or twice to have his exploit work.
>
> in addition the stack pointer needs to be 16 byte aligned in the first
> place ;)
>

No. The stack-pointer is most efficient on ix86 machines if it is
aligned on an ESP-sized boundary (32 bits). Any DATA allocated on
the stack __should__ be aligned to take any data-type, i.e., 16 bytes
to accommodate floating-point variables.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
