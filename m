Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVDFHDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVDFHDM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 03:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVDFHDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 03:03:12 -0400
Received: from fmr15.intel.com ([192.55.52.69]:55191 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S262123AbVDFHDD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 03:03:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.12-rc2-mm1: ACPI=y, ACPI_BOOT=n problems
Date: Wed, 6 Apr 2005 03:01:37 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3002F68228@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.12-rc2-mm1: ACPI=y, ACPI_BOOT=n problems
Thread-Index: AcU54sjnOsa14PZaTKaOOeupgWggewAk9ZdA
From: "Brown, Len" <len.brown@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Reuben Farrelly" <reuben-lkml@reub.net>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 06 Apr 2005 07:01:39.0364 (UTC) FILETIME=[7AF95640:01C53A76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>@Len:
>ACPI=y and ACPI_BOOT=n seems to be a legal configuration (with 
>X86_HT=y), but it breaks into pieces if you try the compilation.

yeah, don't do that:-)
I'm sorry I didn't push the patch to delete CONFIG_ACPI_BOOT earlier.
For now, just enable them both.

thanks,
-Len
