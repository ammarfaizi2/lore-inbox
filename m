Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVA3AUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVA3AUt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 19:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVA3AUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 19:20:49 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:25802 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261617AbVA3AUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 19:20:41 -0500
Message-Id: <200501281924.j0SJOGql009942@laptop11.inf.utfsm.cl>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: [PATCH] OpenBSD Networking-related randomization port 
In-Reply-To: Message from Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org> 
   of "Fri, 28 Jan 2005 18:17:17 BST." <1106932637.3778.92.camel@localhost.localdomain> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 28 Jan 2005 16:24:16 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
 	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org> said:
> Attached you can find a split up patch ported from grSecurity [1], as
> Linus commented that he wouldn't get a whole-sale patch, I was working
> on it and also studying what features of grSecurity can be implemented
> without a development or maintenance overhead, aka less-invasive
> implementations.

OK.

> It adds support for advanced networking-related randomization, in
> concrete it adds support for TCP ISNs randomization,

1.

>                                                      RPC XIDs
> randomization,

2.

>                IP IDs randomization

3.

>                                     and finally a sub-key under the
> Cryptographic options menu for Linux PRNG [2] enhancements

4.                                                           (useful now
> and also for future patch submissions), which currently has an only-one
> option for poll sizes increasing (x2).

5 (it seems).

Needs way more splitting?

> As it's impact is minimal (in performance and development/maintenance
> terms), I recommend to merge it, as it gives a basic prevention for the
> so-called system fingerprinting (which is used most by "kids" to know
> how old and insecure could be a target system, many time used as the
> first, even only-one, data to decide if attack or not the target host)
> among other things.

How does it prevent fingerprinting?

And a huge, compressed patch attached.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
