Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWEATkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWEATkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWEATkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:40:52 -0400
Received: from mga03.intel.com ([143.182.124.21]:59751 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932204AbWEATkw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:40:52 -0400
X-IronPort-AV: i="4.04,169,1144047600"; 
   d="scan'208"; a="30095586:sNHT19430838"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.17-rc1-mm3: time-i386-clocksource-drivers*.patch brokeuserspace apps
Date: Mon, 1 May 2006 15:40:46 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB652DB5E@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17-rc1-mm3: time-i386-clocksource-drivers*.patch brokeuserspace apps
Thread-Index: AcZsnMOz4fl+6aFBSNWPrX1ghysJNwAudDtA
From: "Brown, Len" <len.brown@intel.com>
To: "john stultz" <johnstul@us.ibm.com>,
       "Laurent Riffard" <laurent.riffard@free.fr>
Cc: "Kernel development list" <linux-kernel@vger.kernel.org>,
       "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 01 May 2006 19:40:48.0051 (UTC) FILETIME=[2535E830:01C66D57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>> [root@antares ~]# grep clocksource dmesg-2.6.17-rc*
>> dmesg-2.6.17-rc1-mm1:Time: tsc clocksource has been installed.
>> dmesg-2.6.17-rc1-mm1:Time: acpi_pm clocksource has been installed.
>> dmesg-2.6.17-rc1-mm2:Time: tsc clocksource has been installed.
>> dmesg-2.6.17-rc1-mm2:Time: acpi_pm clocksource has been installed.
>> dmesg-2.6.17-rc1-mm3:Time: tsc clocksource has been installed.
>> dmesg-2.6.17-rc1-mm3:Time: pit clocksource has been installed.
>> dmesg-2.6.17-rc2-mm1:Time: tsc clocksource has been installed.
>> dmesg-2.6.17-rc2-mm1:Time: pit clocksource has been installed.
>
>Hmmm. I'm not sure why the ACPI PM timer isn't showing up. Your .config
>looks good, but I don't see the ACPI PM timer io-port being detected as
>I expect.
>
>Len, has there been any changes to that ACPI code?

Not that I'm aware of.
Is this issue in -mm only, or does this issue show up in Linus' tree?

Note that there have been 0 integrations from the ACPI tree into
Linus tree during the 2.6.17 cycle, so AFAIK 2.6.17 it should behave
like 2.6.16.

-Len
