Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263379AbUDGBCy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 21:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbUDGBCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 21:02:54 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:36490 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263379AbUDGBCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 21:02:52 -0400
Message-Id: <200404070102.i3712nDe002647@eeyore.valparaiso.cl>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge 
In-Reply-To: Your message of "Tue, 06 Apr 2004 10:44:12 MST."
             <20040406174412.7850.qmail@web40511.mail.yahoo.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 06 Apr 2004 21:02:49 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> If stack will shrink - i'll come up with something.

Good luck! When it is done shrinking, there won't be much (if any) left for
you to play with.

> Rearchitecture of LISP interpreter - is too much work.

Implement a kernel-side LISP interpreter isn't...

> (and I'm lazy - I prefer computer to do a work, not me
> :-)

Nodz. But even better is _not_ doing it at all ;-)

> I checked what is going on with the stack - it is used
> to pass parameters, some functions have one or two
> local variables (4 bytes each) and that's it.

Why do you think it has been 2 pages (8KiB) for as long as I remember
(essentially forever in Linux), and it has taken a _lot_ of work to shrink
it to 4KiB (- size of *current)?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
