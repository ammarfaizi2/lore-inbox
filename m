Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTETSuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 14:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263872AbTETSuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 14:50:51 -0400
Received: from fmr02.intel.com ([192.55.52.25]:3069 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263871AbTETSut convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 14:50:49 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: RFC Proposal to enable MSI support in Linux kernel
Date: Tue, 20 May 2003 12:03:36 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502413621D@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RFC Proposal to enable MSI support in Linux kernel
Thread-Index: AcMevJMPZKvEd7y3TwGhI30xcNdxJgARSoWw
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Martin Schlemmer" <azarah@gentoo.org>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: "KML" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 May 2003 19:03:37.0115 (UTC) FILETIME=[849356B0:01C31F02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

The vector-based patch is based on 2.5.65. We can port this patch to later kernel version if required. Please let us know.

Thanks,
Tom 

-----Original Message-----
From: Martin Schlemmer [mailto:azarah@gentoo.org]
Sent: Tuesday, May 20, 2003 3:37 AM
To: Nguyen, Tom L
Cc: KML
Subject: RE: RFC Proposal to enable MSI support in Linux kernel


On Mon, 2003-05-19 at 23:22, Nguyen, Tom L wrote:
> Here is a patch containing the vector-based indexing part only.
> 

Do not seem to patch even against 2.5.66 ...

> Thanks,
> Tom
> 
> 
> 
> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@linuxpower.ca]
> Sent: Wednesday, May 14, 2003 12:54 PM
> To: Nakajima, Jun
> Cc: Nguyen, Tom L; linux-kernel@vger.kernel.org; Saxena, Sunil; Mallick,
> Asit K; Carbonari, Steven
> Subject: RE: RFC Proposal to enable MSI support in Linux kernel
> 
> 
> On Wed, 14 May 2003, Nakajima, Jun wrote:
> 
> > That's a good idea, and that's the way we did this (we added MSI 
> > support on top of the vector-based indexing). If people are interested in 
> > the vector-based indexing (i.e. provide the vector number to device 
> > drivers (non-legacy drivers only) instead of IRQ) for some other uses, we 
> > would like to discuss possible cleaner implementations.
> > 
> > Long will post a patch containing the vector-based indexing part only. 
> 
> Thanks! It'd be a lot easier to test the core changes too. What do you 
> mean by non legacy?
> 
> 	Zwane
-- 
Martin Schlemmer

