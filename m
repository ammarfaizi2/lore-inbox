Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWEZPB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWEZPB7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 11:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWEZPB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 11:01:59 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:29968 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750838AbWEZPB6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 11:01:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 26 May 2006 15:01:56.0474 (UTC) FILETIME=[54BD9DA0:01C680D5]
Content-class: urn:content-classes:message
Subject: Re: How to check if kernel sources are installed on a system?
Date: Fri, 26 May 2006 11:01:55 -0400
Message-ID: <Pine.LNX.4.61.0605261058430.6879@chaos.analogic.com>
In-Reply-To: <20060526143718.GY13513@lug-owl.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to check if kernel sources are installed on a system?
Thread-Index: AcaA1VTHKuL48BvfQDy35S2Vuh9REQ==
References: <e55715+usls@eGroups.com> <447622EA.90704@garzik.org> <20060525213952.GT13513@lug-owl.de> <20060525214413.GE4328@redhat.com> <20060526143718.GY13513@lug-owl.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>
Cc: "Dave Jones" <davej@redhat.com>, <linux-kernel@vger.kernel.org>,
       "Jeff Garzik" <jeff@garzik.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 26 May 2006, Jan-Benedict Glaw wrote:

> On Thu, 2006-05-25 17:44:13 -0400, Dave Jones <davej@redhat.com> wrote:
>> On Thu, May 25, 2006 at 11:39:52PM +0200, Jan-Benedict Glaw wrote:
>> > On Thu, 2006-05-25 17:34:34 -0400, Jeff Garzik <jeff@garzik.org> wrote:
>> >>
>> >> find / -name libata-scsi.c
>> >
>> > Which of the 10 versions showing up is the "right" one?
>>
>> For the sake of compiling out-of-tree modules, it's also useless,
>> as sanitised headers (like Fedora's kernel-devel package) won't have this.
>>
>> Following /lib/modules/`uname -r`/build is the only way this can work.
>> (And that should be true on any distro)
>
> As long as you actually compile the modules on the machine they're
> ment to run on...
>
> MfG, JBG

Distributions really need to have been built on the target system
so that the CONFIG variables are correct and the various dynamic
files have been created. Therefore I suggest that the presence of:

 	/usr/src/linux-`uname -r`/System.map

... is probably good enough for most everyone.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.73 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
