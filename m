Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbUCMXgV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 18:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263216AbUCMXgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 18:36:21 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:59371 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263214AbUCMXgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 18:36:19 -0500
Message-Id: <200403132334.i2DNY4Tc003924@eeyore.valparaiso.cl>
To: Matt Mackall <mpm@selenic.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bloat report 2.6.3 -> 2.6.4 
In-Reply-To: Your message of "Fri, 12 Mar 2004 17:53:49 MDT."
             <20040312235349.GK20174@waste.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Sat, 13 Mar 2004 20:34:03 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> said:
> On Fri, Mar 12, 2004 at 03:22:06PM -0800, Andrew Morton wrote:
> > Matt Mackall <mpm@selenic.com> wrote:
> > >
> > > 2.6.3 -> 2.6.4
> > > 
> > >    text	   data	    bss	    dec	    hex	filename
> > > 3313135	 660247	 162472	4135854	 3f1bae	vmlinux-2.6.3-c2.6.3
> > > 3342019	 664154	 162344	4168517	 3f9b45	vmlinux-2.6.4-c2.6.3
> > > 
> > > [ Results of size <a> <b>. -c2.6.3 means both kernel images were built
> > > with the 2.6.3 defconfig.
> > 
> > But defconfig was changed between 2.6.3 and 2.6.4.
> 
> Yes, and I'm attempting to compensate for that because defconfig
> changes tend to overwhelm other stuff in the results. 

Use oldconfig?

Or just compare defconfig kernels (with all changes). Or all modules, ...

I.e., what are you trying to measure here?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
