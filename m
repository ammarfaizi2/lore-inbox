Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVAJBZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVAJBZU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 20:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVAJBZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 20:25:20 -0500
Received: from fmr18.intel.com ([134.134.136.17]:47075 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262040AbVAJBZN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 20:25:13 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] ACPI using smp_processor_id in preemptible code
Date: Mon, 10 Jan 2005 09:24:54 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575F05409@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] ACPI using smp_processor_id in preemptible code
Thread-Index: AcT2lDws2h8c/lm2T4iXYkYRKOS+lwAHG27A
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>,
       "ACPI mailing list" <acpi-devel@lists.sourceforge.net>,
       "kernel list" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Jan 2005 01:25:00.0250 (UTC) FILETIME=[33D6A3A0:01C4F6B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I enabled CPU hotplug and preemptible debugging... now I get...
>
>BUG: using smp_processor_id() in preemptible [00000001] code:
>swapper/0
>caller is acpi_processor_idle+0xb/0x235
> [<c020ba28>] smp_processor_id+0xa8/0xc0
> [<c02338ce>] acpi_processor_idle+0xb/0x235
> [<c02338c3>] acpi_processor_idle+0x0/0x235
> [<c02338ce>] acpi_processor_idle+0xb/0x235
> [<c02338c3>] acpi_processor_idle+0x0/0x235
> [<c02338c3>] acpi_processor_idle+0x0/0x235
> [<c02338c3>] acpi_processor_idle+0x0/0x235
> [<c0101115>] cpu_idle+0x75/0x110
> [<c04f5988>] start_kernel+0x158/0x180
> [<c04f5390>] unknown_bootoption+0x0/0x1e0
It doesn't trouble to me. It's in idle thread.

Thanks,
Shaohua
