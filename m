Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290304AbSAPAmR>; Tue, 15 Jan 2002 19:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290303AbSAPAmB>; Tue, 15 Jan 2002 19:42:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48645 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290304AbSAPAla>; Tue, 15 Jan 2002 19:41:30 -0500
Date: Tue, 15 Jan 2002 16:41:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Weinehall <tao@acc.umu.se>
cc: Benjamin LaHaise <bcrl@redhat.com>, John Weber <weber@nyc.rr.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
In-Reply-To: <20020116013811.E5235@khan.acc.umu.se>
Message-ID: <Pine.LNX.4.33.0201151639320.1213-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Jan 2002, David Weinehall wrote:
> >
> > Just do
> >
> > 	#include <asm/atomic.h>
> >
> > and be done with it.
>
> The lines below say:
>
> #ifndef _LINUX_POSIX_TYPES_H   /* __FD_CLR */
> #include <linux/posix_types.h>
> #endif

At least that doesn't depend on all architectures having the same
exclusion-defines, but yeah, it's ugly too.

If this actally makes any noticeable difference to compilation speed I
could live with it. Does it?

		Linus

