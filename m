Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277785AbRJIPnl>; Tue, 9 Oct 2001 11:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277784AbRJIPn3>; Tue, 9 Oct 2001 11:43:29 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:57864 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S277785AbRJIPnR>; Tue, 9 Oct 2001 11:43:17 -0400
Message-Id: <200110091543.f99FhFVJ009433@pincoya.inf.utfsm.cl>
To: root@chaos.analogic.com
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel size 
In-Reply-To: Message from "Richard B. Johnson" <root@chaos.analogic.com> 
   of "Tue, 09 Oct 2001 10:52:50 -0400." <Pine.LNX.3.95.1011009105102.5543A-100000@chaos.analogic.com> 
Date: Tue, 09 Oct 2001 11:43:14 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> said:
> On Tue, 9 Oct 2001, Ingo Oeser wrote:

[...]

> > strip -R .ident -R .comment -R .note
> > 
> > is your friend. 

[...]

> Yes! Wonderful...
> -rwxr-xr-x   1 root     root      1571516 Oct  9 10:50 vmlinux
> -rwxr-xr-x   1 root     root      1590692 Oct  1 13:26 vmlinux.OLD
> 
> That got rid of some cruft.

Yep. A WHOOPing 1.2% of the total. BTW, is this stuff ever being loaded
into RAM with the executable kernel, discarded on boot, or what?

IMHO, it would be more productive to go after savings via .init*, and
perhaps bug the GCC/binutils people to merge strings...
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
