Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVJLMdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVJLMdT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 08:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVJLMdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 08:33:19 -0400
Received: from spirit.analogic.com ([204.178.40.4]:51981 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750812AbVJLMdS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 08:33:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051012085713.GA24974@0xdef.net>
References: <E90C20D8-AC5D-4E9E-A477-48164FA0E7EE@inf.ufrgs.br> <20051012085713.GA24974@0xdef.net>
X-OriginalArrivalTime: 12 Oct 2005 12:33:16.0435 (UTC) FILETIME=[1EA02E30:01C5CF29]
Content-class: urn:content-classes:message
Subject: Re: Instantiating my own random number generator
Date: Wed, 12 Oct 2005 08:33:16 -0400
Message-ID: <Pine.LNX.4.61.0510120830001.8807@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Instantiating my own random number generator
Thread-Index: AcXPKR6/Ske/7jPbSzWRzd0SQs57zg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Hagen Paul Pfeifer" <hpplinuxml@0xdef.net>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Oct 2005, Hagen Paul Pfeifer wrote:

> On 05.10.11 Roberto Jung Drebes pressed the following keys:
>
>> Is there a way I can set this number generator my own seed value, so
>> that I can replay experiments I perform with my module? If I set a
>> seed for the whole system, it would affect other kernel tasks
>> obtaining random numbers through get_random_bytes(), so I guess that
>> is not a good solution.
>
> No, there insn't a direct alternative. get_random_bytes() should be
> good enough - do you realize a weak spot?
>
>> TIA,
>
> HGN
>

There are some random number generators that are trivial, a few
lines of code, that are good enough for pseudo-random back-off
times (to prevent deadlocks) and things like that. They are no
good for encryption, but fine for randomizing events. If you
need one, let me know.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.48 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
