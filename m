Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313116AbSDDIql>; Thu, 4 Apr 2002 03:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313114AbSDDIqb>; Thu, 4 Apr 2002 03:46:31 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:5107 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313119AbSDDIqP>; Thu, 4 Apr 2002 03:46:15 -0500
Date: Thu, 4 Apr 2002 10:44:38 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <8MC61VRHw-B@khms.westfalen.de>
Message-ID: <Pine.NEB.4.44.0204041037140.7845-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Apr 2002, Kai Henningsen wrote:

> alan@lxorguk.ukuu.org.uk (Alan Cox)  wrote on 03.04.02 in <E16soms-0004Au-00@the-village.bc.nu>:
>
> > >  EXPORT_SYMBOL(vfree);
> > >  EXPORT_SYMBOL(__vmalloc);
> > > -EXPORT_SYMBOL_GPL(vmalloc_to_page);
> > > +EXPORT_SYMBOL(vmalloc_to_page);
> >
> > The authors of that code made it GPL. You have no right to change that. Its
> > exactly the same as someone taking all your code and making it binary only.
> >
> > You are
> > 	-	subverting a digital rights management system
> > 			[5 years jail in the USA]
> > 	-	breaking a license
> >
> > but worse than that you are ignoring the basic moral rights of the authors
> > of that code.
>
> Frankly, I believe that it is both illegal (by the GPL) and morally
> bankrupt to add these "GPL only" symbols to the kernel *unless* you can
> get agreement for them fro *all* kernel copyright holders.
>...

Which part of the GPL do you mean with your "illegal (by the GPL)"?

Your statement sounds as if the GPL would require that you must be allowed
to link proprietary code with GPLed code - and that's the opposite of the
intention behind the GPL.

> MfG Kai

cu
Adrian


BTW: After reading COPYING I'm puzzled why binary-only modules are allowed
     at all? Could anyone enlighten me where the permission is hidden?


