Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVCWRAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVCWRAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVCWRAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:00:12 -0500
Received: from [199.212.44.231] ([199.212.44.231]:199 "EHLO
	cnbmail2.city.north-bay.on.ca") by vger.kernel.org with ESMTP
	id S261653AbVCWRAB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:00:01 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: memory size
Date: Wed, 23 Mar 2005 11:57:49 -0500
Message-ID: <C6FD667B200BDF4F964C1BA77B796CE20F5E43@cnbmail2.city.north-bay.on.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: memory size
Thread-Index: AcUvf5rbTEBXfhIyR862otDcDDQlKwASalKw
From: "Mike Turcotte" <Mike.Turcotte@cityofnorthbay.ca>
To: "hv" <hv@trust-mart.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first 800 and sum odd MB of memory are not considered high memory,
so it will not appear in the output. By taking a quick look at your
numbers, it seems fine

Michael Turcotte
Information Systems
City of North Bay
200 McIntyre St. E
PO Box 360
North Bay, Ontario
P1B 8H8
 
Mike.Turcotte@cityofnorthbay.ca
http://www.cityofnorthbay.ca 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of hv
> Sent: Wednesday, March 23, 2005 3:09 AM
> To: hv
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: memory size
> 
> The other dell6650 with 16G ram under kernel 2.6.11-rc4-mm1 is more
> oddness.
> Memory: 16116752k/16777216k available (1855k kernel code, 135136k
> reserved,
> 702k data, 164k init, 15335296k highmem)
> 
> 
> ----- Original Message -----
> From: "hv" <hv@trust-mart.com>
> To: <linux-kernel@vger.kernel.org>
> Sent: Wednesday, March 23, 2005 3:54 PM
> Subject: memory size
> 
> 
> > Hi,all:
> > This is my memory status from "dmesg":
> > Memory: 4673020k/5242880k available (1334k kernel code, 44532k
reserved,
> > 672k data, 156k init, 3800960k highmem)
> >
> >
> > But I found that available memory size is much less than physical
memory
> > size.My server is Dell6650 with P4 Xeon*4 and 5G Ram.
> > My kernel version is 2.6.12-rc1-mm1.Could any one tell my the
> > reason?Thanks.
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe
linux-kernel"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
