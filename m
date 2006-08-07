Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWHGQXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWHGQXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWHGQXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:23:36 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:8205 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S932202AbWHGQXf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:23:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Date: Mon, 7 Aug 2006 11:23:16 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0C87@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <200608071817.13318.ak@suse.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Thread-Index: Aca6PPfRXsGrZ8xWTiq0S68dLxef1gAABV/g
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Aug 2006 16:23:17.0126 (UTC) FILETIME=[C9FDC260:01C6BA3D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 4k being a humble maximum is definitely a relative term 
> here, but on 
> > the system with "only" 64 or 128 processors the cpu*224 
> would be much 
> > higher
> > :) However, maybe CONFIG_TINY that Andi suggested would 
> leverage this 
> > number also. What do you think, Eric?
> 
> Best would be something dynamic - kernels should be self 
> tuning, not require that much CONFIG magic.
> 
> Just PCI hotplug gives me headaches with this.
> 
> Maybe we just need growable per CPU data.
> 
Yes, evaluating dynamically would be best... Should be ACPI job I
suppose, including accounting of all possible hot plug controllers.
Unisys boxes have plenty of them, I can look into possible scenarios.

--Natalie
