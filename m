Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965330AbVKBWr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965330AbVKBWr6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965331AbVKBWr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:47:58 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:16650 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S965330AbVKBWr6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:47:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051102222109.16639.qmail@science.horizon.com>
References: <20051102222109.16639.qmail@science.horizon.com>
X-OriginalArrivalTime: 02 Nov 2005 22:47:22.0058 (UTC) FILETIME=[6300D2A0:01C5DFFF]
Content-class: urn:content-classes:message
Subject: Re: Would I be violating the GPL?
Date: Wed, 2 Nov 2005 17:47:21 -0500
Message-ID: <Pine.LNX.4.61.0511021726260.20831@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Would I be violating the GPL?
Thread-Index: AcXf/2MKNC6zmVrMSSWCZAl9OVvCKg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <linux@horizon.com>
Cc: <linux-kernel@vger.kernel.org>, <s0348365@sms.ed.ac.uk>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 Nov 2005 linux@horizon.com wrote:

> Amongst the various arguments here for declaring a binary kernel
> module a drived work based on including kernel headers, please
> take a step back and remember that what's sauce for the goose is
> sauce for the gander.
>
> The basic question is, does the user of the headers require the permission
> of the author of the headers to distribute the resultant object code?
> If the answer is "no", then the question of the terms of that permission
> (the GNU GPL or otherwise) doesn't arise.
>
> I'd like to argue that people interested in free software should want
> the answer to be "no", and should not try to establish precedents to
> the contrary, and that asserting the claim could boomerang unpleasantly.
>
> Suppose EvilCo produces an EvilOS and provides a series of headers for
> interfacing to EvilOS.  Further suppose that EvilOS is not very good
> about enforcing user/kernel separation and a lot of the headers describe
> kernel-internal data structures that a user might nonetheless want to
> hook into.
>
> Now, if I write a piece of software that runs on EvilOS, or even a
> device driver to connect some hardware to EvilOS, do I want to need
> EvilCo's permission to distribute a percompiled version?  Do I want
> them to claim proprietary rights in the source code because it refers
> to symbols defined in their headers?
>
> Or would I rather that such names and references are considered "Scenes
> a faire" (standard boilerplate) for software that runs on EvilOS, and
> as such not subject to copyright law?
>
>
> Looking at all the crap companies are trying to impose about publishing
> benchmarks, think before claiming that copyright law gives you some
> authority, lest that claim be used against you.  I don't see such claims
> being widely asserted by commercial companies, so I'm strongly disinclined
> to try to start an arms race in that direction.
>
> (There is a bit of that in the game console market, but that's enforced by
> not giving you the headers until you agree to an NDA with lots of conditions.)
>
> In particular, it's a lot harder to argue that such a claim is ridiculous
> if you're making the same claim yourself.  And it's not at all clear to me
> that the benefit is worth that cost.
>
>
> Feel free to argue that the cost is worth it; what worried me was that it
> wasn't clear that people were considering the flip side of the arguments
> at all.  (Of course, there are a lot more mailing list archives than I've
> read; I may just have missed it.)

This is certainly one of the most intelligent discourses I've heard
in some time about the subject. Some claim that if it runs inside
the kernel, it's "obviously" a derived work. It really isn't so
obvious at all.

In fact, if the design of a driver, and its implementation requires
a knowledge of only the driver's kernel interface and the hardware
for which the driver is written, it is not derived by any stretch
of the imagination. It's like writing code to interface with any
API. You only need to understand the published interface and not
its underlying principles of operation.

On the other hand, if you were to take an existing driver and
modify it to control some new hardware, then it is obviously
a derived work. The work was derived from the previous driver.

Anything else is not "obvious", but simply conjecture which
may or may not be correct.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
