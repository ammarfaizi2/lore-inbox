Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269077AbTCBCDZ>; Sat, 1 Mar 2003 21:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269083AbTCBCDZ>; Sat, 1 Mar 2003 21:03:25 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:14053 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S269077AbTCBCDY>;
	Sat, 1 Mar 2003 21:03:24 -0500
Message-Id: <200303020213.h222DM7O003304@eeyore.valparaiso.cl>
To: Pavel Roskin <proski@gnu.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mkdep patch in 2.4.21-pre4-ac7 breaks pci/drivers 
In-Reply-To: Your message of "Fri, 28 Feb 2003 17:00:54 CDT."
             <Pine.LNX.4.50.0302281626530.1829-100000@marabou.research.att.com> 
Date: Sat, 01 Mar 2003 23:13:22 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin <proski@gnu.org> said:
> If I compile linux 2.4.21-pre4-ac7, then run "make depend" and "make
> clean", then "make bzImage" fails in pci/drivers:

make drivers/pci/gen-devlist; pushd drivers/pci; ./gen-devlist < pci.ids; popd

Needed for all 2.4.x I've seen (lately at least).


[...]

> This is caused by the patch for scripts/mkdep.c (part of the
> 2.4.21-pre4-ac7 patch)

Nope. It's the same with 2.4 from Marcelo.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
