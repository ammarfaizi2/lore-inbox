Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317672AbSGUJHg>; Sun, 21 Jul 2002 05:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317674AbSGUJHg>; Sun, 21 Jul 2002 05:07:36 -0400
Received: from vaak.stack.nl ([131.155.140.140]:9989 "EHLO mailhost.stack.nl")
	by vger.kernel.org with ESMTP id <S317672AbSGUJHf>;
	Sun, 21 Jul 2002 05:07:35 -0400
Date: Sun, 21 Jul 2002 11:10:40 +0200 (CEST)
From: Jos Hulzink <josh@stack.nl>
To: Mike Galbraith <efault@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Give Bartlomiej a break!  (Re: Impressions of IDE 98?)
In-Reply-To: <5.1.0.14.2.20020721102202.00b9b3d0@pop.gmx.net>
Message-ID: <20020721105014.U26890-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jul 2002, Mike Galbraith wrote:

> >Well you don't necessarily have to be an IDE guru to realize something's
> >wrong when you see a bloke constantly breaking the subsystem, practically
> >never fixing it up himself, disappearing for a month w/o saying a word
> >after having fried 2.5.25 completely and not really caring about what
> >others have to say about the code.
>
> No, you don't have to be a guru to notice that the rewrite is proving
> difficult.

You are right there, but anyone could have told you that even before the
rewrite started. A rewrite of the IDE drivers should mean one out of two
things:

1) You are aware of the fact IDE disks contain user data, thus if you hack
the ide drivers, you better do / test it thoroughly. Of course, you are
not perfect, mistakes are possible, but know that people won't like them.

2) You assume EVERYONE that is working on the development kernel (even on
parts that have nothing to do with IDE) has a seperate computer for kernel
development or SCSI disks. (You don't want your IDE driver to destroy that
data partition / disk, do you ?).

Well... IMHO, 2) is not an option for a good maintainer, and at the
moment, 1) seems not to hold.

I was willing to test the 2.5 tree, but the way IDE development is going
at the moment makes me keeping my hands off any 2.5 kernel. I just don't
have a second system that is fast enough to recomile a kernel every few
days.

Well... I already gave my opinion about the IDE maintenance in the early
2.5 days, glad to see I was right back then.

Guys, see you again after 2.6.0, I probably won't compile any single
kernel before then.

Jos

