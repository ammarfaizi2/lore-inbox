Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWDKQH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWDKQH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 12:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWDKQH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 12:07:57 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:3332 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750848AbWDKQH4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 12:07:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <20060411154944.65714.qmail@web54308.mail.yahoo.com>
x-originalarrivaltime: 11 Apr 2006 16:07:54.0911 (UTC) FILETIME=[17906AF0:01C65D82]
Content-class: urn:content-classes:message
Subject: Re: GPL issues
Date: Tue, 11 Apr 2006 12:07:49 -0400
Message-ID: <Pine.LNX.4.61.0604111153001.29696@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: GPL issues
Thread-Index: AcZdgheZCqDoMyeLQgS368S3Kdgz0Q==
References: <20060411154944.65714.qmail@web54308.mail.yahoo.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ramakanth Gunuganti" <rgunugan@yahoo.com>
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Apr 2006, Ramakanth Gunuganti wrote:

>
> Thanks for the replies, talking to a lawyer seems to
> be too stringent a requirement to even evaluate Linux.
> Who would be the ultimate authority to give definitive
> answers to these questions?
>
> Since it's the Linux kernel that's under GPLv2, any
> work done here should be released under GPLv2. That
> part seems to be clear, however any product would
> include other things that could be proprietary. If
> Linux kernel is made part of this proprietary package,
> how does the distribution work. Can we just claim that
> part of the package is under GPL and only release the
> source code for the kernel portions.
>
[See bottom. Please do not top-post.]

> -Ram
>
> --- Kyle Moffett <mrmacman_g4@mac.com> wrote:
>
>> On Apr 11, 2006, at 02:31:27, Ramakanth Gunuganti
>> wrote:
>>> I am trying to understand the GPL boundaries for
>> Linux, any
>>> clarification provided on the following issues
>> below would be great:
>>> [...]
>>> Anyone trying to build a new application to work
>> on Linux must have
>>> these issues clarified, if you can share your
>> experiences that
>>> would be great too.
>>
>> If you're planning to make money off of any code
>> developed based in
>> part off of the Linux Kernel, you should definitely
>> contact a lawyer
>> familiar with the linux kernel and ask them.  Any
>> advice you get from
>> this list should probably come prefixed with
>> "IANAL", and as such
>> isn't worth terribly much.
>>
>> Cheers,
>> Kyle Moffett
>>
>>
>

Nobody can produce a definitive answer because nobody knows
what you are doing. You could be making a module that exposes
the entire contents of the kernel to user-space, then writing
user-space programs that manipulate the kernel. Such user-space
programs are then <probably> derived works and would need a GPL
License.

On the other hand, you could be making a Hexagrid-confuser(tm)
that runs a Pyrosynchrogem(tm), both proprietary items your
company manufactures for the Red Sox. You need to make a kernel
driver to interface with it, plus a whole bunch of proprietary
user-mode software to help the Red Sox win another world series.
In this case, only the driver needs to be GPL as long as it
doesn't extend or modify the established Unix/Linux API. BUT,
you imply that you need to modify the kernel in addition to
writing a driver. This means that you are extending the API,
which just __might__ require that any code that interfaces
with that extension be GPL as well. That's why you __need__
a lawyer if you are going to change the kernel to run your code.

Easiest way out is to make a conventional driver to interface
with your device. Then write proprietary code that interfaces
with it. Do not make any kernel changes, and do publish your
driver under a GPL license.

For non-US readers, the Red Sox are a baseball team.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
