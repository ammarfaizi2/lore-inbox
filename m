Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVFNXRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVFNXRC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 19:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVFNXRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 19:17:02 -0400
Received: from fmr16.intel.com ([192.55.52.70]:20954 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261408AbVFNXQx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 19:16:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fwd: hpet patches
Date: Tue, 14 Jun 2005 16:16:22 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6004F7837A@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fwd: hpet patches
Thread-Index: AcVxNl2gw5CIZwAuRGO6OrZdXxKQdwAAHEWA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: "Bob Picco" <bob.picco@hp.com>, "Andrew Morton" <akpm@osdl.org>,
       "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Jun 2005 23:15:39.0688 (UTC) FILETIME=[FA9FDA80:01C57136]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From: Jon Smirl [mailto:jonsmirl@gmail.com] 
>Sent: Tuesday, June 14, 2005 4:11 PM
>To: Pallipadi, Venkatesh
>Cc: Bob Picco; Andrew Morton; lkml
>Subject: Re: Fwd: hpet patches
>
>On 6/14/05, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
>> OK. I was thinking PCI fixup is to late in the initialization for
>> HPET fixup. But, we should be OK with a new ACPI_FIXUP macro. My only
>> other concern is, we should safely fallback to PIT, when our fixed_up
>> HPET address isn't right.
>
>If we're keying off from the PCI ID for the chip, how can it not have
>the device? On the other hand, it would probably be good to always do
>a little test on the HPET and fall back to the PIT if the HPET is
>dead.

HPET device itself can be there. But, it can appear in different 
addresses. Most commonly used address is 0xfed00000. But, it can be 
different as well. 

Thanks,
Venki
