Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313705AbSDUSH4>; Sun, 21 Apr 2002 14:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313706AbSDUSHz>; Sun, 21 Apr 2002 14:07:55 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:1445 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313705AbSDUSHy>;
	Sun, 21 Apr 2002 14:07:54 -0400
Date: Sun, 21 Apr 2002 14:07:53 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Larry McVoy <lm@work.bitmover.com>, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org,
        Wayne Scott <wscott@work.bitmover.com>
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020421140753.C8142@havoc.gtf.org>
In-Reply-To: <20020421044616.5beae559.spyro@armlinux.org> <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu> <20020421131354.C4479@havoc.gtf.org> <20020421102339.E10525@work.bitmover.com> <20020421133225.F4479@havoc.gtf.org> <20020421103923.I10525@work.bitmover.com> <20020421134500.A7828@havoc.gtf.org> <20020421104725.K10525@work.bitmover.com> <20020421134955.C7828@havoc.gtf.org> <20020421105706.M10525@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 10:57:06AM -0700, Larry McVoy wrote:
> On Sun, Apr 21, 2002 at 01:49:55PM -0400, Jeff Garzik wrote:
> > I know, but graphical is useless to me...
> > Give me text/plain GNU-style patches, that I can spit out without
> > requiring X. :)
> 
> I did.  Install those triggers and you've got it.  Sorry to sound
> uncooperative but the trigger mechanism is there to handle this, and
> email notification, and automatic mirroring, and ...

(did you miss that we're off on a tangent?  :))

If we are talking about 'bk diffs -C' for Linus, agreed.

But you started talking about the nifty feature of seeing what you
downloaded in the last 'bk pull'.

Triggers are completely useless for "show me what the next-to-last
'bk pull' downloaded, in GNU patch style."  It's unrealistic to assume
that everybody is gonna set up triggers and their own cset GNU patch
archive, just to provide themselves with this capability.  Especally
when (IMO) bk can generate that stuff on the fly.

If BK knows a single basic unit of information -- the list of csets
downloaded in each 'bk pull' -- then it should be able to generate
patches for those csets.  Or at the very least, have a bk command
that spits out that list of csets, and user-written scripts take it
from there.

	Jeff



