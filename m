Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbSJUOyP>; Mon, 21 Oct 2002 10:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261462AbSJUOyP>; Mon, 21 Oct 2002 10:54:15 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:34484 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261432AbSJUOyN>; Mon, 21 Oct 2002 10:54:13 -0400
Subject: Re: 2.5.43 -- media/video/stradis.c in function `saa_open':1949:
	structure has no member named `busy'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miles Lane <miles.lane@attbi.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1034760289.3983.15.camel@turbulence.megapathdsl.net>
References: <1034760289.3983.15.camel@turbulence.megapathdsl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 16:16:04 +0100
Message-Id: <1035213364.28189.156.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-16 at 10:24, Miles Lane wrote:
>   gcc -Wp,-MD,drivers/media/video/.stradis.o.d -D__KERNEL__ -Iinclude
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=athlon  -Iarch/i386/mach-generic -nostdinc -iwithprefix
> include    -DKBUILD_BASENAME=stradis   -c -o
> drivers/media/video/stradis.o drivers/media/video/stradis.c
> drivers/media/video/stradis.c: In function `saa_open':
> drivers/media/video/stradis.c:1949: structure has no member named `busy'
> drivers/media/video/stradis.c: In function `saa_close':
> drivers/media/video/stradis.c:1961: structure has no member named `busy'

Not updated to 2.5. Nobody with a card is currently interested in that
so if you have one its your turn to fix stuff ;)

