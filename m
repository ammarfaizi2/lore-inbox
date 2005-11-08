Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965203AbVKHON6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbVKHON6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 09:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbVKHON6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 09:13:58 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:31501 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S965203AbVKHON5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 09:13:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1131459503.25192.42.camel@localhost.localdomain>
References: <20051108062936.14482.qmail@web33308.mail.mud.yahoo.com> <200511080833.57710.gene.heskett@verizon.net> <1131459503.25192.42.camel@localhost.localdomain>
X-OriginalArrivalTime: 08 Nov 2005 14:13:55.0136 (UTC) FILETIME=[A7201400:01C5E46E]
Content-class: urn:content-classes:message
Subject: Re: Automatic download of kernel rpms
Date: Tue, 8 Nov 2005 09:13:54 -0500
Message-ID: <Pine.LNX.4.61.0511080910001.3265@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Automatic download of kernel rpms
Thread-Index: AcXkbqdGOnDFlmE1S/+RmGa4+u7Fmg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Gene Heskett" <gene.heskett@verizon.net>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Nov 2005, Alan Cox wrote:

> On Maw, 2005-11-08 at 08:33 -0500, Gene Heskett wrote:
>> Generally, no.  The exact reason is that rpms are a vendor item, and no
>> fixed relation to the kernel.org tarballs.
>
> "make rpm" should build an RPM package from them but you will still need
> to get the configuration correct before doing this.
>

Alan can verify that Red Hat Fedora puts the ".config" file in
/boot as /boot/config-`uname -r`. This can be copied to the
new kernel tree as ".config" and `make oldconfig` should get
you a kernel configured very close to the one provided with
the distribution.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
