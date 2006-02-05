Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWBET0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWBET0G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 14:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWBET0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 14:26:06 -0500
Received: from fmr21.intel.com ([143.183.121.13]:17345 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751207AbWBET0D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 14:26:03 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: acpi_cpufreq broken after _PDC patch
Date: Sun, 5 Feb 2006 11:24:29 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB600724835A@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: acpi_cpufreq broken after _PDC patch
Thread-Index: AcYqgkJetunJYikHQz+uDI3NxeoEoAABrY8Q
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Gerhard Schrenk" <deb.gschrenk@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Feb 2006 19:24:32.0564 (UTC) FILETIME=[CAA9A740:01C62A89]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Gerhard Schrenk [mailto:deb.gschrenk@gmx.de] 
>Sent: Sunday, February 05, 2006 10:07 AM
>To: Pallipadi, Venkatesh
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: acpi_cpufreq broken after _PDC patch
>
>* Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> 
>[2006-02-04 22:41]:
>
>> You need to configure X86_SPEEDSTEP_CENTRINO_ACPI as well. That is
>> required to make speedstep-centrino work with ACPI.
>
>Yes. Thanks. This option was masked by it's strange dependency
>
>(...) && (X86_SPEEDSTEP_CENTRINO!=y || ACPI_PROCESSOR!=m)
>

Yes. Agreed. There is some cleanup required for all these multiple
configuration options for one single feature. 

>Unfortunately I had exactly this configuration. Now with
>ACPI_PROCESSOR=y the speedstep-centrino driver works for me 
>*much* better
>than acpi-cpufreq! So no need for acpi-cpufreq driver here any more.
>

That's great!! 

Thanks,
Venki
