Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284448AbRLCIvi>; Mon, 3 Dec 2001 03:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284446AbRLCIuZ>; Mon, 3 Dec 2001 03:50:25 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:14863 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S284896AbRLCI2Q>;
	Mon, 3 Dec 2001 03:28:16 -0500
Message-Id: <200112030253.fB32r8In024135@sleipnir.valparaiso.cl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.17.2: make ext2 smaller 
In-Reply-To: Your message of "Sun, 02 Dec 2001 06:31:17 CDT."
             <3C0A1105.18B76D64@mandrakesoft.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sun, 02 Dec 2001 23:53:08 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> said:
> This patch applies an obvious technique to the kernel:  increase the
> amount of code compiled in a single compilation unit, to increase the
> overall knowledge the compiler has of the code, to allow for better
> optimization and dead code removal.  KDE does this, with definite
> success, though they definitely are not the first to do this.

[...]

> Results from 2.4.17-pre2 plus the attached patch:  1135 bytes saved in
> vmlinux, simply from making all the functions static.

File size tells you nothing, it is influenced by symbol tables and
whatnot. What does size(1) say?

In any case, 1Kb out of 2Mb is 0.05%...
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616

