Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWFXOkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWFXOkW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 10:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbWFXOkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 10:40:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:40546 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750794AbWFXOkU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 10:40:20 -0400
X-IronPort-AV: i="4.06,172,1149490800"; 
   d="scan'208"; a="88676679:sNHT18102693"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Subject: RE: cpufreq doesn't work with my Intel Pentium M processor in 2.6.17
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sat, 24 Jun 2006 07:33:10 -0700
Message-ID: <EB12A50964762B4D8111D55B764A84541D4975@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cpufreq doesn't work with my Intel Pentium M processor in 2.6.17
Thread-Index: AcaVxfDQNPTAx4DrSauNQ4yDwgnWjQB1RWZg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "CIJOML" <cijoml@volny.cz>, <linux-kernel@vger.kernel.org>,
       "Brodowski, Dominik" <linux@dominikbrodowski.net>,
       <cpufreq@lists.linux.org.uk>
X-OriginalArrivalTime: 24 Jun 2006 14:33:12.0465 (UTC) FILETIME=[1F217810:01C6979B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Can you send me the acpidump output from this system using the latest pmtools from here.
http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

Better still, if you can open a bugzilla at http://bugme.osdl.org 
That will help tracking this one better.

Thanks,
Venki  

>-----Original Message-----
>From: CIJOML [mailto:cijoml@volny.cz] 
>Sent: Wednesday, June 21, 2006 11:34 PM
>To: Pallipadi, Venkatesh; linux-kernel@vger.kernel.org; 
>Brodowski, Dominik; cpufreq@lists.linux.org.uk
>Subject: Re: cpufreq doesn't work with my Intel Pentium M 
>processor in 2.6.17
>
>Hi Pallipadi,
>
>no change:
>
>#find /sys -name *freq*
>/sys/module/acpi_cpufreq
>
>no tuning options as you can see
>module is compiled into kernel
>
>Michal
>
>Dne støeda 21 èerven 2006 21:27 jste napsal(a):
>> >-----Original Message-----
>> >From: linux-kernel-owner@vger.kernel.org
>> >[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of CIJOML
>> >Sent: Sunday, June 18, 2006 11:06 PM
>> >To: linux-kernel@vger.kernel.org
>> >Subject: cpufreq doesn't work with my Intel Pentium M
>> >processor in 2.6.17
>> >
>> >Hello team,
>> >
>> >I compiled 2.6.17 and now I see, that cpufreq doesn't work
>> >with 2.6.17 (2.6.16
>> >was fine).
>> >
>> >My cpu:
>> >Intel(R) Pentium(R) M processor 1.70GHz
>> >cpu family 6
>> >model 13
>> >stepping 6
>> >
>> >Cpufreq doesn't start and also /sys files are not present/created
>> >
>> >My config:
>> >[*] CPU Frequency scaling
>> ><*> CPU frequency translation statistics
>> >[*] CPU frequency translation statistics details
>> >governors: <*> performance, powersave, ondemand, conservative
>> ><*> Intel Enhanced SpeedStep
>> >[*] Use ACPI tables to decode valid frequency/voltage pairs
>> >[*] Built-in tables for Banias CPUs
>>
>> Can you also try
>> [*] ACPI Processor P-states driver
>>
>> In the same config menu.
>>
>> Thanks,
>> Venki
>
