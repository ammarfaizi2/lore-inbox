Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVBKWRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVBKWRL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 17:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVBKWRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 17:17:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:47564 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262368AbVBKWRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 17:17:02 -0500
Subject: Re: [PATCH] ppc64: Implement a vDSO and use it for signal
	trampoline #3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200502111910.00725.hpj@urpla.net>
References: <1108002773.7733.196.camel@gaston>
	 <200502111910.00725.hpj@urpla.net>
Content-Type: text/plain
Date: Sat, 12 Feb 2005 09:15:19 +1100
Message-Id: <1108160119.7733.230.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 19:10 +0100, Hans-Peter Jansen wrote:
> Hi Ben,
> 
> are you copyrighting under a new pseudonym? E.g.:
> 
> On Thursday 10 February 2005 03:32, Benjamin Herrenschmidt wrote:
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-work/arch/ppc64/kernel/vdso32/sigtramp.S	2005-02-02
> > 13:28:01.000000000 +1100 @@ -0,0 +1,300 @@
> > +/*
> > + * Signal trampolines for 32 bits processes in a ppc64 kernel for
> > + * use in the vDSO
> > + *
> > + * Copyright (C) 2004 Benjamin Herrenschmuidt
>                                             ^
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-work/arch/ppc64/kernel/vdso32/datapage.S	2005-02-02
> > 13:28:01.000000000 +1100 @@ -0,0 +1,68 @@
> > +/*
> > + * Access to the shared data page by the vDSO & syscall map
> > + *
> > + * Copyright (C) 2004 Benjamin Herrenschmuidt
> 
> Who's that guy?

Hehe, good catch, I'll fix that :)

Thanks,
Ben.


