Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbVGMQcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbVGMQcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVGMQag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:30:36 -0400
Received: from witte.sonytel.be ([80.88.33.193]:21180 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262961AbVGMQ3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:29:10 -0400
Date: Wed, 13 Jul 2005 18:28:58 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: dtor_core@ameritech.net
cc: Dmitry Torokhov <dtor@mail.ru>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Amiga joystick typo (was: Re: Input: fix open/close
 races in joystick drivers - add a semaphore)
In-Reply-To: <d120d50005071307116fed5f0e@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0507131827190.27234@numbat.sonytel.be>
References: <200506280052.j5S0qDQT010792@hera.kernel.org> 
 <Pine.LNX.4.62.0507131254590.5536@anakin> <d120d50005071307116fed5f0e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2005, Dmitry Torokhov wrote:
> On 7/13/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, 27 Jun 2005, Linux Kernel Mailing List wrote:
> > > tree 11d80109ddc2f61de6a75a37941346100a67a0d1
> > > parent af246041277674854383cf91b8f0b01217b521e8
> > > author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:29:52 -0500
> > > committer Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:29:52 -0500
> > >
> > > Input: fix open/close races in joystick drivers - add a semaphore
> > >        to the ones that register more than one input device.
> > >
> > > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > >
> > >  drivers/input/joystick/amijoy.c     |   29 ++++++++++++++++-------------
> > 
> > This patch broke compilation of amijoy. Trivial fix below.
> > 
> 
> Sorry about that. Question - if I were to build a cross-compiler for
> amiga what arch is that? Right now I am "compiling" for i386 and hope
> that I will catch some real errors in between complaints about missing
> include files and definitions...

That's either m68k for original Amigas, or ppc for Amigas equipped with an APUS
(Amiga Power Up System) CPU upgrade card.

Unfortunately both of them are broken in the main tree. For m68k, our tree is
at http://linux-m68k-cvs.ubb.ca/.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
