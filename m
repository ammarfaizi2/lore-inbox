Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWDXUuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWDXUuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWDXUuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:50:09 -0400
Received: from spirit.analogic.com ([204.178.40.4]:26634 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751231AbWDXUuI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:50:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.64.0604241319030.3701@g5.osdl.org>
X-OriginalArrivalTime: 24 Apr 2006 20:50:07.0378 (UTC) FILETIME=[AB789720:01C667E0]
Content-class: urn:content-classes:message
Subject: Re: better leve triggered IRQ management needed
Date: Mon, 24 Apr 2006 16:50:07 -0400
Message-ID: <Pine.LNX.4.61.0604241648340.24574@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: better leve triggered IRQ management needed
thread-index: AcZn4Kt/9cL2aremT7i68YZqd0CVbg==
References: <20060424114105.113eecac@localhost.localdomain> <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org> <Pine.LNX.4.61.0604241529360.24459@chaos.analogic.com> <Pine.LNX.4.64.0604241319030.3701@g5.osdl.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Stephen Hemminger" <shemminger@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Apr 2006, Linus Torvalds wrote:

>
>
> On Mon, 24 Apr 2006, linux-os (Dick Johnson) wrote:
>>> one user and the driver is properly written. Making request_irq() fail
>>    ^^^^^^^^_______ Must be a trick!
>>> would break existing and working setups.
>>>
>>
>> If there is just one user then it isn't shared! Get real.
>
> SA_SHIRQ does NOT mean that the irq is shared.
>
> It means that it's not exclusive, and that the driver is _ok_ with it
> being shared if that makes sense.
>
> 		Linus
> -

Yeah. You have been talking to too many lawyers! You are getting a
forked tongue!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
