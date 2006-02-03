Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWBCRJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWBCRJZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWBCRJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:09:24 -0500
Received: from fmr20.intel.com ([134.134.136.19]:28380 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751057AbWBCRJX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:09:23 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 1/12] generic *_bit()
Date: Fri, 3 Feb 2006 09:07:47 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F059C0E92@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/12] generic *_bit()
Thread-Index: AcYorOkoykCwtIc2R526E4BWdgndlwANyQ8w
From: "Luck, Tony" <tony.luck@intel.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Akinobu Mita" <mita@miraclelinux.com>,
       "Grant Grundler" <iod00d@hp.com>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 03 Feb 2006 17:07:49.0746 (UTC) FILETIME=[5C937520:01C628E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Intel doesn't care about big endian (cfr. your lkml back issues of January
> > 2006).
> 
> Incorrect.  Intel does actually produce big endian CPUs - most of the
> Intel IXP (ARM based) stuff is big endian.  It just depends which part
> of Intel you're referring to.

Set PSR.be (and DCR.be) to 1 and ia64 becomes a big-endian cpu (which,
IIRC, how HP-UX uses it).

-Tony
