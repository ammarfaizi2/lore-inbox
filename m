Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUEFQOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUEFQOT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 12:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUEFQOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 12:14:19 -0400
Received: from fmr01.intel.com ([192.55.52.18]:48319 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S261396AbUEFQOM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 12:14:12 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [2.6.6 PATCH] Exposing EFI memory map
Date: Thu, 6 May 2004 09:14:03 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFEB18@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.6 PATCH] Exposing EFI memory map
Thread-Index: AcQzaMtgIjOcjzp2Sl2Dm8jPJ7JiXQAG/mBQ
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Matt Domsch" <Matt_Domsch@dell.com>, "Sourav Sen" <souravs@india.hp.com>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 May 2004 16:14:03.0787 (UTC) FILETIME=[2634ADB0:01C43385]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2) Can the memory map output ever be larger than PAGE_SIZE (lower
> limit is 4KB on x86)?  If not, what guarantees that?  If so, you need
> your own read mechanism rather than the generic sysfs one.

There are no size guarantees with the EFI memory map.  It could
be of various sizes...

matt

