Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbVBYQxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVBYQxj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 11:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbVBYQxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 11:53:38 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:21434 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262742AbVBYQvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 11:51:42 -0500
Message-Id: <200502251649.j1PGnL5w006570@laptop11.inf.utfsm.cl>
To: linux-os@analogic.com
cc: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Invalid module format in Fedora core2 
In-Reply-To: Message from linux-os <linux-os@analogic.com> 
   of "Fri, 25 Feb 2005 10:53:44 CDT." <Pine.LNX.4.61.0502251031170.626@chaos.analogic.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 25 Feb 2005 13:49:21 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 25 Feb 2005 13:49:21 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os <linux-os@analogic.com> said:
> On Fri, 25 Feb 2005, Payasam Manohar wrote:
> > I tried to insert a sample module into Fedora core 2 , But it is giving
> > an error message that " no module in the object"
> > The same module was inserted successfully into Redhat linux 9.

> > Is there any changes from RH 9 to Fedora Core 2 with respect to the module 
> > writing and insertion.

> Yes. Fedora Core 2 should have the new module tools. It also has
> a new kernel. These new kernels load a module called "module.ko"
> instead of "module.o".

Right up to here.

>                        Inside the new module is some code used
> to obfuscate the new module mechanism where 'insmod' and friends
> has been moved inside the kernel, further bloating the kernel

AFAIR, the resulting code in-kernel is even smaller than before, and diong
it in-kernel is the only sane way to avoid all kinds of nasty races.

> and, incidentally, making it necessary for modules to be
> "politically correct", i.e., policy moved into the kernel.

Is this FUD really necesary?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
