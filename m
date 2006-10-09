Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWJIDdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWJIDdW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 23:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWJIDdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 23:33:22 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:53893 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932220AbWJIDdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 23:33:21 -0400
Message-Id: <200610090209.k9929IdP009924@laptop13.inf.utfsm.cl>
To: Stas Sergeev <stsp@aknet.ru>
cc: Arjan van de Ven <arjan@infradead.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jakub Jelinek <jakub@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch] honour MNT_NOEXEC for access() 
In-Reply-To: Message from Stas Sergeev <stsp@aknet.ru> 
   of "Sun, 08 Oct 2006 13:11:12 +0400." <4528C0B0.4070002@aknet.ru> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Sun, 08 Oct 2006 22:09:18 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sun, 08 Oct 2006 22:09:27 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:
> Arjan van de Ven wrote:
> >> but ld.so seems to be
> >> the special case - it is a kernel helper after all,
> > in what way is ld.so special in ANY way?

> It is a kernel helper.

Right. But what prevents anybody to have a hacked, non-testing, ld.so lying
around?

>                        Kernel does all the security
> checks before invoking it. However, when invoked
> directly, it have to do these checks itself. So it is
> special in a way that it have to do the security checks
> which otherwise only the kernel should do.

It just can't do them (reliably at least) in general. Call it a Unix/POSIX
design failure...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

