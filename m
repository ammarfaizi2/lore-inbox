Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261437AbSJUQU1>; Mon, 21 Oct 2002 12:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbSJUQU1>; Mon, 21 Oct 2002 12:20:27 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:44970 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S261437AbSJUQU0>; Mon, 21 Oct 2002 12:20:26 -0400
Subject: Re: 2.5.43 -- media/video/stradis.c in function `saa_open':1949:
	structure has no member named `busy'
From: Miles Lane <miles.lane@attbi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1035213364.28189.156.camel@irongate.swansea.linux.org.uk>
References: <1034760289.3983.15.camel@turbulence.megapathdsl.net> 
	<1035213364.28189.156.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 21 Oct 2002 09:26:29 -0700
Message-Id: <1035217590.8460.68.camel@jellybean>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 08:16, Alan Cox wrote:
> On Wed, 2002-10-16 at 10:24, Miles Lane wrote:
> >   gcc -Wp,-MD,drivers/media/video/.stradis.o.d -D__KERNEL__ -Iinclude
> > -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> > -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> > -march=athlon  -Iarch/i386/mach-generic -nostdinc -iwithprefix
> > include    -DKBUILD_BASENAME=stradis   -c -o
> > drivers/media/video/stradis.o drivers/media/video/stradis.c
> > drivers/media/video/stradis.c: In function `saa_open':
> > drivers/media/video/stradis.c:1949: structure has no member named `busy'
> > drivers/media/video/stradis.c: In function `saa_close':
> > drivers/media/video/stradis.c:1961: structure has no member named `busy'
> 
> Not updated to 2.5. Nobody with a card is currently interested in that
> so if you have one its your turn to fix stuff ;)

Ah.  I was doing some configuration testing and don't have that
hardware.  Perhaps the driver should be removed from the tree?

	Miles

