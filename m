Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVH3SDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVH3SDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 14:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVH3SDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 14:03:54 -0400
Received: from fmr13.intel.com ([192.55.52.67]:14061 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932247AbVH3SDx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 14:03:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [patch 2.6.13] swiotlb: add swiotlb_sync_single_range_for_{cpu,device}
Date: Tue, 30 Aug 2005 11:03:35 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0443A4B5@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.13] swiotlb: add swiotlb_sync_single_range_for_{cpu,device}
Thread-Index: AcWtjGewmI6SZeDtQzm5Up2Hu3KK2wAAHEww
From: "Luck, Tony" <tony.luck@intel.com>
To: "John W. Linville" <linville@tuxdriver.com>,
       <linux-kernel@vger.kernel.org>
Cc: "Andi Kleen" <ak@suse.de>, <discuss@x86-64.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 30 Aug 2005 18:03:39.0168 (UTC) FILETIME=[2621F200:01C5AD8D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+swiotlb_sync_single_range_for_cpu(struct device *hwdev, 
>+swiotlb_sync_single_range_for_device(struct device *hwdev, 

Huh?  These look identical ... same args, same code, just a
different name.

-Tony
