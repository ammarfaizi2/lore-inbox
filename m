Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267736AbTAaJMG>; Fri, 31 Jan 2003 04:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267737AbTAaJMG>; Fri, 31 Jan 2003 04:12:06 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:38274 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267736AbTAaJMF>; Fri, 31 Jan 2003 04:12:05 -0500
Message-Id: <200301310921.h0V9LJxZ002780@eeyore.valparaiso.cl>
To: Kasper Dupont <kasperd@daimi.au.dk>
cc: Hugo Mills <hugo-lkml@carfax.org.uk>,
       sundara raman <sundararamand@yahoo.com>, linux-kernel@vger.kernel.org,
       brand@eeyore.valparaiso.cl
Subject: Re: doubts in INIT - while system booting up 
In-Reply-To: Your message of "Thu, 30 Jan 2003 22:53:50 +0100."
             <3E399EEE.407D5B6@daimi.au.dk> 
Date: Fri, 31 Jan 2003 10:21:19 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont <kasperd@daimi.au.dk> said:
> Hugo Mills wrote:
> > 
> > On Sun, Jan 26, 2003 at 09:00:34AM -0800, sundara raman wrote:
> > 
> > > 8) while system booting up, it shows the following
> > > error
> > >
> > >        INIT: Id "x" respawing too fast: disabled for 5
> > > minutes
> > 
> >    It's not a kernel problem -- there's something broken in your X
> > Windows configuration. xdm (or kdm or gdm) keeps trying to start and
> > fails, and init is restarting it, and it fails...
> 
> I have recently had the same problem when I forgot to include some
> driver in the kernel which was required by my X configuration.

I've seen such problems too, caused by full /tmp
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
