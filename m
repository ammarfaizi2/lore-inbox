Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276688AbRJMJ32>; Sat, 13 Oct 2001 05:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278280AbRJMJ3T>; Sat, 13 Oct 2001 05:29:19 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:56840 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S276688AbRJMJ3G>;
	Sat, 13 Oct 2001 05:29:06 -0400
Message-Id: <200110130120.f9D1K2L0024119@sleipnir.valparaiso.cl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: Message from Jeff Garzik <jgarzik@mandrakesoft.com> 
   of "Fri, 12 Oct 2001 15:34:33 EST." <Pine.LNX.3.96.1011012153014.31508A-100000@mandrakesoft.mandrakesoft.com> 
Date: Fri, 12 Oct 2001 21:20:02 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> said:

[...]

> I was pondering whether it was ok to unconditionally include the
> lib/crc32.c code, regardless of need.  I am leaning towards "no," which
> implies Makefile and Config.in rules which must be updated for each
> driver that uses crc32.

It is easier in that case just to make it another module.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
