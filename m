Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293151AbSCRWaT>; Mon, 18 Mar 2002 17:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293164AbSCRWaL>; Mon, 18 Mar 2002 17:30:11 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:22926 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S293151AbSCRW36>;
	Mon, 18 Mar 2002 17:29:58 -0500
Date: Mon, 18 Mar 2002 17:29:53 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Machek <pavel@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Jonathan Barker <jbarker@ebi.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: VFS mediator?
In-Reply-To: <20020318192502.GD194@elf.ucw.cz>
Message-ID: <Pine.GSO.4.21.0203181726050.14280-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Mar 2002, Pavel Machek wrote:

> > 	* CODA: nice if you want commit-on-close semantics and basically
> > want a lot of regular files.  More or less portable, userland side doesn't
> > require much glue.  Has a nice local caching and as the result bad for any
> > RPC-style uses.
> 
> And the only one that works when r/w mounted on localhost.

Wrong.  Trivial example: filesystem that doesn't cache data (and has no
mmap()).

