Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290048AbSAKSLY>; Fri, 11 Jan 2002 13:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290049AbSAKSLO>; Fri, 11 Jan 2002 13:11:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41998 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290048AbSAKSLD>; Fri, 11 Jan 2002 13:11:03 -0500
Date: Fri, 11 Jan 2002 10:09:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Fix fs/fat/inode.c when compiled with gcc-3.0.x
In-Reply-To: <20020111152950.GM13931@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0201111008240.3952-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Jan 2002, Tom Rini wrote:
>
> This was indeed on PPC (I tried x86 w/ the same package but it worked)
> running gcc-3.0.3-1 (from Debian/sid).  So it seems the fix didn't make
> it into a release yet.  I guess I'll go hunt down some compiler people
> and get them to fix it.

I've seen the patch, so it definitely is fixed - rth posted it to the gcc
lists. But it may be that it only went into the development tree, or that
it happened after 3.0.3 was released.

		Linus

