Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265170AbUFHM3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUFHM3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 08:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbUFHM3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 08:29:16 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58320 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S265170AbUFHM2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 08:28:15 -0400
Message-Id: <200406070420.i574KdKw006694@eeyore.valparaiso.cl>
To: Mike McCormack <mike@codeweavers.com>
cc: Christoph Hellwig <hch@infradead.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2 
In-Reply-To: Message from Mike McCormack <mike@codeweavers.com> 
   of "Sun, 06 Jun 2004 18:37:32 +0900." <40C2E5DC.8000109@codeweavers.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Mon, 07 Jun 2004 00:20:38 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike McCormack <mike@codeweavers.com> said:
> Christoph Hellwig wrote:
> > Huh?  binfmts do work on all linux architectures unchanged.  What you do
> > on other operating systems is up to you.  And btw, netbsd already has
> > binfmt_pecoff, you could certainly make use of that, too.
> 
> Working on only two platforms is not really what I'd call portable.

It is a start.

> > _You_ are relying on undocumented assumptions here.   Windows has different
> > address space layouts than ELF ABI systems and I think you're much better
> > off having your own pecoff loader for that.

> True, we are relying on undocumented assumptions.  On the other hand, 
> there's plenty of programs that rely on undocumented assumptions. 

So? "If it breaks, you get to keep all pieces" ring a bell?

> Binary compatability to me means that the same binary will work even 
> when the underlying system changes... is there a caveat that I missed?

"Compatibility" means "compatible to an agreed standard", "portability" is
a subset of that... if there is no standard, you just have accidental "it
works". 

> >>It seems Linus's kernel does that quite well, but some vendors seem not 
> >>to care too much about breaking Wine.

> > Why should they?  You need to fix up the broken assumptions in wine.
> 
> If you don't care about binary compatability, you can change whatever 
> you like.  At least some people out there seem to care about it.

They try hard to stay within POSIX and other standards. If you need
guarantees, you'd have to convince the kernel hackers for their need. Too
bad if it is for backward compatibility of non-open source stuff, tho.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
