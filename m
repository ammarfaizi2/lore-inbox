Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266215AbUFUNJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266215AbUFUNJm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 09:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266227AbUFUNHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 09:07:09 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:4835 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S266215AbUFUNDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 09:03:07 -0400
Message-Id: <200406190259.i5J2xAYU011589@eeyore.valparaiso.cl>
To: Hannu Savolainen <hannu@opensound.com>
cc: Roman Zippel <zippel@linux-m68k.org>,
       4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness 
In-Reply-To: Message from Hannu Savolainen <hannu@opensound.com> 
   of "Fri, 18 Jun 2004 20:37:53 +0300." <Pine.LNX.4.58.0406182006060.20336@zeus.compusonic.fi> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Fri, 18 Jun 2004 22:59:10 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannu Savolainen <hannu@opensound.com> said:
> On Fri, 18 Jun 2004, Roman Zippel wrote:
> 
> > To quote from your previous mail:
> >
> > > make -C /lib/modules/`uname -r`/build scripts scripts_basic include/linux/version.h
> >
> > That doesn't really like documented interfaces to me.
> Right. The documented command is "make install". However an undocumented
> detail is that that doesn't work with "virgin" kernel sources (nothing
> compiled yet). The above command seems to be needed to prepare the source
> tree for building the module. The "documented" alternative would be full
> make in the kernel source tree but that is massive overkill (in addition
> it doesn't work with most distribution kernels).

make modules_prepare
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
