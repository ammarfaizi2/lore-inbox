Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSEAJBh>; Wed, 1 May 2002 05:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292857AbSEAJBg>; Wed, 1 May 2002 05:01:36 -0400
Received: from m206-234.dsl.tsoft.com ([198.144.206.234]:62080 "EHLO
	jojda.2y.net") by vger.kernel.org with ESMTP id <S290593AbSEAJBf>;
	Wed, 1 May 2002 05:01:35 -0400
Message-ID: <3CCFAEEE.AE586B9A@bigfoot.com>
Date: Wed, 01 May 2002 02:01:34 -0700
From: Erik Steffl <steffl@bigfoot.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en, sk, ru
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide <-> via VT82C693A/694x problems?
In-Reply-To: <Pine.LNX.4.10.10204301754310.2107-100000@master.linux-ide.org>
		 <3CCF4BFD.6C7F67EB@bigfoot.com> <1020239797.10097.68.camel@nomade>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:
> 
> Le mer 01/05/2002 à 03:59, Erik Steffl a écrit :
> >   the MB uses via chips so I included via82cxxx driver (as a module). is
> > that correct?
> >
> >   however, I just checked and via82cxxx is NOT loaded. What do I need to
> > do to make ide driver is using via82cxxx module?
> >
> >   I have ide driver compiled in (booting from ide hd), does via82cxxx
> > have to be compiled in?
> 
> You mean the ide module is on the ide drive ? And you want it to be
> loaded before any ide access ?

  ide is compiled in (not a module), via82cxxx is a module.

  via82cxxx is never loaded - what do I need to do to actually use this
module? Most other modules are loaded either automatically or an alias
is needed, however I have no idea what to do to make kernel use
via82cxxx (would ide module use it?). I thought that as long as I
configure it in kernel make xconfig as a module it will be used, but
it's not loaded (so I guess it's not used).

  I suspect that it might be the reason why my cd drive does not rip
audio cds...

	erik
