Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbTAJRuo>; Fri, 10 Jan 2003 12:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbTAJRuo>; Fri, 10 Jan 2003 12:50:44 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:42174 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S265470AbTAJRun> convert rfc822-to-8bit; Fri, 10 Jan 2003 12:50:43 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH] [2.5] IRQ distribution in the 2.5.52  kernel
Date: Fri, 10 Jan 2003 09:59:22 -0800
Message-ID: <E88224AA79D2744187E7854CA8D9131DA5CE5F@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [2.5] IRQ distribution in the 2.5.52  kernel
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK21HXdm3t6gyLFEdeo8gBQi2jWzAB/YFGg
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 10 Jan 2003 17:59:23.0360 (UTC) FILETIME=[01DB7E00:01C2B8D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comment. I will take it out.
Nitin


> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, January 07, 2003 9:12 PM
> To: Kamble, Nitin A
> Cc: linux-kernel@vger.kernel.org; Saxena, Sunil; Mallick, Asit K;
> Nakajima, Jun
> Subject: Re: [PATCH] [2.5] IRQ distribution in the 2.5.52 kernel
> 
> On Tue, Jan 07, 2003 at 06:52:59PM -0800, Kamble, Nitin A wrote:
> > +# define MIN(a,b) (((a) < (b)) ? (a) : (b))
> > +# define MAX(a,b) (((a) > (b)) ? (a) : (b))
> 
> There are alread definitions for min() and max(), it would be good to
> use them and not try to define your own.
> 
> thanks,
> 
> greg k-h
