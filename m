Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVHWLNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVHWLNt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 07:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVHWLNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 07:13:49 -0400
Received: from spirit.analogic.com ([208.224.221.4]:5638 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932127AbVHWLNs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 07:13:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050823094231.85102.qmail@web8508.mail.in.yahoo.com>
References: <20050823094231.85102.qmail@web8508.mail.in.yahoo.com>
X-OriginalArrivalTime: 23 Aug 2005 11:13:47.0164 (UTC) FILETIME=[BB43ADC0:01C5A7D3]
Content-class: urn:content-classes:message
Subject: Re: kernel module seg fault
Date: Tue, 23 Aug 2005 07:13:16 -0400
Message-ID: <Pine.LNX.4.61.0508230711490.22122@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel module seg fault
Thread-Index: AcWn07tp6Upl58PyQWW2W627KdgnkA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "manomugdha biswas" <manomugdhab@yahoo.co.in>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Aug 2005, manomugdha biswas wrote:

> Hi,
> I have written a kernel module and I can load (insmod)
> it without any error. But when i run my module it gets
> seg fault at interruptible_sleep_on_timeout();
>
> I have used this function in the following way:
>
> DECLARE_WAIT_QUEUE_HEAD(wq);
> init_waitqueue_head(&wq);
> interruptible_sleep_on_timeout(&wq, 2);
>
> I am using redhat version 9.0 and kernel version
> 2.4.20-8.
> Could you please give some light on this issue?
>
> Manomugdha Biswas

"seg fault"??  You meen you get a kernel panic? Please
show us what it says. Note you can't sleep with a spin-lock
held.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
