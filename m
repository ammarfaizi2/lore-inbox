Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278709AbRKLNc0>; Mon, 12 Nov 2001 08:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280691AbRKLNcR>; Mon, 12 Nov 2001 08:32:17 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:60944 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S278709AbRKLNcJ>; Mon, 12 Nov 2001 08:32:09 -0500
Message-Id: <200111121331.fACDVf1E007161@pincoya.inf.utfsm.cl>
To: Ricky Beam <jfbeam@bluetopia.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Yet another design for /proc. Or actually /kernel. 
In-Reply-To: Message from Ricky Beam <jfbeam@bluetopia.net> 
   of "Fri, 09 Nov 2001 11:44:28 CDT." <Pine.GSO.4.33.0111091139580.17287-100000@sweetums.bluetronic.net> 
Date: Mon, 12 Nov 2001 10:31:41 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam <jfbeam@bluetopia.net> said:
> >the discussion is irrelevant. Despite what everybody thinks, Linus thinks
> >/proc must be not binary, so it will stay that way for those of us who run
> >Linus kernels...
> 
> Linus has been "wrong" before.  It will require good code and numbers
> backing that codes "goodness" before Linus will begin to listen.  Yes,
> a new procfs format will break a great deal of userland toys, so the
> changes had better be worth it and sufficient to never, EVER require
> a complete overhaul in the future.

/proc for process info is a given (many Unices have it, it is nice at least
for compatibility).

/proc for random other garbage should go away. To get at some value you can
get via specialized calls by read(2) also is just kernel bloat.
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
