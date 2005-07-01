Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263377AbVGAPzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263377AbVGAPzS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 11:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263379AbVGAPzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 11:55:18 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:3297 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S263377AbVGAPyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 11:54:54 -0400
Date: Fri, 1 Jul 2005 17:54:46 +0200
From: David Weinehall <tao@acc.umu.se>
To: David Masover <ninja@slaphack.com>
Cc: Markus =?iso-8859-1?Q?T=F6rnqvist?= <mjt@nysv.org>,
       Douglas McNaught <doug@mcnaught.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Hubert Chan <hubert@uhoreg.ca>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050701155446.GZ16867@khan.acc.umu.se>
Mail-Followup-To: David Masover <ninja@slaphack.com>,
	Markus =?iso-8859-1?Q?T=F6rnqvist?= <mjt@nysv.org>,
	Douglas McNaught <doug@mcnaught.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Hubert Chan <hubert@uhoreg.ca>, Kyle Moffett <mrmacman_g4@mac.com>,
	Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
	Gregory Maxwell <gmaxwell@gmail.com>,
	Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	ReiserFS List <reiserfs-list@namesys.com>
References: <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> <m2k6kd2rx8.fsf@Douglas-McNaughts-Powerbook.local> <20050629135820.GJ11013@nysv.org> <20050629205636.GN16867@khan.acc.umu.se> <42C4FA1A.1050100@slaphack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C4FA1A.1050100@slaphack.com>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 03:08:58AM -0500, David Masover wrote:
> David Weinehall wrote:
>
> >GNOME and KDE run on operating systems that run other kernels than
> >Linux, hence they have to implement their own userland VFS anyway.
> >Adding this to the Linux kernel won't help them one bit, unless
> >we can magically convince Sun to add it to Solaris, all different
> >BSD:s to add it to their kernels, etc.  Not going to happen.
> >An effort to get GNOME and KDE to unify their VFS:s would be
> >far more benificial,
> 
> Than what?  Creating a unified VFS which I can access from Bash, and 
> which obsoletes both GNOME and KDE's VFSes except in their presentation?

On one of the platforms that they support, yes.  But only for kernels
newer than 2.6.yy...  So they'd still have to have their own VFS for
2.4.xx, 2.6.xx (xx < yy), FreeBSD, OpenBSD, Solaris, etc...

> >FreeDesktop is doing a lot of work to make GNOME, KDE, and other
> >DE:s interoperate as much as possible.  Support their initiative
> >instead of trying to get a monstrosity (albeit a very cool one,
> >conceptually) into the kernel.  Sure, it could be made to work,
> >but not without dropping our Unixness.
> 
> (I'm talking about the metafs (/meta) idea, which isn't nearly as much a 
> monstrocity, and doesn't kill our unixness, it enhances it.)

Which would neither need VFS changes nor be dependent on Reiser4 in
any way, so I don't see why this thread lives on.  Just get down to
business and implement this metafs =)


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
