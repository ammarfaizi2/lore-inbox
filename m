Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbVKEBxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbVKEBxD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 20:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVKEBxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 20:53:03 -0500
Received: from fmr24.intel.com ([143.183.121.16]:42133 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751379AbVKEBxB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 20:53:01 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Fri, 4 Nov 2005 17:52:29 -0800
Message-ID: <01EF044AAEE12F4BAAD955CB75064943051354DA@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Thread-Index: AcXhWkA1T53ZoYq0Q6KM5d6mi9N23QAT3E/A
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Andy Nelson" <andy@thermo.lanl.gov>
Cc: <akpm@osdl.org>, <arjan@infradead.org>, <arjanv@infradead.org>,
       <haveblue@us.ibm.com>, <kravetz@us.ibm.com>,
       <lhms-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, <mbligh@mbligh.org>, <mel@csn.ul.ie>,
       <mingo@elte.hu>, <nickpiggin@yahoo.com.au>
X-OriginalArrivalTime: 05 Nov 2005 01:52:30.0155 (UTC) FILETIME=[94C569B0:01C5E1AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds Sent: Friday, November 04, 2005 8:01 AM


>If I remember correctly, ia64 used to suck horribly because Linux had
to 
>use a mode where the hw page table walker didn't work well (maybe it
was 
>just an itanium 1 bug), but should be better now. But x86 probably
kicks 
>its butt.

I don't remember a difference of more than (roughly) 30 percentage
points even on first generation Itaniums (using hugetlb vs normal
pages). And few more percentage points when walker was disabled. Over
time the page table walker on IA-64 has gotten more aggressive.


...though I believe that 30% is a lot of performance.

-rohit
