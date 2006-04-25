Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWDYNQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWDYNQG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 09:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWDYNQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 09:16:05 -0400
Received: from spirit.analogic.com ([204.178.40.4]:58888 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932212AbWDYNQE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 09:16:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <8bf247760604250500r435c692es5e01e5617b515e50@mail.gmail.com>
X-OriginalArrivalTime: 25 Apr 2006 13:16:03.0513 (UTC) FILETIME=[67467290:01C6686A]
Content-class: urn:content-classes:message
Subject: Re: problems with printk's
Date: Tue, 25 Apr 2006 09:16:02 -0400
Message-ID: <Pine.LNX.4.61.0604250909420.28468@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: problems with printk's
thread-index: AcZoamdvXHuhf0fvSfydgVmbMvFm8Q==
References: <8bf247760604250500r435c692es5e01e5617b515e50@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ram" <vshrirama@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Apr 2006, Ram wrote:

> Hi,
>  i am studing a driver's code.
>
>  i have added a line printk (KERN_DEBUG __FUNCTION)  which is supposed to
>  print the name of the function.
>
[SNIPPED...]

How about you use the correct built-in and syntax?

     printk(KERN_DEBUG"%s\n",__FUNCTION__);



Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
