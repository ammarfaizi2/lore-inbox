Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319184AbSHWTtU>; Fri, 23 Aug 2002 15:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319262AbSHWTtU>; Fri, 23 Aug 2002 15:49:20 -0400
Received: from [195.39.17.254] ([195.39.17.254]:21120 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319184AbSHWTs6>;
	Fri, 23 Aug 2002 15:48:58 -0400
Date: Fri, 2 Nov 2001 07:36:57 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Larry McVoy <lm@bitmover.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20011102073657.R35@toy.ucw.cz>
References: <Pine.GSO.4.21.0208162057550.14493-100000@weyl.math.psu.edu> <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Aug 16, 2002 at 06:35:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

>  - phase 2: IDE-TNG. Leave the current IDE code unchanged, and plan to 
>    obsolete it. It's the "stable IDE", and by virtue of being stable, 
>    nobody will mind work on new drivers that (by definition) cannot screw 
>    up unless you use them.
> 
>    IDE-TNG would:
>     - be controller-specific (ie one driver for one controller family)
>     - be able to say "screw it" for old or broken setups (which are left 
>       fot the old IDE code)
>     - in particular, it would only bother with PCI (or better) 
>       controllers, and with UDMA-only setups.

Would it be possible to use martin's IDE as starting point for IDE-TNG? Awfull
lot of cleanups went to that code...
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

