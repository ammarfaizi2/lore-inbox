Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267750AbTAaKSG>; Fri, 31 Jan 2003 05:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267751AbTAaKSG>; Fri, 31 Jan 2003 05:18:06 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:57741 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267750AbTAaKSG>; Fri, 31 Jan 2003 05:18:06 -0500
Message-Id: <200301311027.h0VARIhI003186@eeyore.valparaiso.cl>
To: Kasper Dupont <kasperd@daimi.au.dk>
cc: linux-kernel@vger.kernel.org, brand@eeyore.valparaiso.cl
Subject: Re: doubts in INIT - while system booting up 
In-Reply-To: Your message of "Fri, 31 Jan 2003 10:47:19 +0100."
             <3E3A4627.993A4B59@daimi.au.dk> 
Date: Fri, 31 Jan 2003 11:27:18 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont <kasperd@daimi.au.dk> said:
> Horst von Brand wrote:
> > 
> > > > >        INIT: Id "x" respawing too fast: disabled for 5
> > 
> > I've seen such problems too, caused by full /tmp
> 
> Yes IIRC in that case xfs will fail to create /tmp/.font-unix
> and the socket /tmp/.font-unix/fs7100 and X will fail because
> of the missing font server.

Yep. And failing to start xfs has the same effect. Broken library
installations (such as missing/mangled /etc/ld.so.cache, also caused by
full / on boot; broken/mangled /etc/ld.so.conf) can also be a cause.

> Anyway, I was just stating that it could be caused by a
> misconfigured kernel.

Better check the easy answers first ;-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
