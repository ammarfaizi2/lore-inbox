Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161155AbVLXCW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbVLXCW2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 21:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161156AbVLXCW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 21:22:28 -0500
Received: from quelen.inf.utfsm.cl ([200.1.19.194]:4495 "EHLO
	quelen.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S1161155AbVLXCW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 21:22:27 -0500
Message-Id: <200512240106.jBO167Sg022181@quelen.inf.utfsm.cl>
To: 7eggert@gmx.de
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks 
In-Reply-To: Message from Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org> 
   of "Fri, 23 Dec 2005 11:12:38 BST." <E1Epjug-0001iA-In@be1.lrz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Fri, 23 Dec 2005 22:06:07 -0300
From: Horst von Brand <vonbrand@quelen.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org> wrote:
> Horst von Brand <vonbrand@inf.utfsm.cl> wrote:

[...]

> > "With some drawbacks" is the point: It has been determined that the
> > drawbacks are heavy enough that the 8KiB stack option should go.

> Determined by voodoo

Did you see them sticking needles into waxen stacks?

>                      and wild guessing.

More like long experience with the kernel, and sifting many, many bug
reports we've not looked over (and many we probably didn't see).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
