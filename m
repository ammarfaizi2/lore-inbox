Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131106AbQKTC7q>; Sun, 19 Nov 2000 21:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131061AbQKTC7g>; Sun, 19 Nov 2000 21:59:36 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:3601 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S131034AbQKTC7U>;
	Sun, 19 Nov 2000 21:59:20 -0500
Message-Id: <200011200110.eAK1ALi10442@sleipnir.valparaiso.cl>
To: Markus Schoder <markus_schoder@yahoo.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Freeze on FPU exception with Athlon 
In-Reply-To: Message from Markus Schoder <markus_schoder@yahoo.de> 
   of "Sat, 18 Nov 2000 20:06:38 BST." <20001118190638.18296.qmail@web3407.mail.yahoo.com> 
Date: Sun, 19 Nov 2000 22:10:21 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?q?Markus=20Schoder?= <markus_schoder@yahoo.de> said:
> --- Linus Torvalds <torvalds@transmeta.com> schrieb: >

[...]

> > Markus, can you make the irq13 test the first thing
> > - don't worry about
> > 3dnow as that seems to not be a deciding factor..

> Ok, that was it!  It's IRQ 13.  Guess I should have
> tried that first.  Now everything works perfectly. 

Could you _please_ document this somewhere in the source, so noone trips
over this or starts wondering?

> Thanks everybody.

Nodz.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
