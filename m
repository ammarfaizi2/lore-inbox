Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWINUN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWINUN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWINUN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:13:59 -0400
Received: from mga03.intel.com ([143.182.124.21]:57373 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1751121AbWINUN6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:13:58 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,166,1157353200"; 
   d="scan'208"; a="116617168:sNHT3279501008"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: speedstep-centrino broke
Date: Thu, 14 Sep 2006 13:13:35 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454988B15@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: speedstep-centrino broke
Thread-Index: AcbYOdiS9Xw53JeCQiuny95t5XaEuQAAEexg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Almonas Petrasevicius" <draugaz@diedas.soften.ktu.lt>,
       <Pallipadi@diedas.soften.ktu.lt>
Cc: <linux-kernel@vger.kernel.org>, "Ben B" <kernel@bb.cactii.net>,
       <davej@codemonkey.org.uk>
X-OriginalArrivalTime: 14 Sep 2006 20:13:34.0846 (UTC) FILETIME=[41B101E0:01C6D83A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Almonas Petrasevicius [mailto:draugaz@diedas.soften.ktu.lt] 
>Sent: Thursday, September 14, 2006 1:14 PM
>To: Pallipadi@diedas.soften.ktu.lt; Pallipadi, Venkatesh
>Cc: linux-kernel@vger.kernel.org; Ben B; davej@codemonkey.org.uk
>Subject: Re: speedstep-centrino broke
>
>
>On Thu, 2006-09-14 at 12:43 -0700, Pallipadi, Venkatesh wrote:
>
>> >Or maybe I don't know how to look.
>> >Could You dump your "working" ACPI table and look for those
>> >two methods?
>>
>> As you mentioned in your earlier mail, CpuPm object is missing after
>> BIOS update. That table, most probably, will contain these 
>ACPI _PSS etc
>> methods internally.
>
>That's my problem: I can't find them there. At least not directly.
>It contains just two methods for each CPU: _PDC and _OSC.
>Althrough the _OSC methods contain some logic and Load(...) calls, and 
>there is a package supiciously looking like a directory containing 
>some additional ACPI tables (for example "CPU0IST ", offset, 
>length and so 
>on). So, it's possible, that required tables are loaded "on 
>demand" but 
>not accesible with the acpidump.
>

Yes. Dynamic loading is possible. Atleast there should be _PDC/_OSC
which in turn calls the other loads.

Thanks,
Venki
