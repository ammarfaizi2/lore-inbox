Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWHRTPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWHRTPX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 15:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWHRTPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 15:15:23 -0400
Received: from spirit.analogic.com ([204.178.40.4]:36621 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932487AbWHRTPV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 15:15:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 18 Aug 2006 19:15:20.0013 (UTC) FILETIME=[A5748FD0:01C6C2FA]
Content-class: urn:content-classes:message
Subject: Re: Serial issue
Date: Fri, 18 Aug 2006 15:15:19 -0400
Message-ID: <Pine.LNX.4.61.0608181512520.19876@chaos.analogic.com>
In-Reply-To: <1155925024.2924.22.camel@mindpipe>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Serial issue
thread-index: AcbC+qV+bKDln2CPR4WY5elZ8tHO8w==
References: <1155862076.24907.5.camel@mindpipe> <1155915851.3426.4.camel@amdx2.microgate.com> <1155923734.2924.16.camel@mindpipe>  <44E602C8.3030805@microgate.com> <1155925024.2924.22.camel@mindpipe>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: "Paul Fulghum" <paulkf@microgate.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Aug 2006, Lee Revell wrote:

> On Fri, 2006-08-18 at 13:11 -0500, Paul Fulghum wrote:
>> Lee Revell wrote:
>>> But it had no effect.
>>>
>>> Could it be a hardware-specific bug?  After all VIA chipsets are
>>> notorious for interrupts not working right.
>>>
>>> Any other suggestions?
>>
>> I can't think of any. The interrupts are occurring
>> and being serviced. Nothing else seems to be sitting
>> on that interrupt. It's reaching a bit: maybe there
>> is some console output interfering with the
>> file transfer protocol, but it only occurs with
>> interrupt enabled because of some initial timing?
>> (polling mode may delay things enough to work)
>> What protocol is ckermit using? (zmodem, etc)
>>
>
> I think it's just using the kermit file transfer protocol.
>
> Lee

A file-transfer protocol??? Has he got hardware the __required__
hardware flow-control enabled on both ends? One can't spew
high-speed serial data out forever without a hardware handshake.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
