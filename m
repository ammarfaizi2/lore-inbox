Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286358AbSAAX1l>; Tue, 1 Jan 2002 18:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286362AbSAAX1b>; Tue, 1 Jan 2002 18:27:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25860 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286358AbSAAX1R>; Tue, 1 Jan 2002 18:27:17 -0500
Date: Tue, 1 Jan 2002 15:26:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Re: NFS "dev_t" issues..
In-Reply-To: <3C32407A.BB44CBCE@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0201011524440.957-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Jan 2002, Jeff Garzik wrote:
>
> What do you think about the attached simple patch, making the cookie
> size more explicit?

Well, I suspect that we actually should also make the format explicit, and
basically use the same translation that I did for the NFS filehandle. That
way it's still just a cookie, but it's a cookie with (a) explicit size and
(b) meaning that won't change over different kernel revisions.

Hmm?

			Linus

