Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVDMJbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVDMJbJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 05:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVDMJbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 05:31:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12296 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261271AbVDMJbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 05:31:03 -0400
Date: Wed, 13 Apr 2005 10:30:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, David Eger <eger@havoc.gtf.org>,
       Petr Baudis <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
Message-ID: <20050413103052.C1798@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, David Eger <eger@havoc.gtf.org>,
	Petr Baudis <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
	Ross Vandegrift <ross@jose.lug.udel.edu>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050412040519.GA17917@havoc.gtf.org> <20050412081613.GA18545@pasky.ji.cz> <20050412204429.GA24910@havoc.gtf.org> <Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org> <20050412234005.GJ1521@opteron.random> <Pine.LNX.4.58.0504121644430.4501@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0504121644430.4501@ppc970.osdl.org>; from torvalds@osdl.org on Tue, Apr 12, 2005 at 04:45:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 04:45:07PM -0700, Linus Torvalds wrote:
> On Wed, 13 Apr 2005, Andrea Arcangeli wrote:
> > At the rate of 9M for every 198 changeset checkins, that means I'll have
> > to download 2.7G _uncompressible_ (i.e. already compressed with a bad
> > per-file ratio due the too-small files) for a whole pack including all
> > changesets without accounting the original 111MB of the original tree,
> > with rsync -z of git.  That compares with 514M _compressible_ with CVS
> > format on-disk, and with ~79M of the CVS-network download with rsync -z of
> > the CVS repository (assuming default gzip compression level).
> 
> Yes. CVS is much denser.
> 
> CVS is also total crap. So your point is?

And my entire 2.6.12-rc2 BK tree, unchecked out, is about 220MB, which
is more dense than CVS.

BK is also a lot better than CVS.  So _your_ point is?

8)

Note: I'm _not_ arguing with your sentiments towards CVS.  However, I
think the space usage point still stands.

What is the space usage behaviour when you have multiple git trees?
Do we need a git relink command in git-pasky? 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
