Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966241AbWKNSH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966241AbWKNSH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966240AbWKNSH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:07:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:46613 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S966243AbWKNSH0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:07:26 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,421,1157353200"; 
   d="scan'208"; a="15731040:sNHT39260547"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Date: Tue, 14 Nov 2006 10:06:37 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454E0DC9D@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Thread-Index: AccIEq4ZKfhzuWXlQzq3GVl7Sude4gABCUqw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Cc: "Len Brown" <lenb@kernel.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Thomas Gleixner" <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
       "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
X-OriginalArrivalTime: 14 Nov 2006 18:06:38.0157 (UTC) FILETIME=[A0FD3FD0:01C70817]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Andreas Mohr [mailto:andi@rhlx01.fht-esslingen.de] 
>Sent: Tuesday, November 14, 2006 9:31 AM
>To: Pallipadi, Venkatesh
>Cc: Len Brown; Ingo Molnar; Andreas Mohr; Thomas Gleixner; 
>linux-kernel@vger.kernel.org; Van De Ven, Arjan
>Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ 
>required) [2.6.18-rc4-mm1]
>
>Hi,
>
>On Tue, Nov 14, 2006 at 09:21:02AM -0800, Pallipadi, Venkatesh wrote:
>> >I belive that Venki has looked at some of the HPET 
>enumeration issues,
>> >and maybe he has some suggestions.  Is there an example system
>> >on-hand where we know Windows works and Linux does not?
>> >
>> 
>> There are two things that can be happening when OS does not 
>see HPET in
>> ACPI.
>> - BIOS did enable HPET in chipset and did not communicate it to OS.
>> - BIOS did nothing to enable HPET in chipset.
>
>I'm sure you've already seen
>http://semthex.freeflux.net/blog/archive/2006/10/21/hpet-to-be-
>or-not-to-be.html
>... or not?

Hmmm.. I hadn't seen this before..

>
>Hmm, hopefully it's easy to research where to enable HPET
>(if there is one at all!) on an el-cheapo VIA chipset...
>
>Many thanks for your patch! (even though currently Intel-only)

Yes. This should be easy to do for any chipset. It should be documented
somewhere in the chipset documentation. Atleast it is documented on ICH
specification :).

Thanks,
Venki
