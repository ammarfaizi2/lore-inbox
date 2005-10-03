Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbVJCS3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVJCS3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbVJCS3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:29:10 -0400
Received: from spirit.analogic.com ([204.178.40.4]:16902 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932513AbVJCS3J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:29:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051003180858.GA8011@csclub.uwaterloo.ca>
References: <20051003004442.GL6290@lkcl.net> <20051003075000.28A8C13ED9@rhn.tartu-labor> <20051003180858.GA8011@csclub.uwaterloo.ca>
X-OriginalArrivalTime: 03 Oct 2005 18:29:05.0072 (UTC) FILETIME=[55AFEB00:01C5C848]
Content-class: urn:content-classes:message
Subject: Re: what's next for the linux kernel?
Date: Mon, 3 Oct 2005 14:28:59 -0400
Message-ID: <Pine.LNX.4.61.0510031416560.24845@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: what's next for the linux kernel?
Thread-Index: AcXISFW3E/wJ6m/dRfOTCEJ8etOpPQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: "Meelis Roos" <mroos@linux.ee>, <lkcl@lkcl.net>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Oct 2005, Lennart Sorensen wrote:

> On Mon, Oct 03, 2005 at 10:50:00AM +0300, Meelis Roos wrote:
>> LKCL>  the code for oskit has been available for some years, now,
>> LKCL>  and is regularly maintained.  the l4linux people have had to
>>
>> My experience with oskit (trying to let students use it for OS course
>> homework) is quite ... underwhelming. It works as long as you try to use
>> it exactly like the developers did and breaks on a slightest sidestep
>> from that road. And there's not much documentation so it's hard to learn
>> where that road might be.
>>
>> Switched to Linux/BSD code hacking with students, the code that actually
>> works.
>
> Can oskit be worse than nachos where the OS ran outside the memory space
> and cpu with only applications being inside the emulated mips processor?
> Made some things much too easy to do, and other things much to hard
> (like converting an address from user space to kernel space an accessing
> it, which should be easy, but was hard).
>
> I suspect most 'simple' OS teaching tools are awful.  Of course writing
> a complete OS from scratch is a serious pain and makes debuging much
> harder than if you can do your work on top of a working OS that can
> print debug messages.
>
> Len Sorensen
> -

But the first thing you must do in a 'roll-your-own' OS is to make
provisions to write text to (sometimes a temporary) output device
and get some input from same. Writing such basic stuff is getting
harder because many embedded systems don't have UARTS, screen-cards,
keyboards, or any useful method of doing I/O. This is where an
existing OS (Like Linux) can help you get some I/O running, perhaps
through a USB bus. You debug and make it work as a Linux
Driver, then you link the working stuff into your headless CPU
board.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
