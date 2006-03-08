Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWCHQQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWCHQQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 11:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWCHQQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 11:16:44 -0500
Received: from fmr19.intel.com ([134.134.136.18]:62400 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750712AbWCHQQn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 11:16:43 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: SATA ATAPI AHCI error messages?
Date: Wed, 8 Mar 2006 08:16:27 -0800
Message-ID: <26CEE2C804D7BE47BC4686CDE863D0F50660AFB6@orsmsx410>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SATA ATAPI AHCI error messages?
Thread-Index: AcZCtDQ9pxMH068yRfyj3eUE0SLNRgAFb08Q
From: "Gaston, Jason D" <jason.d.gaston@intel.com>
To: "Mark Lord" <lkml@rtr.ca>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Mar 2006 16:16:28.0904 (UTC) FILETIME=[A7E20680:01C642CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Mark Lord [mailto:lkml@rtr.ca]
>Sent: Wednesday, March 08, 2006 5:27 AM
>To: Alan Cox
>Cc: Gaston, Jason D; linux-kernel@vger.kernel.org
>Subject: Re: SATA ATAPI AHCI error messages?
>
>Alan Cox wrote:
>..
>>> ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
>>> sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00
00
>>> sr: Current [descriptor]: sense key: Aborted Command
>>>     Additional sense: No additional sense information
>>
>> TUR should not be getting aborted command replies off a CD. Most odd
>
>It's been a while, and my memory of such is fuzzy,
>but I think I have commonly seen ATAPI drives (in the past)
>that simply fail TUR as above when the drive is open
>or media is not present (one of those two, forgot which).
>
>Cheers

I have media in the drive and still see the error.  We are seeing the
errors when the system is booting, before gnome or KDE is loaded.

Jason

