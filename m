Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293131AbSCRWhl>; Mon, 18 Mar 2002 17:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293164AbSCRWha>; Mon, 18 Mar 2002 17:37:30 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36103 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293131AbSCRWhX>; Mon, 18 Mar 2002 17:37:23 -0500
Date: Mon, 18 Mar 2002 23:36:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Jonathan Barker <jbarker@ebi.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: VFS mediator?
Message-ID: <20020318223607.GB1740@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020318192502.GD194@elf.ucw.cz> <Pine.GSO.4.21.0203181726050.14280-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 	* CODA: nice if you want commit-on-close semantics and basically
> > > want a lot of regular files.  More or less portable, userland side doesn't
> > > require much glue.  Has a nice local caching and as the result bad for any
> > > RPC-style uses.
> > 
> > And the only one that works when r/w mounted on localhost.
> 
> Wrong.  Trivial example: filesystem that doesn't cache data (and has no
> mmap()).

I meant only one from the list. NFS certainly has mmap, and others
have it, too...
									Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
