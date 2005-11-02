Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbVKBQQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbVKBQQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbVKBQQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:16:12 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:11526 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S965118AbVKBQQK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:16:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <87fyqfm5jx.fsf@amaterasu.srvr.nix>
References: <XFMail.20051102104916.pochini@shiny.it><1130943242.3367.39.camel@berloga.shadowland> <87fyqfm5jx.fsf@amaterasu.srvr.nix>
X-OriginalArrivalTime: 02 Nov 2005 16:16:09.0465 (UTC) FILETIME=[BC3F5E90:01C5DFC8]
Content-class: urn:content-classes:message
Subject: Re: Would I be violating the GPL?
Date: Wed, 2 Nov 2005 11:16:03 -0500
Message-ID: <Pine.LNX.4.61.0511021108410.15964@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Would I be violating the GPL?
Thread-Index: AcXfyLxLPwmLtxRBQ+etS410llyu6A==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Nix" <nix@esperi.org.uk>
Cc: "Alex Lyashkov" <umka@sevcity.net>, "Giuliano Pochini" <pochini@shiny.it>,
       <alex@alexfisher.me.uk>, <linux-kernel@vger.kernel.org>,
       "Jeff V. Merkey" <jmerkey@utah-nac.org>,
       "Michael Buesch" <mbuesch@freenet.de>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 Nov 2005, Nix wrote:

> On 2 Nov 2005, Alex Lyashkov moaned:
>>>> So despite the fact the driver has been written in c++, it
>>>> might be possible to write a usable specification.
>>>
>>> Linux 2.6 doesn't accept c++, so you have to rewrite it anyway.
>>> You should ask them if you can publish your own driver based
>>> on infos you extract from their driver.
>>>
>> without exeption c++ code can be used at drivers.
>
> The rather important `struct class' may give you trouble there.
>

1. A couple of symbols would have to be artifically generated
    to keep the loader happy.

2. New and delete are a bitch.

3. Link will fail because of the hidden stuff C++ needs that it
    can't find. Okay, just generate some dummy symbols in asm,
    all pointing to the same junk.

4. Once you got it to load, gigantic stack usage will crash.

So much for C++. Just use C. He probably didn't remember that
it's a simpler variant. If he knows C++, he knows C, but just
needs to do more things that C++ did for him.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
