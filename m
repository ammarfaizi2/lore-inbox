Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752384AbWAFFgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbWAFFgs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 00:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWAFFgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 00:36:48 -0500
Received: from fmr16.intel.com ([192.55.52.70]:45978 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1752384AbWAFFgq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 00:36:46 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Re. 2.6.15-mm1
Date: Fri, 6 Jan 2006 00:36:18 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30059D3B5D@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re. 2.6.15-mm1
Thread-Index: AcYSSjizY+I2VSIZR+O2kTWH1eOoQgANooZQ
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Alexander Gran" <alex@zodiac.dnsalias.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       "Adam Belay" <ambx1@neo.rr.com>, <reiserfs-dev@namesys.com>,
       "Dave Airlie" <airlied@linux.ie>,
       "Vladimir V. Saveliev" <vs@namesys.com>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 06 Jan 2006 05:36:21.0013 (UTC) FILETIME=[1FCC3450:01C61283]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Jan  5 16:22:38 t40 kernel: pnp: PnP ACPI init
>> Jan  5 16:22:38 t40 kernel: pnp: PnPACPI: unknown resource type 7
>> Jan  5 16:22:38 t40 kernel: pnp: PnPACPI: unknown resource type 7
>> Jan  5 16:22:39 t40 last message repeated 10 times
>> Jan  5 16:22:39 t40 kernel: pnp: PnP ACPI: found 0 devices
>
>pnpacpi is unhappy.

pnpacpi is fixed:
http://lkml.org/lkml/2006/1/5/287

>> Jan  5 16:22:43 t40 kernel: **** SET: Misaligned resource pointer: f7db5502 
>
>acpi is unhappy.

Yes, that one is ours.  We'll track it here:

http://bugme.osdl.org/show_bug.cgi?id=5841

thanks,
-Len
