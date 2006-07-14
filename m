Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422680AbWGNSSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbWGNSSr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWGNSSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:18:46 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.143]:7960 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1422680AbWGNSSp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:18:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Athlon64 + Nforce4 MCE panic
Date: Fri, 14 Jul 2006 11:18:38 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00E48CFD9@hqemmail02.nvidia.com>
In-Reply-To: <20060714093749.07529924.rumi_ml@rtfm.hu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Athlon64 + Nforce4 MCE panic
Thread-Index: AcanGGbtEZILV8CfRQSrOg7NDV9ohAAWKMbg
From: "Allen Martin" <AMartin@nvidia.com>
To: "Rumi Szabolcs" <rumi_ml@rtfm.hu>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Jul 2006 18:18:39.0808 (UTC) FILETIME=[EE513400:01C6A771]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1x Asrock NF4G-SATA2 motherboard 
> (http://www.asrock.com/product/939NF4G-SATA2.htm)
> 1x Athlon64 "Venice" 3500+ with a huge Arctic cooler
> 1x Corsair kit of 2 matched 512MB DDR400 modules
> 1x Seagate 160GB SATA drive
> 1x well ventilated Chieftec rackmount chassis w/PSU

You don't have any PATA devices at all?  SATA is a lot more resilient to
this type of problem.

> So I have a reason to believe that this could be a chipset specific
> problem which not only affects me but quite a number of NF4 users,
> most of which (using Windo$$$) will probably never know why their
> system suddenly hung after some weeks or months of use...

Windows will generate a bugcheck on an MCA exception just like Linux.
We have really detailed statistics on Windows bugchecks due to OCA, so I
know this is not a widespread issue at least on Windows.


> Or maybe just a neutrino hit to the CPU?
> What do you think?

The stack trace will almost always tell you exactly what device timed
out the PIO, you should start there.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
