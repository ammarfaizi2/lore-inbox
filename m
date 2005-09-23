Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbVIWS1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVIWS1z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVIWS1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:27:55 -0400
Received: from fmr16.intel.com ([192.55.52.70]:53702 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751127AbVIWS1y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:27:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [patch 2.6.13 0/6] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Date: Fri, 23 Sep 2005 11:27:26 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F04795ED2@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.13 0/6] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Thread-Index: AcXAa88QFkeRIr4hSlqPEtFr+kd8JgAACN6w
From: "Luck, Tony" <tony.luck@intel.com>
To: "John W. Linville" <linville@tuxdriver.com>,
       "Christoph Hellwig" <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>, <linux-ia64@vger.kernel.org>, <ak@suse.de>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 23 Sep 2005 18:27:28.0656 (UTC) FILETIME=[74168100:01C5C06C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It should just go away once the GFP_DMA32 code is merged.
>
>Is that the plan?  I suppose it makes sense.
>
>So, move it to driver/pci/swiotlb.c?  Or just leave it where it is?
>
>Either way, I'll redo the other patches to reflect the correct
>location.

I don't have a good (or in fact any) understanding of the impact
of GFP_DMA32 on ia64.  People tell me it will all be good, but I'd
like to hear from someone running it.

If it is good, and if it is coming soon, then there is no point
moving swiotlb.  But I don't know the answers to either of those
questions.

-Tony
