Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282076AbRKWHTy>; Fri, 23 Nov 2001 02:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282077AbRKWHTo>; Fri, 23 Nov 2001 02:19:44 -0500
Received: from ns01.netrox.net ([64.118.231.130]:30348 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S282076AbRKWHTd>;
	Fri, 23 Nov 2001 02:19:33 -0500
Subject: Re: Kernel-module version mismatch
From: Robert Love <rml@tech9.net>
To: Kashif <kashif@and-or.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <GOEAKAFMBJEILCMEHMLAIEPACAAA.kashif@and-or.com>
In-Reply-To: <GOEAKAFMBJEILCMEHMLAIEPACAAA.kashif@and-or.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 23 Nov 2001 02:17:58 -0500
Message-Id: <1006499899.1871.4.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-23 at 02:15, Kashif wrote:
>  I have recently upgraded from Redhat Linux 7.1 kernel
> version 2.4.2 to 2.4.10. I am trying to insert a
> driver module "code.o" (which was perfectly fine in the previous kernel)into
> the new Kernel. But on insmod i get
> an error:-
> 
> "kernel-module version mismatch. code.o was compiled
> for kernel version 2.4.2-2 while this kernel is
> version 2.4.10"
> 
>  Although i am able to insert the driver module with
> the -f(force) switch. But this results in a faulty
> operation of the driver module. Rather i get an OOps message
> I have tried recompiling the source of gcc in this new kernel but
> that has also not solved this problem. Help will be
> appreciated! Thank you.

Not sure what recompiling gcc would achieve ... you need to recompile
this code.o module under your new RedHat kernel.

	Robert Love

