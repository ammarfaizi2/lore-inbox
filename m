Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136491AbREDT7I>; Fri, 4 May 2001 15:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136492AbREDT67>; Fri, 4 May 2001 15:58:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:1777 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136491AbREDT6j>;
	Fri, 4 May 2001 15:58:39 -0400
Date: Fri, 4 May 2001 15:58:38 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <200105041936.f44JaVY11944@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0105041539360.21896-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 May 2001, Richard Gooch wrote:

> I don't bother splitting /usr off /. I gave up doing that when disc
> became cheap. There's no point anymore. And since I have a lightweight

Yes, there is. Locality. Resistance to fs fuckups. Resistance to disk
fuckups. Easier to restore from tape. Different tunefs optimum (higher
inodes/blocks ratio, for one thing). Ability to keep /usr read-only.
Enough?

> distribution (500 MiB and I get X, LaTeX, emacs, compilers, netscrap
> and a pile of other things), it makes even less sense to split /usr
> off. Sorry, I don't have those fancy desktops. Don't need 'em. I spend
> most of my day in emacs and xterm.

What desktops? None of that crap on my boxen either. EMACS? What EMACS?
LaTeX is unfortunately needed (I prefer troff and AMSTeX on the TeX side).
Netrape? No chance in hell. bash <spit> is there, but I prefer to use
rc.

I don't see what does it have to keeping root on a separate filesystem,
though - the reasons have nothing to bloat in /usr/bin.

