Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267156AbTBQP0j>; Mon, 17 Feb 2003 10:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267157AbTBQP0j>; Mon, 17 Feb 2003 10:26:39 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:21376 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267156AbTBQP0i>; Mon, 17 Feb 2003 10:26:38 -0500
Message-ID: <3E51012C.8C1890A0@cinet.co.jp>
Date: Tue, 18 Feb 2003 00:35:08 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.61-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (3/26) mach-pc9800
References: <20030217134333.GA4734@yuzuki.cinet.co.jp> <20030217135137.GC4799@yuzuki.cinet.co.jp> <20030217144853.GA3729@mars.ravnborg.org>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> 
> On Mon, Feb 17, 2003 at 10:51:37PM +0900, Osamu Tomita wrote:
> > This is patchset to support NEC PC-9800 subarchitecture
> > against 2.5.61 (3/26).
> >
> > diff -Nru linux-2.5.61/arch/i386/mach-pc9800/Makefile linux98-2.5.61/arch/i386/mach-pc9800/Makefile
> > --- linux-2.5.61/arch/i386/mach-pc9800/Makefile       1970-01-01 09:00:00.000000000 +0900
> > +++ linux98-2.5.61/arch/i386/mach-pc9800/Makefile     2003-02-16 17:19:03.000000000 +0900
> > @@ -0,0 +1,7 @@
> > +#
> > +# Makefile for the linux kernel.
> > +#
> > +
> > +EXTRA_CFLAGS += -I../kernel
> 
> Is this really needed to make it compile?
> Seems to be inherited from other Makefiles,
> and I doubt it is needed.
Thanks for the comment.
It is copy of mach-defaults/Makefile at all.
I think this is no need now too. But I guess, .c files in mach-* 
were placed in ../kernel originaly, so new comming file may be need
this in future??? Not sure.
-- 
Osamu Tomita
