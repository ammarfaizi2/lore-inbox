Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbVJNS4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbVJNS4g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 14:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbVJNS4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 14:56:36 -0400
Received: from spirit.analogic.com ([204.178.40.4]:58637 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750858AbVJNS4g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 14:56:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.64.0510141136291.23590@g5.osdl.org>
References: <200510141350_MC3-1-ACA0-C8C9@compuserve.com> <Pine.LNX.4.61.0510141409040.4395@chaos.analogic.com> <Pine.LNX.4.64.0510141136291.23590@g5.osdl.org>
X-OriginalArrivalTime: 14 Oct 2005 18:56:24.0678 (UTC) FILETIME=[F9833060:01C5D0F0]
Content-class: urn:content-classes:message
Subject: Re: [patch 2.6.14-rc4] i386: spinlock optimization
Date: Fri, 14 Oct 2005 14:56:23 -0400
Message-ID: <Pine.LNX.4.61.0510141455410.4499@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.14-rc4] i386: spinlock optimization
Thread-Index: AcXQ8PmKyx9+jpRWS8q83FX//d5q0g==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       "Ingo Molnar" <mingo@elte.hu>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Oct 2005, Linus Torvalds wrote:

>
>
> On Fri, 14 Oct 2005, linux-os (Dick Johnson) wrote:
>>
>> Somehow, these spin-locks got all screwed up.
>
> Nope.
>
>> Given: nobody has the lock. The lock variable is 0.
>
> Your "given" is wrong.
>
> UNLOCKED is 1, locked is 0 or negative.
>
> 		Linus
>
Okay. Thanks.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.46 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
