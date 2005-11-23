Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVKWOW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVKWOW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVKWOW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:22:26 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:44554 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750807AbVKWOWZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:22:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <c216304e0511230610x2b983e59h42c10517acd59e63@mail.gmail.com>
X-OriginalArrivalTime: 23 Nov 2005 14:22:24.0038 (UTC) FILETIME=[52A69C60:01C5F039]
Content-class: urn:content-classes:message
Subject: Re: Over-riding symbols in the Kernel causes Kernel Panic
Date: Wed, 23 Nov 2005 09:22:23 -0500
Message-ID: <Pine.LNX.4.61.0511230920590.17975@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Over-riding symbols in the Kernel causes Kernel Panic
Thread-Index: AcXwOVLPkyBNL2BbQgm5seMxuXOQaA==
References: <c216304e0511230610x2b983e59h42c10517acd59e63@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ashutosh Naik" <ashutosh.lkml@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Nov 2005, Ashutosh Naik wrote:

> Hi,
>
> I made e1000 ( or for that matter anything) a part of the 2.6.15-rc1
> kernel and booted the kernel. Next I compiled e1000 as a module (
> e1000.ko ), and tried to insmod it into the kernel( which already had
> e1000 a compiled as a part of the kernel). I observed that
> /proc/kallsyms contained two copies of all the symbols exported by
> e1000, and I also got a Kernel Panic on the way.
>
> Is this behaviour natural and desirable ?
>
> Regards and Thanks
> -A

When the new module interface was implemented, new bugs were
introduced. You just found another one!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
