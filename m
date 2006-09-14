Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWINTnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWINTnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWINTnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:43:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:25915 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1751098AbWINTnN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:43:13 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,166,1157353200"; 
   d="scan'208"; a="127117651:sNHT19660130"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: speedstep-centrino broke
Date: Thu, 14 Sep 2006 12:43:12 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454988ACA@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: speedstep-centrino broke
Thread-Index: AcbYNZUe964DP80sT36ogCquirhgEAAACJuw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Almonas Petrasevicius" <draugaz@diedas.soften.ktu.lt>,
       "Ben B" <kernel@bb.cactii.net>
Cc: <linux-kernel@vger.kernel.org>, <davej@codemonkey.org.uk>
X-OriginalArrivalTime: 14 Sep 2006 19:43:12.0314 (UTC) FILETIME=[0360B1A0:01C6D836]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Almonas Petrasevicius [mailto:draugaz@diedas.soften.ktu.lt] 
>Sent: Thursday, September 14, 2006 12:43 PM
>To: Ben B
>Cc: linux-kernel@vger.kernel.org; Pallipadi, Venkatesh; 
>davej@codemonkey.org.uk
>Subject: Re: speedstep-centrino broke
>
>
>On Thu, 14 Sep 2006, Ben B wrote:
>
>>> I did verify both kernels 2.6.16 and 2.6.17 (both vanilla), there is
>>> _no_ difference, both have the same speedstep problem.
>>
>> At the suggestion of Venki, I opened a bugzilla ticket on it:
>>
>> http://bugzilla.kernel.org/show_bug.cgi?id=7157
>>
>> And the lowdown is that it seems the newer BIOS no longer exports the
>> correct ACPI symbols which are required for speedstep, thus no longer
>> supporting it (at least via the official methods). Hence it 
>seems not a
>> Linux kernel bug.
>
>Could be. But I am still somehow puzzled, since neither of the 
>previous versions (F04 & F06 in my case) contain any reference to the 
>mentioned methods (_PSS & _PCT). But those versions were 
>speedsteping just 
>fine. 
>Or maybe I don't know how to look.
>Could You dump your "working" ACPI table and look for those 
>two methods?

As you mentioned in your earlier mail, CpuPm object is missing after
BIOS update. That table, most probably, will contain these ACPI _PSS etc
methods internally.

Thanks,
Venki
