Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284405AbRLDBpw>; Mon, 3 Dec 2001 20:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284607AbRLDAN7>; Mon, 3 Dec 2001 19:13:59 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16389 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S285361AbRLCXCN>; Mon, 3 Dec 2001 18:02:13 -0500
Date: Tue, 4 Dec 2001 00:02:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ENTRY macro (coda maintainers please listen)
Message-ID: <20011204000214.A20670@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011202215232.A1751@elf.ucw.cz> <20011203155805.A7057@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011203155805.A7057@cs.cmu.edu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It would be good to rename one of them (they are probably not needed
> > in one module, anyway, that's not clean)...
> 
> Actually all coda_XXX.h files don't even have to be in include/linux/,
> only coda.h contains structs/defines that should be 'visible' outside of
> the Coda kernel code, anything else should just go to fs/coda and get a
> good dust off to remove a bunch of cruft.

There's no reason to move them... include/linux is as good place as
fs/coda.

> > Oh and there's no entry for CODA in MAINTAINERS file. You probably
> > want to fix that.
> 
> Gee, oh well. I didn't consider it 'critical bug-fixes only' or
> important enough to push a patch for a maintainers entry into a stable
> series, and obviously wasn't paying attention during 2.3
> development.

It is bug-fix, and very easy to see it does not break anything. *That*
kind of fixes is welcome anytime ;-).

> Besides I've been sending you updates whenever something critical
> changes in coda.o (considering you are using it for podfuk). I would
> figure that of all people at least you would know.

(-: Sorry.
								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
