Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287283AbSACNgY>; Thu, 3 Jan 2002 08:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287289AbSACNgP>; Thu, 3 Jan 2002 08:36:15 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:24841 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S287283AbSACNf5>; Thu, 3 Jan 2002 08:35:57 -0500
Message-Id: <200201031335.g03DZkx2021475@pincoya.inf.utfsm.cl>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems? 
In-Reply-To: Message from Dave Jones <davej@suse.de> 
   of "Thu, 03 Jan 2002 01:58:36 BST." <Pine.LNX.4.33.0201030149500.5131-100000@Appserv.suse.de> 
Date: Thu, 03 Jan 2002 10:35:46 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de> said:
> On Wed, 2 Jan 2002, Mike Castle wrote:
> > I never got the impression that DMI was going to be the exclusive way of
> > obtaining information, but rather, as a supplement.
> 
> In this case though, it's not just bad, it's exceptionally bad.
> 
> Taking the 5 boxes I currently have powered up as test cases..
> 
> Old quad ppro
> - Wierd compaq thing, no DMI tables. So won't do a thing here.
> 
> Athlon (one of the original ones), no ISA slots
> - Correct DMI tables.
> 
> Vaio laptop
> - Reports what is probably its PCMCIA slot as an ISA slot
> 
> Cyrix III box, no ISA slots
> - Reports 4 slots present
> 
> K6 box, with ISA slots
> - Reports none.
> 
> 1 in 5 gets it right. Are the odds really worth the hassle
> just to keep Aunt Tillie happy ?

I'd wagger Aunt Tillie doesn't run Linux on Ye Olde Coffepot, but on a new,
PCI-only machine. So this is doubly silly...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
