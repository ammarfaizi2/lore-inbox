Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129306AbRAZRgR>; Fri, 26 Jan 2001 12:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129999AbRAZRgH>; Fri, 26 Jan 2001 12:36:07 -0500
Received: from mdmgrp2-13.accesstoledo.net ([207.43.107.13]:44294 "EHLO
	rosswinds.net") by vger.kernel.org with ESMTP id <S129306AbRAZRfy>;
	Fri, 26 Jan 2001 12:35:54 -0500
Date: Fri, 26 Jan 2001 12:47:54 -0500 (EST)
From: "Michael B. Trausch" <fd0man@crosswinds.net>
To: Georg Nikodym <georgn@somanetworks.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
        Zack Brown <zab@redhat.com>
Subject: Re: Possible Bug:  drivers/sound/maestro.c
In-Reply-To: <14961.38717.250220.501376@somanetworks.com>
Message-ID: <Pine.LNX.4.21.0101261245250.399-100000@fd0man.accesstoledo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jan 2001, Georg Nikodym wrote:
> 
> FWIW, I too was having this kind of problem.  When I starting living
> on 2.4.x kernels the problem went away.  Also gone were sound dropping
> out when I busied my machine with compiles things.
> 

2.4.0 still does it - not as often, but it still does it.  I'm compiling a
*lot* of software right now and I find that I just have to feed mpg123 my
songs one at a time by hand.  Seems that when it closes /dev/dsp, it goes
away, upon the reopen.

If I had a clue about the source code I'd make an attempt at figuring it
out.  I just don't have a clue ;P.

Right now I'm listening to the radio so I have continuious music, 'cuz I'm
working on creating rolling out my own system and I can't keep switching
songs manually, and the distortion gets to be too much even at low volume
levels.

	- Mike

===========================================================================
Michael B. Trausch                                    fd0man@crosswinds.net
Avid Linux User since April, '96!                           AIM:  ML100Smkr

              Contactable via IRC (DALNet) or AIM as ML100Smkr
===========================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
