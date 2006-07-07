Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWGGNAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWGGNAp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 09:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWGGNAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 09:00:45 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:10765 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751159AbWGGNAo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 09:00:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 07 Jul 2006 13:00:43.0152 (UTC) FILETIME=[5ADA4100:01C6A1C5]
Content-class: urn:content-classes:message
Subject: Re: Setting kernel thread priority
Date: Fri, 7 Jul 2006 09:00:42 -0400
Message-ID: <Pine.LNX.4.61.0607070857160.9025@chaos.analogic.com>
In-Reply-To: <44AE572D.8000105@innomedia.soft.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Setting kernel thread priority
thread-index: AcahxVr78XF5iQZORneh6+0x+nqadw==
References: <44AE572D.8000105@innomedia.soft.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <chinmaya@innomedia.soft.net>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Jul 2006, Chinmaya Mishra wrote:

> Hi,
>
> I am using linux kernel 2.6.10.
> In a kernel module i am calling two functions in two
> kernel threads using the api,
>
> kernel_thread((void *)funName, NULL, CLONE_KERNEL);
>
> Is there any procedure/apis available to set the thread priority?
> Please help . . . . .
>
> Thanks in advance.
> Chinmaya

My a FAQ! Your kernel version uses:
 	set_user_nice(current, PRIORITY); from __inside__ the kernel
thread (like one of the first things it does upon startup).

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
