Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTJACXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 22:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTJACXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 22:23:20 -0400
Received: from fmr09.intel.com ([192.52.57.35]:14842 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261877AbTJACXT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 22:23:19 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Date: Tue, 30 Sep 2003 19:23:14 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AFCE@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Thread-Index: AcOHwJToeVDJPDRKTO+kS/ahvBW+egAAdsEg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <jamie@shareable.org>, <davej@redhat.com>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <richard.brunner@amd.com>
X-OriginalArrivalTime: 01 Oct 2003 02:23:14.0611 (UTC) FILETIME=[F7BA9030:01C387C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I thought you already closed this issue and you were discussing a
different thing.

I agree. They kernel should fix up userspace for this CPU errata.

	Jun

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org]
> Sent: Tuesday, September 30, 2003 7:07 PM
> To: Nakajima, Jun
> Cc: jamie@shareable.org; davej@redhat.com; torvalds@osdl.org; linux-
> kernel@vger.kernel.org; richard.brunner@amd.com
> Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch
errata
> patch
> 
> "Nakajima, Jun" <jun.nakajima@intel.com> wrote:
> >
> >  > I think we should fix up userspace.
> >  What do you mean by this? Patch user code at runtime (it's much
more
> >  complex than it sounds) or remove prefetch instructions from
userspace?
> 
> Detect when user code stumbles over this CPU errata and make it look
like
> nothing happened.

