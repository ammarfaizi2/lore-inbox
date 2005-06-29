Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbVF2U4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVF2U4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVF2U4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:56:53 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:60078 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262643AbVF2U4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:56:41 -0400
Date: Wed, 29 Jun 2005 22:56:36 +0200
From: David Weinehall <tao@acc.umu.se>
To: Markus =?iso-8859-1?Q?T=F6rnqvist?= <mjt@nysv.org>
Cc: Douglas McNaught <doug@mcnaught.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Hubert Chan <hubert@uhoreg.ca>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050629205636.GN16867@khan.acc.umu.se>
Mail-Followup-To: Markus =?iso-8859-1?Q?T=F6rnqvist?= <mjt@nysv.org>,
	Douglas McNaught <doug@mcnaught.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Hubert Chan <hubert@uhoreg.ca>, Kyle Moffett <mrmacman_g4@mac.com>,
	David Masover <ninja@slaphack.com>, Valdis.Kletnieks@vt.edu,
	Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
	Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	ReiserFS List <reiserfs-list@namesys.com>
References: <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> <m2k6kd2rx8.fsf@Douglas-McNaughts-Powerbook.local> <20050629135820.GJ11013@nysv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050629135820.GJ11013@nysv.org>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 04:58:20PM +0300, Markus   Törnqvist wrote:
> On Wed, Jun 29, 2005 at 09:50:27AM -0400, Douglas McNaught wrote:
> >
> >I'll just note that the "applications bundled as directories" stuff on
> >MacOS/NextStep is done completely in userspace--as far as the kernel
> >is concerned, "Mail.app" is a regular directory.  The file manager
> >handles recognition and invocation of application bundles (and there
> >is an 'open' shell command that does the same thing).
> 
> Note that MacOS has the monopoly on what they ship, Linux has a
> motherload of file managers and window systems and all.
> 
> What pisses me off is the fact that Gnome and friends implement
> their own incompatible-with-others VFS's and automounters and
> stuff.
> 
> Surely supporting this in the kernel and extending the LSB
> to require this is the best step to take without infringing
> anyone's freedom as such.
> 
> *still pissed off about having to hassle an automatic mount*

GNOME and KDE run on operating systems that run other kernels than
Linux, hence they have to implement their own userland VFS anyway.
Adding this to the Linux kernel won't help them one bit, unless
we can magically convince Sun to add it to Solaris, all different
BSD:s to add it to their kernels, etc.  Not going to happen.
An effort to get GNOME and KDE to unify their VFS:s would be
far more benificial, and would if successful probably lead to
other desktop environments (if there are any other DE:s with their
own VFS:s, dunno about that) following their lead.

FreeDesktop is doing a lot of work to make GNOME, KDE, and other
DE:s interoperate as much as possible.  Support their initiative
instead of trying to get a monstrosity (albeit a very cool one,
conceptually) into the kernel.  Sure, it could be made to work,
but not without dropping our Unixness.  And if we do, we should
start by looking at Plan 9 =)


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
