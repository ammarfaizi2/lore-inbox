Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbSKDPyf>; Mon, 4 Nov 2002 10:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264719AbSKDPyf>; Mon, 4 Nov 2002 10:54:35 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:15119 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S264715AbSKDPyd>; Mon, 4 Nov 2002 10:54:33 -0500
Message-Id: <200211030225.gA32P37c006245@eeyore.valparaiso.cl>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's left over. 
In-Reply-To: Your message of "Fri, 01 Nov 2002 20:37:56 -0000."
             <Pine.LNX.4.44.0211012003290.2206-100000@localhost.localdomain> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6243.1036290303.1@eeyore.valparaiso.cl>
Date: Sat, 02 Nov 2002 23:25:03 -0300
From: Horst von Brand <vonbrand@eeyore.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> said:

[...]

> I dealt with crash dumps quite a lot over 10 years with SCO UNIX,
> OpenServer and UnixWare: which were addressing the PC market, not
> own hardware.

What I remember about hardware compatibility for SCO Unix and Solaris on
ia32 is _not_ funny. Lightyears from what Linux handles today without
breaking a sweat.

> It's a real worry that writing a crash dump to disk might stomp in the
> wrong place, but I don't recall it ever happening in practice.  But
> occasionally, yes, a dump was not generated at all, or not completed.

How do you test that? Not in some contrieved situation, under real crashes.
Don't just consider crashes in the official $DISTRIBUTION kernel, but in
Linus' BK tree, or some of the random, two-or-three-letter-trees of the day
(_that_ is where crashes happen, _that_ is where the info would be most
valuable). It gets _real_ hairy _real_ fast to make sure you don't scribble
over /home or /etc on the user's disk...

> Of course, you could argue that SCO's disk drivers were more stable :-)

If you only handle a few, thoroughly tested, high-end controllers and
disks, that is not too hard to do.
--
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
