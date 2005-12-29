Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVL2PBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVL2PBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 10:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVL2PBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 10:01:51 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:1209 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750753AbVL2PBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 10:01:50 -0500
Message-Id: <200512291501.jBTF13Ea014488@laptop11.inf.utfsm.cl>
To: Arjan van de Ven <arjan@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers 
In-Reply-To: Message from Arjan van de Ven <arjan@infradead.org> 
   of "Thu, 29 Dec 2005 08:49:04 BST." <1135842544.2935.0.camel@laptopd505.fenrus.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Thu, 29 Dec 2005 12:01:03 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 29 Dec 2005 12:01:04 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
> > IOW: I'd prefer that we be the ones who specify which functions are going
> > to be inlined and which ones are not.

> a bold statement... especially since the "and which ones are not" isn't
> currently there, we still leave gcc a lot of freedom there ... but only
> in one direction.

Besides, this is currently an everywhere or nowhere switch. gcc (in
principle at least) could decide which calls to inline and for which ones
it isn't worth it. Just like the (also long to die) "register" keyword.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

