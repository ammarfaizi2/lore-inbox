Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWDKRql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWDKRql (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 13:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWDKRql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 13:46:41 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:29650 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750822AbWDKRqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 13:46:40 -0400
Message-Id: <200604111746.k3BHkaQb005856@laptop11.inf.utfsm.cl>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
cc: "Ramakanth Gunuganti" <rgunugan@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL issues 
In-Reply-To: Message from "Jesper Juhl" <jesper.juhl@gmail.com> 
   of "Tue, 11 Apr 2006 10:42:04 +0200." <9a8748490604110142j30b5986et4c02f06dd3754ca4@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Tue, 11 Apr 2006 13:46:36 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 11 Apr 2006 13:46:27 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 4/11/06, Ramakanth Gunuganti <rgunugan@yahoo.com> wrote:
> > I am trying to understand the GPL boundaries for
> > Linux, any clarification provided on the following
> > issues below would be great:
> >
> > As part of a project, I would like to extend the Linux
> > kernel to support some additional features needed for
> > the project, the changes will include:
> >   o  Modification to Linux kernel.
> >   o  Adding new kernel modules.
> >   o  New system calls/IOCTLs to use the kernel
> > modifications/LKMs.
> >
> > All kernel changes including LKMs will be released
> > under GPL.
> >
> > Questions:

> Note: The answers to the questions below are based on my own personal
> understanding of the GPL and the policies of the Linux kernel.

IANAL either.

> Also contacting a lawyer would probably not be a bad idea.

Essential, not just a good idea. Just pick one who /does/ have a grasp of
GPL and like issues.

> > (Any reference to GPL license while answering these
> > questions would be great)
> >
> > 1. If an application is built on top of this modified
> > kernel, should the application be released under GPL?
> 
> No. Applications that merely use the services the kernel provides need
> not be GPL.

But AFAIU there is a fine line here... at least /in spirit/, adding system
calls and IOCTLs and... just for the particular use of a particular closed
source application is definitely wrong. It might be legally OK (I don't
know; the opinion here is divided on that kind of matter, see f.ex. the
regularly scheduled flamefest about binary modules), but morally it is at
least suspicious.

> > Do system calls provide a bounday for GPL? How does
> > this work with LKMs, all the code for LKMs will be
> > released but would a userspace application using the
> > LKMs choose not to use GPL?

> Again, a userspace application that merely use kernel services need not
> be GPL.

As long as it uses the standard system calls. Adding special system calls
might (should?) change that...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
