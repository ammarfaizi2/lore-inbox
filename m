Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264656AbTIDD4R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264644AbTIDD4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:56:17 -0400
Received: from fmr09.intel.com ([192.52.57.35]:41164 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S264656AbTIDD4G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:56:06 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: 2.4.22-xx powerdown oddities
Date: Wed, 3 Sep 2003 23:55:57 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCFA@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.22-xx powerdown oddities
Thread-Index: AcNo5k6OrJMQnA6OTdK5eXXhQnqFwAJsWLnQ
From: "Brown, Len" <len.brown@intel.com>
To: "Luciano Miguel Ferreira Rocha" <luciano@lsd.di.uminho.pt>,
       <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 04 Sep 2003 03:55:58.0552 (UTC) FILETIME=[72F15580:01C37298]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luciano,
This does sound like a regression.
Can I trouble you to dump the info into a bugzilla report so we can make
sure it stays in the queue and gets fixed?

Thanks,
-Len
---
Please file a bug at http://bugzilla.kernel.org/
Category: Power Management
Componenet: ACPI

Please attach the output from dmidecide, available in /usr/sbin/, or
here: 
http://www.nongnu.org/dmidecode/

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar
.gz

Please attach /proc/interrupts and the dmesg output showing the failure,
if possible.


> -----Original Message-----
> From: Luciano Miguel Ferreira Rocha [mailto:luciano@lsd.di.uminho.pt] 
> Sent: Friday, August 22, 2003 12:25 PM
> To: linux-kernel@vger.kernel.org
> Subject: 2.4.22-xx powerdown oddities
> 
> 
> 
> Hello,
> 
> I have a problem powering down my Asus L8400 laptop with kernels
> 2.4.22-xx. While 2.4.21 worked OK (with vanilla ACPI or sf.net acpi),
> 2.4.22-pre8, 2.4.22-pre10, 2.4.22-rc2, 2.4.22-rc2-ac1 and 2.4.22-dis7
> (my current one) show the same problem.
> 
> The problem is that instead of powering down, after "Power 
> down." shows up,
> the kernel shows:
> 
> nsc-ircc, Suspending
> Trying to free free IRQ3
> Trying to free free DMA3
