Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSH0Om4>; Tue, 27 Aug 2002 10:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSH0Omz>; Tue, 27 Aug 2002 10:42:55 -0400
Received: from inti.inf.utfsm.cl ([146.83.198.3]:55250 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S316210AbSH0Omz>;
	Tue, 27 Aug 2002 10:42:55 -0400
Message-Id: <200208270138.g7R1ckGx001985@eeyore.valparaiso.cl>
To: Robert Love <rml@tech9.net>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make raid5 checksums preempt-safe 
In-Reply-To: Message from Robert Love <rml@tech9.net> 
   of "26 Aug 2002 17:15:07 -0400." <1030396507.15007.452.camel@phantasy> 
Date: Mon, 26 Aug 2002 21:38:46 -0400
From: Horst von Brand <vonbrand@eeyore.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> said:
> On Mon, 2002-08-26 at 17:09, Thunder from the hill wrote:
> 
> > These will suck when on if, I guess... 
> 
> hm?
> 
> > Anyway, will this compile at all?  There seems no semicolon after the
> > asm volatile ()
> 
> Ah yes, curses.  Thanks.

Also, kindly place "do { ... } while(0)" around XMMS_SAVE, if only for
symmetry.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
