Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbUCHMzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 07:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbUCHMzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 07:55:07 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:47502 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262483AbUCHMy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 07:54:59 -0500
Message-Id: <200403081254.i28Csinj002627@eeyore.valparaiso.cl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [2.4 patch] MAINTAINERS: remove LAN media entry 
In-Reply-To: Message from Marcelo Tosatti <marcelo.tosatti@cyclades.com> 
   of "Mon, 08 Mar 2004 02:22:36 -0300." <Pine.LNX.4.44.0403080221520.2604-100000@dmt.cyclades> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Mon, 08 Mar 2004 09:54:43 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> said:
> On Sun, 7 Mar 2004, Adrian Bunk wrote:
> 
> > On Sat, Feb 28, 2004 at 11:57:11AM +0100, Daniel Egger wrote:
> > > On Feb 27, 2004, at 9:54 pm, Adrian Bunk wrote:
> > > 
> > > >IOW:
> > > >The entry from MAINTAINER can be removed?
> > > 
> > > This one for sure. The same is probably sensible for the
> > > drivers, too. It's just too confusing to not several
> > > versions of the driver floating around which need different
> > > tools. And since the manufacturer propagates their own
> > > version, the linux one should go...
> > >...
> > 
> > 
> > It's a question whether removing drivers from a stable kernel series is 
> > a good idea, but the following is definitely correct:
> > 
> > 
> > --- linux-2.4.26-pre2-full/MAINTAINERS.old	2004-03-07 16:48:59.000000000 +0100
> > +++ linux-2.4.26-pre2-full/MAINTAINERS	2004-03-07 16:49:09.000000000 +0100
> > @@ -1077,12 +1077,6 @@
> >  W:	http://www.cse.unsw.edu.au/~neilb/oss/knfsd/
> >  S:	Maintained
> >  
> > -LANMEDIA WAN CARD DRIVER
> > -P:      Andrew Stanley-Jones
> > -M:      asj@lanmedia.com
> > -W:      http://www.lanmedia.com/
> > -S:      Supported
> > - 
> >  LAPB module
> >  P:	Henner Eisen
> >  M:	eis@baty.hanse.de
> > 
> 
> I think it might be better to change to
> 
> 
> LANMEDIA WAN CARD DRIVER
> S: UNMAINTAINED
> 
> Thoughts? 

Sounds right to me.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
