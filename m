Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWDNO4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWDNO4l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 10:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWDNO4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 10:56:41 -0400
Received: from spirit.analogic.com ([204.178.40.4]:42760 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964895AbWDNO4k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 10:56:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <728201270604140754g7bf955d6y5e06bc5ce4f86c7b@mail.gmail.com>
x-originalarrivaltime: 14 Apr 2006 14:56:39.0564 (UTC) FILETIME=[A27F7CC0:01C65FD3]
Content-class: urn:content-classes:message
Subject: Re: select takes too much time
Date: Fri, 14 Apr 2006 10:56:39 -0400
Message-ID: <Pine.LNX.4.61.0604141056120.11151@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: select takes too much time
Thread-Index: AcZf06KJ1XnOK2QrQSS1qoU+w8OgtQ==
References: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com> <443E9A17.4070805@stud.feec.vutbr.cz> <728201270604131251h5296dd41o7d0e0dd8f2f1ac63@mail.gmail.com> <Pine.LNX.4.61.0604131701030.7732@chaos.analogic.com> <443EC09C.2050409@stud.feec.vutbr.cz> <728201270604140754g7bf955d6y5e06bc5ce4f86c7b@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ram Gupta" <ram.gupta5@gmail.com>
Cc: "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "linux mailing-list" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Apr 2006, Ram Gupta wrote:

>> Of course you can't get lower resolution than 1/HZ, unless you're using
>> a kernel with high-res timers. It's always been like that.
>> But it's not Ram's problem, because he's requesting a timeout of 90ms,
>> which is much longer than one tick even with HZ=100.
>>
>> Michal
>>
>
> So it seems that the only solution to return back right away after
> timeout is to play around with the scheduler or put the process doing
> select at the front of the queue so it get a chance to run first.
> Is there any other better way to do it?
>
 	nice(-19);


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
