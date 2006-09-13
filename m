Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWIMQcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWIMQcS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWIMQcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:32:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:51047 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1750719AbWIMQcR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:32:17 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,160,1157353200"; 
   d="scan'208"; a="126176923:sNHT2031446655"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: speedstep-centrino broke
Date: Wed, 13 Sep 2006 09:31:37 -0700
Message-ID: <EB12A50964762B4D8111D55B764A84549560B6@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: speedstep-centrino broke
Thread-Index: AcbWrqWzAYpvC3tfScWPMORIkNpqUQAotGtA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Ben B" <kernel@bb.cactii.net>, <linux-kernel@vger.kernel.org>,
       <davej@codemonkey.org.uk>
X-OriginalArrivalTime: 13 Sep 2006 16:31:38.0325 (UTC) FILETIME=[16036850:01C6D752]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Ben B
>Sent: Tuesday, September 12, 2006 12:38 PM
>To: linux-kernel@vger.kernel.org; davej@codemonkey.org.uk
>Subject: speedstep-centrino broke
>
>Hi,
>
>My HP notebook decided that its BIOS upgrade would break
>speedstep-centrino, and trying to load the module gives me a "no such
>device" error. This is with various combinations of kernel config
>relating to cpufreq. Also tried acpi-cpufreq with the same error.
>
>I suspect that the new bios is broken, but perhaps it's correct and the
>linux driver is missing something?
>
>Anyway, relevent info below.
>

Probably BIOS broke something during the update. Can you send me the
acpidump output from your system (acpidump is avlbl in latest pmtools
here - http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/ )

It will be great if you can open a bugzilla entry at bugme.osdl.org
under ACPI power-processor and attach all this info. there. It will help
to keep track of the bug information in a better way.

Thanks,
Venki
