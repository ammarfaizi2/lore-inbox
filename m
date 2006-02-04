Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946112AbWBDADM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946112AbWBDADM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWBDADM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:03:12 -0500
Received: from mail0.lsil.com ([147.145.40.20]:29634 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751503AbWBDADK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:03:10 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2/2] megaraid_sas: support for 1078 type controlleradded
Date: Fri, 3 Feb 2006 17:03:00 -0700
Message-ID: <0631C836DBF79F42B5A60C8C8D4E82292C6937@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/2] megaraid_sas: support for 1078 type controlleradded
Thread-Index: AcYpHTxPBjioytaLShaa0c75lJXjXQAAMCOQ
From: "Patro, Sumant" <Sumant.Patro@lsil.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Moore, Eric" <Eric.Moore@lsil.com>
Cc: <hch@lst.de>, <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>,
       "Kolli, Neela" <Neela.Kolli@engenio.com>,
       "Yang, Bo" <Bo.Yang@engenio.com>,
       "Doelfel, Hardy" <Hardy.Doelfel@engenio.com>
X-OriginalArrivalTime: 04 Feb 2006 00:03:02.0019 (UTC) FILETIME=[5D72A530:01C6291E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes the device id issue has been resolved.

The device id has been changed for 1078 controllers for megaraid_sas to
60 
from 62.

Thanks,

Sumant


-----Original Message-----
From: James Bottomley [mailto:James.Bottomley@SteelEye.com] 
Sent: Friday, February 03, 2006 3:55 PM
To: Moore, Eric; Patro, Sumant
Cc: hch@lst.de; linux-kernel@vger.kernel.org;
linux-scsi@vger.kernel.org; Bagalkote, Sreenivas; Kolli, Neela; Yang,
Bo; Doelfel, Hardy
Subject: Re: [PATCH 2/2] megaraid_sas: support for 1078 type
controlleradded

On Fri, 2006-02-03 at 15:34 -0800, Sumant Patro wrote:
>         {
> +        PCI_VENDOR_ID_LSI_LOGIC,
> +        PCI_DEVICE_ID_LSI_SAS1078R, // ppc IOP
> +        PCI_ANY_ID,
> +        PCI_ANY_ID,
> +       },

I thought the fusion people objected to this because they also have a
fusion card with this id; has that now been resolved?

James


