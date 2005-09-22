Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbVIVOkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbVIVOkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 10:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbVIVOkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 10:40:10 -0400
Received: from spirit.analogic.com ([204.178.40.4]:55821 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030383AbVIVOkI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 10:40:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.58.0509220815530.16109@localhost.localdomain>
References: <200509212046.15793.nick@linicks.net> <Pine.LNX.4.58.0509211305250.24543@shell4.speakeasy.net> <433258D1.8080301@aitel.hist.no> <Pine.LNX.4.58.0509220815530.16109@localhost.localdomain>
X-OriginalArrivalTime: 22 Sep 2005 14:40:06.0817 (UTC) FILETIME=[86815110:01C5BF83]
Content-class: urn:content-classes:message
Subject: Re: A pettiness question.
Date: Thu, 22 Sep 2005 10:40:00 -0400
Message-ID: <Pine.LNX.4.61.0509221034140.1164@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: A pettiness question.
Thread-Index: AcW/g4aI8/6yeNNmRomHTEQBvyngXw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Helge Hafting" <helge.hafting@aitel.hist.no>,
       "Vadim Lobanov" <vlobanov@speakeasy.net>,
       "Nick Warne" <nick@linicks.net>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Sep 2005, Steven Rostedt wrote:

>
> On Thu, 22 Sep 2005, Helge Hafting wrote:
>
>> That one looks good for if-tests and such. But if you need
>> a 0 or 1 for adding to a counter, then
>>
>> a += !!x;
>>
>> looks much better than
>>
>> a += (x != 0);
>>
>
> Actually I prefer:
>
> a += (x == '-'-'-'?'-'-'-':'/'/'/');
>
>  :)
>
> -- Steve

I like that! Nevertheless, for readability one should probably
standardize upon something returing 1 or 0 for a true/false
comparison. I see "(x)?1:0" a lot in the bit-banging code
and I'm pretty sure the compiler knows how to optimize it.

The bang/bang stuff was a way of hiding warnings back in the
days that `lint` was used as a code-checker. It's use should
be condemned to the fullest extent!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
