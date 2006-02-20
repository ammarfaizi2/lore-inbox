Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWBTSjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWBTSjY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWBTSjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:39:24 -0500
Received: from spirit.analogic.com ([204.178.40.4]:50439 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932229AbWBTSjX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:39:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1140456505.2979.66.camel@laptopd505.fenrus.org>
x-originalarrivaltime: 20 Feb 2006 18:39:21.0584 (UTC) FILETIME=[F6FD2F00:01C6364C]
Content-class: urn:content-classes:message
Subject: Re: Missing file
Date: Mon, 20 Feb 2006 13:39:21 -0500
Message-ID: <Pine.LNX.4.61.0602201333360.5440@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Missing file
Thread-Index: AcY2TPcj2CBKN8FyRyuPVGNuRJvycA==
References: <Pine.LNX.4.61.0602201201200.4888@chaos.analogic.com> <1140456505.2979.66.camel@laptopd505.fenrus.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Feb 2006, Arjan van de Ven wrote:

> On Mon, 2006-02-20 at 12:08 -0500, linux-os (Dick Johnson) wrote:
>>
>> Hello,
>> Linux-2.6.15.4 fails to contain the file:
>>  	/usr/src/linux-2.6.15.4/drivers/pci/devlist.h
>>
>> This contains product NAMES used to identity various PCI
>> devices when they are installed. What replaces this file?
>>
>> The file existed up until at least linux-2.6.13.4 and
>> should not have been removed just because some audit
>> may have determined that it's "not in use." It is in
>> use by vendors which need to convert "Computerese" to
>> "Customer readable" stuff.
>
>
> actually an entirely different file is used for that;
> /usr/share/hwdata/pci.ids
>
> which comes from the pci id repo on sourceforge (same as the file you
> want to look at). Distributions at least tend to update pci.ids file
> more frequent than the kernel updated devlist.h...

Thanks. Changes like that make tons of work! Great, there will
always be something for us to do. Now all I have to do is
modify a tool to be Linux version-specific so I get the right
ASCII put into driver(s). The drivers don't run in anything
that has a shell or anything like that. They need to "know"
the vendor-name of some interface chips so the name(s) were
compiled in, based upon OS headers.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.49 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
