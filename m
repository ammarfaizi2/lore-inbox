Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbULNScl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbULNScl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbULNSck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:32:40 -0500
Received: from fmr16.intel.com ([192.55.52.70]:14977 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261591AbULNScc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 13:32:32 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 0/3] NUMA boot hash allocation interleaving
Date: Tue, 14 Dec 2004 10:32:20 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F028C1639@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 0/3] NUMA boot hash allocation interleaving
Thread-Index: AcTiBwooZ9xYPWlJRbOUe/+bbg4tGwAA7Ubw
From: "Luck, Tony" <tony.luck@intel.com>
To: "Brent Casavant" <bcasavan@sgi.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Cc: <linux-ia64@vger.kernel.org>, <ak@suse.de>
X-OriginalArrivalTime: 14 Dec 2004 18:32:22.0370 (UTC) FILETIME=[40407420:01C4E20B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>this behavior is turned on by default only for IA64 NUMA systems

>A boot line parameter "hashdist" can be set to override the default
>behavior.


Note to node hot-plug developers ... if this patch goes in you
will also want to disable this behaviour, otherwaise all nodes
become non-removeable (unless you can transparently re-locate the
physical memory backing all these tables).

-Tony
