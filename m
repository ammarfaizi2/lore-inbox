Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTJAEaj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 00:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTJAEaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 00:30:39 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:4857 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S261906AbTJAEag convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 00:30:36 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Date: Tue, 30 Sep 2003 21:30:31 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Thread-Index: AcOHyfaFPxuIoJZfRHmmFk9i7sFC0gAB7gbg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Jamie Lokier" <jamie@shareable.org>
Cc: <davej@redhat.com>, <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       <richard.brunner@amd.com>
X-OriginalArrivalTime: 01 Oct 2003 04:30:32.0285 (UTC) FILETIME=[C02320D0:01C387D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Refusing to boot would be best I think.  Fixing it up anyway would be
OK
> too.
> 
I agree.

> Ignoring the problem in kernel and/or userspace could be viewed as a
> response to pilot error but as always it would be nice if, given a
choice,
> we can help the pilot.
Yes. It would kind to tell the pilot about the errata of the engine (and
refuse to start), rather than telling him that the engine might break
down anytime after the takeoff.

	Jun

> -----Original Message----
> From: Andrew Morton [mailto:akpm@osdl.org]
> Sent: Tuesday, September 30, 2003 8:14 PM
> To: Jamie Lokier
> Cc: Nakajima, Jun; davej@redhat.com; torvalds@osdl.org; linux-
> kernel@vger.kernel.org; richard.brunner@amd.com
> Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch
errata
> patch
> 
> Jamie Lokier <jamie@shareable.org> wrote:
> >
> > Nakajima, Jun wrote:
> > > Oh, I thought you already closed this issue and you were
discussing a
> > > different thing.
> > >
> > > I agree. The kernel should fix up userspace for this CPU errata.
> >
> > Our question is whether kernels configured specifically for non-AMD
> > (e.g. Winchip or Elan kernels) must have the AMD fixup code (it is a
> > few hundred bytes), refuse to boot on AMD, ignore the problem, or
work
> > but not fix up userspace.
> 
> Refusing to boot would be best I think.  Fixing it up anyway would be
OK
> too.
> 
> Ignoring the problem in kernel and/or userspace could be viewed as a
> response to pilot error but as always it would be nice if, given a
choice,
> we can help the pilot.
