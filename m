Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWC1ST4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWC1ST4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 13:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWC1ST4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 13:19:56 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:4615 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751016AbWC1ST4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 13:19:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <200603281244.24906.gene.heskett@verizon.net>
x-originalarrivaltime: 28 Mar 2006 18:19:54.0339 (UTC) FILETIME=[3620BB30:01C65294]
Content-class: urn:content-classes:message
Subject: Re: Possible breakage in 2.6.16?
Date: Tue, 28 Mar 2006 13:19:54 -0500
Message-ID: <Pine.LNX.4.61.0603281316480.23823@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Possible breakage in 2.6.16?
Thread-Index: AcZSlDZCZu3mgO2FQ+622Nn4gulbPA==
References: <200603281244.24906.gene.heskett@verizon.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <gene.heskett@verizononline.net>
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Mar 2006, Gene Heskett wrote:

> Greetings;
>
> Always curious as to what sort of information can be extracted from the
> tools linux gives us, I've discovered that netstat, from the
>
> net-tools-1.60-25.1 rpm
>
> no longer functions for anything as even a 'netstat --version' takes the
> curser to the upper left corner of the screen and hangs till ctl+c'd.
>
> The only evidence of its execution is a steady, about 2 per second,
> increase in the number of processes running as reported by gkrellm, all
> of which go away when I ctl+c netstat itself.
>
> I'm running 2.6.16 self configured here.
>
> Is this a known problem because my net-tools rpm is old?  Or because
> 2.6.16 broke it?

strace netstat --version 2>info.txt
^C

Then read info.txt and see what it called that doesn't return.

>
> --
> Cheers, Gene
> People having trouble with vz bouncing email to me should add the word
> 'online' between the 'verizon', and the dot which bypasses vz's
> stupid bounce rules.  I do use spamassassin too. :-)
> Yahoo.com and AOL/TW attorneys please note, additions to the above
> message by Gene Heskett are:
> Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
> -

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
