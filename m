Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130063AbQLZIhi>; Tue, 26 Dec 2000 03:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbQLZIh3>; Tue, 26 Dec 2000 03:37:29 -0500
Received: from queen.bee.lk ([203.143.12.182]:15113 "EHLO bee.lk")
	by vger.kernel.org with ESMTP id <S130063AbQLZIhV>;
	Tue, 26 Dec 2000 03:37:21 -0500
Date: Tue, 26 Dec 2000 14:06:18 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: recommended gcc compiler version
In-Reply-To: <7sSHKzAmw-B@khms.westfalen.de>
Message-ID: <Pine.LNX.4.21.0012261400290.23467-100000@bee.lk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 24 Dec 2000, Kai Henningsen wrote:

> anuradha@gnu.org (Anuradha Ratnaweera)  wrote on 22.12.00 in <Pine.LNX.4.21.0012221746160.320-100000@bee.lk>:
> 
> > On Fri, 22 Dec 2000, Alan Cox wrote:
> >
> > > For i386
> > >
> > > 2.2.18
> > > 	gcc 2.7.2 or egcs-1.1.2
> >
> > Just a remainder for debian users. There is a debian package gcc272 which
> > is said to be the "GNU C compiler's C part", for "backword compatibility
> > purposes". I recompiled my kernel after an
> >
> >   apt-get install gcc272
> >
> > and after setting
> >
> >   HOSTGCC = gcc272
> >
> > in kernel source tree Makerile.
> 
> I recently compiled 2.2.18 and noticed that make-kpkg (from kernel-package  
> - don't compile kernels on Debian without it!) did that automatically.

That is a very good thing. It would have been even better if the
dependencies of the kernel-package does include gcc272 rather than giving
a "command not found" error when make-kpkg is run without gcc272
installed. It might leave a new user clueless.


Anuradha

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
