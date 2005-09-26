Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVIZGKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVIZGKQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 02:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbVIZGKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 02:10:16 -0400
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:10766 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S932397AbVIZGKP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 02:10:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFT][PATCH] i386 per cpu IDT (2.6.12-rc1-mm1)
Date: Mon, 26 Sep 2005 01:09:55 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D5D@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFT][PATCH] i386 per cpu IDT (2.6.12-rc1-mm1)
Thread-Index: AcXB+3vkuv8Qgj1mRS2DGL25NlwzcAAYXyMg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>, "Andi Kleen" <ak@suse.de>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Raj, Ashok" <ashok.raj@intel.com>, <bjorn.helgaas@hp.com>
X-OriginalArrivalTime: 26 Sep 2005 06:09:55.0768 (UTC) FILETIME=[EA8CEB80:01C5C260]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zwane,
Great news, thanks! I will start testing it, pretty sure I can arrange
MSI devices, too.
As for your comment about vector allocation policy - allocation on the
node where device resides does sound logical to me...
Regards,
--Natalie 
> On Sun, 25 Sep 2005, Zwane Mwaikambo wrote:
> 
> > Apologies for the long periods between updates, i've been 
> doing some 
> > relocating.
> > 
> > Changes since last post:
> > 
> > * Current interrupt handling domain is still on a node 
> basis, although 
> > i have moved over to dynamically allocated per cpu IDTs.
> 
> One thing i have to fix here is alignment of cpu_idt_table, 
> since the per cpu allocator can't guarantee much in that regard.
> 
