Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264107AbTEGRyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbTEGRyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:54:52 -0400
Received: from s-smtp-osl-01.bluecom.no ([62.101.193.35]:7907 "EHLO
	s-smtp-osl-01.bluecom.no") by vger.kernel.org with ESMTP
	id S264107AbTEGRyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:54:51 -0400
Subject: Re: The disappearing sys_call_table export.
From: petter wahlman <petter@bluezone.no>
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0305071247360.12878@chaos>
References: <1052321673.3727.737.camel@badeip>
	 <Pine.LNX.4.53.0305071147510.12652@chaos>
	 <1052323711.3739.750.camel@badeip>
	 <Pine.LNX.4.53.0305071247360.12878@chaos>
Content-Type: text/plain
Organization: 
Message-Id: <1052330844.3739.840.camel@badeip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 May 2003 20:07:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 18:59, Richard B. Johnson wrote:
> On Wed, 7 May 2003, petter wahlman wrote:
> 
> > On Wed, 2003-05-07 at 18:00, Richard B. Johnson wrote:
> > > On Wed, 7 May 2003, petter wahlman wrote:
> > >
> > > >
> > > > It seems like nobody belives that there are any technically valid
> > > > reasons for hooking system calls, but how should e.g anti virus
> > > > on-access scanners intercept syscalls?
> > > > Preloading libraries, ptracing init, patching g/libc, etc. are
> > >   ^^^^^^^^^^^^^^^^^^^
> > >                     |________  Is the way to go. That's how
> > > you communicate every system-call to a user-mode daemon that
> > > does whatever you want it to do, including phoning the National
> > > Security Administrator if that's the policy.
> > >
> > > > obviously not the way to go.
> > > >
> > >
> > > Oviously wrong.
> >
> >
> > And how would you force the virus to preload this library?
> >
> > -p.
> >
> 
> The same way you would force a virus to not be statically linked.
> You make sure that only programs that interface with the kernel
> thorugh your hooks can run on that particular system.
> 

Can you please elaborate.
How would you implement the access control without modifying the
respective syscalls or the system_call(), and would you'r
solution be possible to implement run time?

Regards,

-p.

