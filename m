Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbUBWQo5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbUBWQo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:44:57 -0500
Received: from fmr05.intel.com ([134.134.136.6]:4012 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S261955AbUBWQoj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:44:39 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH]2.6.3-rc2 MSI Support for IA64
Date: Mon, 23 Feb 2004 08:44:30 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502404058107@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]2.6.3-rc2 MSI Support for IA64
Thread-Index: AcP4HdOG4wJFB/tRRD2jJ7rM1HKTtgCC15ZA
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: "Andreas Schwab" <schwab@suse.de>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>
X-OriginalArrivalTime: 23 Feb 2004 16:44:31.0812 (UTC) FILETIME=[4FA36840:01C3FA2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004, 5:55 PM Zwane Mwaikambo wrote:

>> To avoid some #ifdef statements as possible, "ia64_platform"
>> defined in the header file "msi.h" is set to TRUE only if
>> setting CONFIG_IA64 to 'Y'. The setting of ia64_platform
>> to TRUE will execute function ia64_alloc_vector.
>>
>> This API is only used in assign_msi_vector()in msi.c:
>>
>> 	vector = (ia64_platform ? ia64_alloc_vector() :
>> 		assign_irq_vector(MSI_AUTO));

> I think we should just come up with a standard name here, i'm biased and
> think it should be assign_irq_vector ;)

Thanks for the comments from Mika Penttilä and you. We are working on it
right now.

Thanks,
Long

