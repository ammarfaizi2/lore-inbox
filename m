Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275843AbRJ0TJ0>; Sat, 27 Oct 2001 15:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276052AbRJ0TJQ>; Sat, 27 Oct 2001 15:09:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12039 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275843AbRJ0TJC>; Sat, 27 Oct 2001 15:09:02 -0400
Date: Sat, 27 Oct 2001 12:07:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Riley H Williams <rhw@MemAlpha.CX>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.13 default config
In-Reply-To: <3BDB031D.34BC4701@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0110271205560.3528-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 27 Oct 2001, Jeff Garzik wrote:

> Riley Williams wrote:
> >
> > Hi Alan, Linus.
> >
> > The enclosed patch (against the raw 2.4.13 tree) adds a `make defconfig`
> > option that configures Linux with the default options obtained by simply
> > pressing ENTER to every prompt that comes up.
>
> If someone wishes they can simply
>
> 	cp arch/$arch/defconfig .config
> 	make oldconfig

Why not just

	rm .config (if you have an old one at all)
	make oldconfig

That's what I always do (or you can copy the ".config" from somewhere
else, or you can edit your old ".config" in your favourite editor and
re-doing "make oldconfig").

I never _ever_ use any "real" configurator myself. The _only_ config maker
I ever use is "make oldconfig", after having possibly edited the .config
file by hand or done something else..

		Linus

