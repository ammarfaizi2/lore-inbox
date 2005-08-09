Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbVHIL46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVHIL46 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 07:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVHIL46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 07:56:58 -0400
Received: from [202.125.86.130] ([202.125.86.130]:37296 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S932524AbVHIL45 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 07:56:57 -0400
Subject: RE: HOW to handle partitions on SD Card in the driver?
Date: Tue, 9 Aug 2005 17:26:52 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <C349E772C72290419567CFD84C26E01709FE8F@mail.esn.co.in>
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-TNEF-Correlator: 
Thread-Topic: HOW to handle partitions on SD Card in the driver?
Thread-Index: AcWcSqIay08w1FSrR8y8Yc5/rq3T9wAjPHbw
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Russell,

This driver I am specking about is in the maintenance phase and it is
fully developed.
I am registering it as a BLOCK driver and it works fine.

Do we need to use the interfaces provided in driver/mmc to support the
SD/MMC partition support in the driver?

If so, Can you give a brief note on how to use them?

Give you give me access to a document or some stuff that gives me idea
about rendering partition support on these Block devices.

Thanks & Regards,
Mukund Jampala



>-----Original Message-----
>From: Russell King [mailto:rmk@arm.linux.org.uk] On Behalf Of Russell
King
>Sent: Tuesday, August 09, 2005 12:24 AM
>To: Mukund JB.
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: HOW to handle partitions on SD Card in the driver?
>
>On Fri, Aug 05, 2005 at 11:30:43AM +0530, Mukund JB. wrote:
>> I have problem with my new driver that tired to support the
partitions
>> support on SD cards.
>
>Have you thought about using the generic mmc layer in drivers/mmc with
>the SD patches which are available in the -mm kernels?
>
>We don't want two MMC/SD subsystems in the kernel.
>
>--
>Russell King
> Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
> maintainer of:  2.6 Serial core
