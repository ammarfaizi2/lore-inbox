Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVLHN0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVLHN0d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 08:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVLHN0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 08:26:33 -0500
Received: from spirit.analogic.com ([204.178.40.4]:19725 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751135AbVLHN0c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 08:26:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <2cd57c900512080122s74c2f9v@mail.gmail.com>
X-OriginalArrivalTime: 08 Dec 2005 13:26:31.0077 (UTC) FILETIME=[00539D50:01C5FBFB]
Content-class: urn:content-classes:message
Subject: Re: IRQ vector assignment for system call exception
Date: Thu, 8 Dec 2005 08:26:29 -0500
Message-ID: <Pine.LNX.4.61.0512080823010.13935@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IRQ vector assignment for system call exception
Thread-Index: AcX7+wBy1CpHinylRWeGnzmRWabxBw==
References: <20051208080435.M54890@eos.cs.nthu.edu.tw> <2cd57c900512080122s74c2f9v@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Coywolf Qi Hunt" <coywolf@gmail.com>
Cc: "yen" <yen@eos.cs.nthu.edu.tw>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Dec 2005, Coywolf Qi Hunt wrote:

> 2005/12/8, yen <yen@eos.cs.nthu.edu.tw>:
>> Hi:
>>    I have a quwstion. Why the number 128 is reserver for system call exception in
>> interrupt vectors? Why not other numbers? Are there any historical reasons?
>> thanks.
>>
>
> 0x80 stands in the middle of [0..0xff].
> --
> Coywolf Qi Hunt
> http://sosdg.org/~coywolf/

If he's looking for 'secret codes' in the kernel, he might look
at:
 	LINUX_REBOOT_MAGIC2
 	LINUX_REBOOT_MAGIC2B
 	LINUX_REBOOT_MAGIC2C

... in linux-`uname -r`/include/linux/reboot.h Hint: Cvt dec to hex.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
