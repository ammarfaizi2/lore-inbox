Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268941AbTCDBRC>; Mon, 3 Mar 2003 20:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268945AbTCDBRC>; Mon, 3 Mar 2003 20:17:02 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:4512 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S268941AbTCDBRB>;
	Mon, 3 Mar 2003 20:17:01 -0500
Message-Id: <200303040127.h241RNuW010735@eeyore.valparaiso.cl>
To: Pavel Roskin <proski@gnu.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mkdep patch in 2.4.21-pre4-ac7 breaks pci/drivers 
In-Reply-To: Your message of "Mon, 03 Mar 2003 03:32:55 CDT."
             <Pine.LNX.4.51.0303030313450.26129@localhost.localdomain> 
Date: Mon, 03 Mar 2003 22:27:23 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin <proski@gnu.org> said:
> On Sat, 1 Mar 2003, Horst von Brand wrote:
> > Pavel Roskin <proski@gnu.org> said:
> > > If I compile linux 2.4.21-pre4-ac7, then run "make depend" and "make
> > > clean", then "make bzImage" fails in pci/drivers:

> > make drivers/pci/gen-devlist; pushd drivers/pci; ./gen-devlist < pci.ids; popd

> > Needed for all 2.4.x I've seen (lately at least).

> That shouldn't be needed unless you skip "make depend" completely or do
> something else wrong, or your "make" is buggy.  It shouldn't be necessary.

I have been doing this for ages:

   make oldconfig dep clean

and it breaks here (Red Hat 8.0)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
