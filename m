Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280257AbRKXVUy>; Sat, 24 Nov 2001 16:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280251AbRKXVUr>; Sat, 24 Nov 2001 16:20:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30984 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280110AbRKXVUk>; Sat, 24 Nov 2001 16:20:40 -0500
Date: Sat, 24 Nov 2001 13:14:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Phil Sorber <aafes@psu.edu>, lkml <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@transmeta.com>
Subject: Re: Linux 2.4.16-pre1
In-Reply-To: <Pine.LNX.4.21.0111241744250.12119-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0111241311040.2591-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 24 Nov 2001, Marcelo Tosatti wrote:
> >
> > Are these going to appear on the front page of kernel.org?
>
> They have to...
>
> I'm sure hpa will do that as soon as he has time to...

I also decided that the suggestion to move the "testing" subdirectory down
to below the kernel that the directory is for is a good idea.

So I moved all the 2.5.x testing stuff to kernel/v2.5/testing, leaving the
old kernel/testing directory basically orphaned.

Marcelo could either take over the old directory (which will make his
pre-patches show up on kernel.org automatically), or preferably just do
the same thing, and make the v2.4 test patches in v2.4/testing (which will
also require support from the site admin, who is probably overworked as-is
with the RAID failures ;)

			Linus

