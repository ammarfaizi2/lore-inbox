Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbWBHWgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbWBHWgu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbWBHWgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:36:50 -0500
Received: from fmr22.intel.com ([143.183.121.14]:59274 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S965213AbWBHWgt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:36:49 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.6 patch] let IA64_GENERIC select more stuff
Date: Wed, 8 Feb 2006 14:35:37 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05A6E3E7@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] let IA64_GENERIC select more stuff
Thread-Index: AcYs+DS9IqDfRJRpTDukxy/9UEr1FwABMOUwAAB9riA=
From: "Luck, Tony" <tony.luck@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Keith Owens" <kaos@sgi.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Jes Sorensen" <jes@sgi.com>
X-OriginalArrivalTime: 08 Feb 2006 22:35:39.0035 (UTC) FILETIME=[FC7386B0:01C62CFF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drifting a little (perhaps).  "make allnoconfig" produces
a config that doesn't compile. Lots or warnings during compile
about implicit declaration of ia64_pfn_valid.  Then link errors
for vmem_map and ia64_pfn_valid.

What's the right thing to do about this?  It's been broken for a
long time (definitely since SPARSE support was added, perhaps longer).


-Tony
