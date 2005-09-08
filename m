Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbVIHIXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbVIHIXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 04:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVIHIXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 04:23:06 -0400
Received: from fmr14.intel.com ([192.55.52.68]:40593 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S964771AbVIHIXB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 04:23:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [OOPS] vanilla 2.6.13 + "rmmod processor"
Date: Thu, 8 Sep 2005 04:22:45 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30048B3F05@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [OOPS] vanilla 2.6.13 + "rmmod processor"
Thread-Index: AcW0SLKC0QglXy+hQPeJ7td/jrSX9gABNZ3A
From: "Brown, Len" <len.brown@intel.com>
To: <gl@dsa-ac.de>, <linux-kernel@vger.kernel.org>
Cc: <acpi-devel@lists.sourceforge.net>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Li, Shaohua" <shaohua.li@intel.com>
X-OriginalArrivalTime: 08 Sep 2005 08:22:49.0623 (UTC) FILETIME=[7FE72270:01C5B44E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Just booted a 2.6.13 compiled with UP, ACPI, APIC, LAPIC, 
>sensor modules 
>with "nolapic noapic acpi=off".

Huh, I don't see I don't see the processor module checking
for acpi_disabled anyplace...

I assume the oops goes away when you
do not boot with "acpi=off"?

> The processor module was still loaded by 
>the hotplug. On rmmod it Oopsed:

Note other processor rmmod fix here, maybe unrelated:
http://bugzilla.kernel.org/show_bug.cgi?id=5021


