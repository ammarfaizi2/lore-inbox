Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWHKViQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWHKViQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWHKViP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:38:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:59507 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750725AbWHKViP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:38:15 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,115,1154934000"; 
   d="scan'208"; a="115271483:sNHT22161503"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: cpufreq stops working after a while
Date: Fri, 11 Aug 2006 14:38:08 -0700
Message-ID: <EB12A50964762B4D8111D55B764A84546F8F82@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cpufreq stops working after a while
thread-index: Aca9jLcNas5JvdhzTgWbZfg+qeYuEAAAYTsg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Mark Lord" <lkml@rtr.ca>
Cc: "Dave Jones" <davej@redhat.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 11 Aug 2006 21:38:10.0150 (UTC) FILETIME=[70C37060:01C6BD8E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Mark Lord [mailto:lkml@rtr.ca] 
>Sent: Friday, August 11, 2006 2:25 PM
>To: Pallipadi, Venkatesh
>Cc: Dave Jones; Linux Kernel; Andrew Morton
>Subject: Re: cpufreq stops working after a while
>
>Mark Lord wrote:
>>
>>> Venki wrote:
>>> Looks like there are thermal events happening that is 
>causing CPU limits
>>> to reduce. Are you running anything on the CPU when this happens. Is
>>> there a thermal interface in /proc/acpi that can give you 
>the current
>>> temperature of the system?
>> 
>> There are thermal thingies in /proc, and I'm watching the temperature
>> value from there (62C --> 65C), and the trip_points value is 95C..
>> 
>> Think it's thermal?
>
>Yup, thermal.
>Trips shortly after I see 66C in 
>/proc/acpi/thermal_zone/THM/temperature
>
>If I stop number crunching for a bit, the temperature drops down to the
>low 50's, and the max freq then gets set back to 1100.
>
>Mmmm.. is there a way to control the high/low thermostat values there?
>
>Cheers

What is the "cooling mode" you have in
/proc/acpi/thermal_zone/THM/cooling_mode.
Output of all files in that directory will help.

Thanks,
Venki
