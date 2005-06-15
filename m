Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVFORQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVFORQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 13:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVFORQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 13:16:14 -0400
Received: from fmr13.intel.com ([192.55.52.67]:34237 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261228AbVFORQE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 13:16:04 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fwd: hpet patches
Date: Wed, 15 Jun 2005 10:15:59 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6004FB6BED@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fwd: hpet patches
Thread-Index: AcVxOezyGbyw2HEOROWXQg74wmZxRQAk7Adw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: "Bob Picco" <bob.picco@hp.com>, "Andrew Morton" <akpm@osdl.org>,
       "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Jun 2005 17:15:15.0868 (UTC) FILETIME=[CC3C85C0:01C571CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Jon Smirl [mailto:jonsmirl@gmail.com] 
>Sent: Tuesday, June 14, 2005 4:37 PM
>To: Pallipadi, Venkatesh
>Cc: Bob Picco; Andrew Morton; lkml
>Subject: Re: Fwd: hpet patches
>
>On 6/14/05, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
>> HPET device itself can be there. But, it can appear in different
>> addresses. Most commonly used address is 0xfed00000. But, it can be
>> different as well.
>
>Does Intel build different versions of something like an 82801EB with
>the HPET at different addresses and still have the same part number?
>For a specific part number/PCI ID isn't HPET always in the same place?
>If the HPET is going to be in a different place I would expected the
>chip would have a different PCI ID.
>

The specification for ICH5 has the details about this address
http://www.intel.com/design/chipsets/datashts/25251601.pdf (Chapter 17).
We need to look at specific device address to figure out the HPET base 
address in this case.


Thanks,
Venki
