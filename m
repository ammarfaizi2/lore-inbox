Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263626AbTCURca>; Fri, 21 Mar 2003 12:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263669AbTCURca>; Fri, 21 Mar 2003 12:32:30 -0500
Received: from mail-5.tiscali.it ([195.130.225.151]:44676 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S263626AbTCURc2>;
	Fri, 21 Mar 2003 12:32:28 -0500
Date: Fri, 21 Mar 2003 18:42:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>, Pavel Machek <pavel@suse.cz>,
       Roman Zippel <zippel@linux-m68k.org>, Nicolas Pitre <nico@cam.org>,
       Ben Collins <bcollins@debian.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030321174247.GD3517@dualathlon.random>
References: <Pine.LNX.4.44.0303161341520.5348-100000@xanadu.home> <Pine.LNX.4.44.0303162014090.12110-100000@serv> <20030316215219.GX1252@dualathlon.random> <20030317215639.GG15658@atrey.karlin.mff.cuni.cz> <20030317220830.GM1324@dualathlon.random> <20030321141620.GA25142@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321141620.GA25142@work.bitmover.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 06:16:20AM -0800, Larry McVoy wrote:
> On Mon, Mar 17, 2003 at 11:08:30PM +0100, Andrea Arcangeli wrote:
> > > Actually, fact that "longest path" algorithm may well choose
> > > non-mainline branch because it likes it more worries me a bit.
> > 
> > AFIK it's supposed to be the "longest path" of Linus's and Marcelo's
> > branches which means it'll reproduce all the modifcations of the
> > mainline trees only.
> 
> By the way, we've been incrementally updating both trees and while in 
> theory the incremental could result in shorter paths with less detail,
> so far the incremental export and the one pass export result in exactly
> the same path:
> 
>     slovax $ bk _eventpath 1.0 + | wc -l
>        8498
>     slovax $ cd ../linux-2.5-cvs/linux-2.5
>     slovax $ rlog -r -N ChangeSet | grep revision
>     revision 1.8498
> 
> I've actually reimported the data in one pass and diffed the RCS files,
> it's the same.
> 
> HPA, should we be mirroring the CVS tarballs to kernel.org?

fine thanks!

BTW, CVS kernel + cvsps is just been extremely useful to me so far.

I also run into some huge patches like PatchSet 4711 in the 2.5 tree
that I would love if it could be splitted properly but I understand it's
impossible, right?

Thank you very much again for this great open service!

Andrea
