Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWJIXf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWJIXf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 19:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWJIXf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 19:35:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:15011 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S964854AbWJIXfV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 19:35:21 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,285,1157353200"; 
   d="scan'208"; a="2438258:sNHT19624311"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-9"
Content-Transfer-Encoding: 8BIT
Subject: RE: Ondemand/Conservative not working with 2.6.18
Date: Mon, 9 Oct 2006 16:35:18 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454B6B4F1@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Ondemand/Conservative not working with 2.6.18
Thread-Index: Acbr7XsfCjcrLzQQR7OWY2F9W3nR+gADMAag
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <caglar@pardus.org.tr>, "Dave Jones" <davej@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Oct 2006 23:35:19.0597 (UTC) FILETIME=[95032DD0:01C6EBFB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of S.Çaglar Onur
>Sent: Monday, October 09, 2006 2:53 PM
>To: Dave Jones
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: Ondemand/Conservative not working with 2.6.18
>
>04 Eki 2006 Çar 16:33 tarihinde, S.Çaðlar Onur þunlarý yazmýþtý: 
>> Hi;
>>
>> With kernel 2.6.18 "ondemand" and "conservative" governors 
>are not working
>> with Sony Vaio FS-215B laptop, no frequency scaling or 
>anything else :)
>> occurs while system is %100 idle or at any workload using 
>these governors,
>> but setting "performance" governor changes to 1733 Mhz and 
>"powersave"
>> changes to 800 Mhz as expected. They all works without a problem with
>> 2.6.16.x, system information below;
>
>Also not working with 2.6.19-rc1
>

What CPU is this? Pentium M?
What driver was getting used in 2.6.16 kernel to change freqency? Acpi-cpufreq?

Can you please make sure you have configured in both speedstep-centrino and acpi-cpufreq drivers. Things should work with both these drivers so that the best one will be used based on your BIOS support.

Thanks,
Venki
