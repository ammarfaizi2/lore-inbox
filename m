Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTLDFoE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 00:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTLDFoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 00:44:04 -0500
Received: from fmr05.intel.com ([134.134.136.6]:54493 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262427AbTLDFoB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 00:44:01 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: If your ACPI-enabled machine does clean shutdown randomly...
Date: Thu, 4 Dec 2003 13:43:54 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720BFF@pdsmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: If your ACPI-enabled machine does clean shutdown randomly...
Thread-Index: AcO1v5VQCK2uHuqKQa2ejl0aWlzSSgEaR3Jw
From: "Yu, Luming" <luming.yu@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>,
       "ACPI mailing list" <acpi-devel@lists.sourceforge.net>,
       "kernel list" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Dec 2003 05:43:55.0312 (UTC) FILETIME=[9AFBBB00:01C3BA29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>...then you probably need this one. (One notebook I have here
>certainly needs it).

You are lucky to have such a laptop which could expose some unknow ACPI bug .
It's great, if you can share some information with us. --Luming

>It seems that acpi likes to report completely bogus value from time to
> time...

It's great, if you can tell us other completely bogus value. I believe It will help us a lot.

>+	if (KELVIN_TO_CELSIUS(tz->temperature) >= 200) {
>+		printk(KERN_ALERT "Are you running CPU or nuclear power plant? ACPI claims CPU temp is %d C. Ignoring.\n", KELVIN_TO_CELSIUS(tz->temperature));
>+		return_VALUE(0);
>+	}
