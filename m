Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161161AbWAHIUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbWAHIUQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 03:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbWAHIUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 03:20:15 -0500
Received: from fmr16.intel.com ([192.55.52.70]:641 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161161AbWAHIUO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 03:20:14 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.15-mm2
Date: Sun, 8 Jan 2006 03:19:45 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A1348B@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.15-mm2
Thread-Index: AcYT0iT1CmFQ3eCTT62tq0qa1wchFQAWcjrg
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Reuben Farrelly" <reuben-lkml@reub.net>
Cc: <linux-kernel@vger.kernel.org>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Stephen Hemminger" <shemminger@osdl.org>
X-OriginalArrivalTime: 08 Jan 2006 08:19:48.0197 (UTC) FILETIME=[4A293950:01C6142C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>> 2. Notice above how the sky2 driver is being bailed out:
>> 
>> ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) -> IRQ 177
>> sky2 Cannot find PowerManagement capability, aborting.
>> sky2: probe of 0000:04:00.0 failed with error -5
>>
>> ...so I'm not sure if it's the driver or something else 
>> like ACPI that is the root cause.
>
>Could be acpi, yes.

Any difference if you boot with "acpi=off" or "pci=noacpi"?
If that fixes it, then ACPI is shomehow involved in the problem.
If it doesn't fix it, then ACPI is not involved.

thanks,
-Len
