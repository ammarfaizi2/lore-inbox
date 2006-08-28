Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWH1UZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWH1UZp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWH1UZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:25:45 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:63703 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751465AbWH1UZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:25:44 -0400
Message-Id: <200608282020.k7SKKntv031777@laptop13.inf.utfsm.cl>
To: Andi Kleen <ak@suse.de>
cc: Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw2@infradead.org>,
       David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org,
       jdike@addtoit.com, B.Steinbrink@gmx.de, arjan@infradead.org,
       chase.venters@clientec.com, akpm@osdl.org, rmk+lkml@arm.linux.org.uk,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros 
In-Reply-To: Message from Andi Kleen <ak@suse.de> 
   of "Mon, 28 Aug 2006 16:42:21 +0200." <200608281642.21737.ak@suse.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 28 Aug 2006 16:20:49 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 28 Aug 2006 16:21:26 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
> On Monday 28 August 2006 16:05, Arnd Bergmann wrote:
> 
> > The patch below should address both these issues, as long as the libc
> > has a working implementation of syscall(2).

> I would prefer the _syscall() macros to stay independent of the 
> actual glibc version. Or what do you do otherwise on a system
> with old glibc? Upgrading glibc is normally a major PITA.

Could just this macro layer be explicitly BSD (or at least LGPL) licensed? 
If not, it looks like a SCOX-whining-over-errno.h thing in the making in
case somebody wants to build a non-GPL libc on top...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

