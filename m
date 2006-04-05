Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWDEWuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWDEWuf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWDEWuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:50:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:25099 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932096AbWDEWue convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:50:34 -0400
X-IronPort-AV: i="4.04,91,1144047600"; 
   d="scan'208"; a="20445385:sNHT37330734"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.17-rc1-mm1
Date: Wed, 5 Apr 2006 15:50:30 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F06290233@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.17-rc1-mm1
Thread-Index: AcZY/HfZ87ohMQBARrmZvtfEnA+DKAABsFAw
From: "Luck, Tony" <tony.luck@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Cc: "Zou, Nanhai" <nanhai.zou@intel.com>, "Andrew Morton" <akpm@osdl.org>,
       "LKML" <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 05 Apr 2006 22:50:33.0662 (UTC) FILETIME=[58D2C5E0:01C65903]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the VGA_MAP_MEM(vga_vram_end) is just bogus -- it's not
> that we need to map the memory starting at vga_vram_end.  I think
> it would cleaner (though much more intrusive) to do something like
> the patch below, which basically just hard-codes (base, size)
> rather than (base, end).

This patch works for me on ia64/Tiger

-Tony
