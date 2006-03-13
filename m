Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWCMWMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWCMWMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWCMWMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:12:23 -0500
Received: from fmr20.intel.com ([134.134.136.19]:13997 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932492AbWCMWMW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:12:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 3/8] [I/OAT] Setup the networking subsystem as a DMA client
Date: Mon, 13 Mar 2006 14:12:12 -0800
Message-ID: <E3A930D59AFC3345AEBA35189102A8A6060E15E9@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 3/8] [I/OAT] Setup the networking subsystem as a DMA client
Thread-Index: AcZE6qlkZY8d97LtQ3eoEZQHdPUsTgCAG3dA
From: "Leech, Christopher" <christopher.leech@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
X-OriginalArrivalTime: 13 Mar 2006 22:12:15.0559 (UTC) FILETIME=[2F8BD570:01C646EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  +#ifdef CONFIG_NET_DMA
> >  +#include <linux/dmaengine.h>
> >  +#endif
> 
> There are still a number of instances of this in the patch 
> series.  Did you
> decide to keep the ifdefs in there for some reason?

No, I just missed them in header files.  Thanks. 
