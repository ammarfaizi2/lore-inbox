Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbTENTpD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbTENTpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:45:02 -0400
Received: from fmr02.intel.com ([192.55.52.25]:9469 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262486AbTENTpB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:45:01 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: RFC Proposal to enable MSI support in Linux kernel
Date: Wed, 14 May 2003 12:57:37 -0700
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB56401E451D2@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RFC Proposal to enable MSI support in Linux kernel
Thread-Index: AcMaTBBPym4hZIQtS9mzSAFnOQ0xbgAAHDXA
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>
X-OriginalArrivalTime: 14 May 2003 19:57:37.0783 (UTC) FILETIME=[11AF8870:01C31A53]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's a good idea, and that's the way we did this (we added MSI support on top of the vector-based indexing). If people are interested in the vector-based indexing (i.e. provide the vector number to device drivers (non-legacy drivers only) instead of IRQ) for some other uses, we would like to discuss possible cleaner implementations.

Long will post a patch containing the vector-based indexing part only. 

Thanks,
Jun

> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@linuxpower.ca]
> Sent: Wednesday, May 14, 2003 11:58 AM
> To: Nguyen, Tom L
> Cc: linux-kernel@vger.kernel.org; Saxena, Sunil; Mallick, Asit K; Nakajima,
> Jun; Carbonari, Steven
> Subject: Re: RFC Proposal to enable MSI support in Linux kernel
> 
> Is it possible for you to split up the vector based indexing and the MSI
> support? There are other uses for such an indexing scheme as opposed to
> irq based.
> 
> 	Zwane
> --
> function.linuxpower.ca
