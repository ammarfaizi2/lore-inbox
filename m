Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWFSMFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWFSMFE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWFSMFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:05:04 -0400
Received: from spirit.analogic.com ([204.178.40.4]:31244 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932399AbWFSMFD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:05:03 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 19 Jun 2006 12:05:01.0663 (UTC) FILETIME=[97BBFEF0:01C69398]
Content-class: urn:content-classes:message
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Date: Mon, 19 Jun 2006 08:05:01 -0400
Message-ID: <Pine.LNX.4.61.0606190802110.27505@chaos.analogic.com>
In-Reply-To: <20060619114617.GM4253@implementation.labri.fr>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: emergency or init=/bin/sh mode and terminal signals
thread-index: AcaTmJfFSU4FDtOeTqGL50itlNUztQ==
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr> <Pine.LNX.4.61.0606190730070.27378@chaos.analogic.com> <20060619114617.GM4253@implementation.labri.fr>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Samuel Thibault" <samuel.thibault@ens-lyon.org>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Jun 2006, Samuel Thibault wrote:

> linux-os (Dick Johnson), le Mon 19 Jun 2006 07:37:02 -0400, a écrit :
>> I don't think this is the correct behavior. You can't allow some
>> terminal input to affect init. It has been the de facto standard
>> in Unix, that the only time one should have a controlling terminal
>> is after somebody logs in and owns something to control. If you want
>> a controlling terminal from your emergency shell, please exec /bin/login.
>
> Ok, but people don't know that: they're given a shell, and wonder why on
> hell ^C doesn't work...
>
> Samuel

Maybe, but you shouldn't modify the kernel for "training". The kernel
needs to be sacrosanct.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
