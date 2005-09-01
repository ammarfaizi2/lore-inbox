Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbVIAOSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbVIAOSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbVIAOSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:18:53 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:33800 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S965138AbVIAOSw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:18:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Re: [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Date: Thu, 1 Sep 2005 09:15:51 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D0D@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Thread-Index: AcWu3YSQKU9/v1U8RESrTUxqmVB2sQAHnSJA
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: <mika.penttila@kolumbus.fi>, "Andi Kleen" <ak@suse.de>
Cc: <shaohua.li@intel.com>, <zwane@arm.linux.org.uk>, <ashok.raj@intel.com>,
       <akpm@osdl.org>, <lhcs-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, <hotplug_sig@lists.osdl.org>
X-OriginalArrivalTime: 01 Sep 2005 14:15:52.0276 (UTC) FILETIME=[A8DB3940:01C5AEFF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We should probably also not to try to boot disabled cpus in 
> smp_boot_cpus()...
> 
> --Mika
> 

Good point, probably by not setting phys_cpu_present_map for those in
MP_processor_info()...
Thanks,
--Natalie

> 
