Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWJEADt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWJEADt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 20:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWJEADs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 20:03:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:18756 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1751242AbWJEADs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 20:03:48 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,257,1157353200"; 
   d="scan'208"; a="140573996:sNHT9638451900"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] mm: balance dirty pages
Date: Thu, 5 Oct 2006 04:03:35 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC3F3FD1@mssmsx411>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE: [PATCH] mm: balance dirty pages
Thread-Index: AcboEbPm3fKIsNAGT7m0GoBF57EX3g==
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Oct 2006 00:03:39.0159 (UTC) FILETIME=[B5F70270:01C6E811]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The throughput of iozone benchmark is changed as
 
            serial          random
write    -55%         -99% 
read     +60%       +13%
 
after "[PATCH] mm: balance dirty pages".
iozone is running with option -B (using mmap) for file size 120% of RAM.

Leonid
