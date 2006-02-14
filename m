Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbWBNFsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbWBNFsA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbWBNFr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:47:59 -0500
Received: from fmr20.intel.com ([134.134.136.19]:35475 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030296AbWBNFr5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:47:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Compaq X1050 multiple suspend problems (ACPI, PS2)
Date: Tue, 14 Feb 2006 13:47:26 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840AEE20B9@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compaq X1050 multiple suspend problems (ACPI, PS2)
thread-index: AcYxHCl2dO3yGVLRTgaGzZb4AqUYoAADGxBA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-acpi@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Feb 2006 05:47:29.0277 (UTC) FILETIME=[243972D0:01C6312A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I have not seen any ACPI errors other than during suspend/resume.
>
>Tried ec_intr=0 option on the command line, same problem.
>
>ACPI_EC_DELAY=100 patch did not help either, same or at least similar 
>problem. Output attached.
>

Please try boot with lapic. I'm NOT sure if it is irq related resume
issue.
After resume, please try cat /proc/acpi/embedded_controller/*/info.
Please test if it do the trick.

If still not, please file a bug in ACPI category on bugzilla.kernel.org.


Thanks,
Luming
