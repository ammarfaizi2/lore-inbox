Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVAXEw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVAXEw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 23:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVAXEw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 23:52:58 -0500
Received: from fiura.inf.utfsm.cl ([200.1.19.5]:18568 "EHLO fiura.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261440AbVAXEws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 23:52:48 -0500
Message-Id: <200501240429.j0O4TZIt010974@laptop11.inf.utfsm.cl>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Jesper Juhl <juhl-lkml@dif.dk>, Andi Kleen <ak@muc.de>,
       Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
Subject: Re: [patch 1/13] Qsort 
In-Reply-To: Message from "Rafael J. Wysocki" <rjw@sisk.pl> 
   of "Sun, 23 Jan 2005 11:37:08 BST." <200501231137.09715.rjw@sisk.pl> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 24 Jan 2005 01:29:35 -0300
From: Horst von Brand <vonbrand@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> said:

[...]

> To be precise, one needs ~(log N) of stack space for qsort, and frankly, one
> should use something like the shell (or should I say Shell?)

Shell. It is named for a person.

>                                                              sort for sorting
> small sets of elements in qsort as well.

It makes no sense for smallish sets, insertion sort is better.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
