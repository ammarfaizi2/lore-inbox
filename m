Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUARQwi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 11:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbUARQwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 11:52:38 -0500
Received: from fmr01.intel.com ([192.55.52.18]:27558 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264129AbUARQwf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 11:52:35 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: ACPI broken on all 9 of my machines :(
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Sun, 18 Jan 2004 11:52:26 -0500
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC89EF@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI broken on all 9 of my machines :(
Thread-Index: AcPcKFSi/zcobACISPyLWSzwUeBn6gBtzcng
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Walrond" <andrew@walrond.org>, <linux-kernel@vger.kernel.org>
Cc: <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 18 Jan 2004 16:52:27.0123 (UTC) FILETIME=[74131C30:01C3DDE3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrew for your offer to help.

The best known method we have for improving ACPI in Linux is to address
first the issues that break many systems.  Your plans to take a survey
of failures on systems close to you is a good idea -- perhaps it will
point out some common failures and help prioritize our work.  Specific
failures are best filed in bugzilla, category="Power Management",
component=ACPI; and discussed on acpi-devel@lists.sourceforge.net.
While LKML is a good place to attempt to raise awareness, it isn't the
best tool for actual debugging.

Regarding the big picture.  Linux needs to reach the state where OEMs
submit their systems to Linux Distro's compliance test suites _before_
they're shipped.  The distros and their compliance test suites need to
include ACPI functionality.  This will address the non-trivial issue of
systems being engineered to match Windows ACPI implementation.  Of
course to get to that point we first need to improve the quality of ACPI
in Linux so that the Distros have a hope of successfully deploying it.
Thank you for your help in this effort.

-Len Brown


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Andrew Walrond
> Sent: Friday, January 16, 2004 6:58 AM
> To: linux-kernel@vger.kernel.org
> Subject: ACPI broken on all 9 of my machines :(
> 
> 
> While investigating an ACPI problem (see another thread) it 
> occured to me that 
> of the 7 different machines I have in my immediate workspace, 
> none of them 
> work properly with ACPI in latest 2.4 or 2.6 kernels. I have 
> P3, dual P3, P4, 
> dual HT Xeons, Opteron and VIA Samuel based motherboards, 
> Thinkpads A21p and 
> A31p, and none of them work properly with ACPI. 100% failure.
> 
> Am I just unlucky? Or is this the general experience?
> 
> I have indeed bugzilled some of the problems, but will do a 
> complete fresh set 
> of tests on all the different types of machines, and present 
> the results 
> here.
> 
> Andrew Walrond
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
