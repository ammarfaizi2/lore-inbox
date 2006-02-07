Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWBGXDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWBGXDK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWBGXDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:03:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14984 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030234AbWBGXDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:03:08 -0500
Date: Wed, 8 Feb 2006 00:02:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Jim Crilly <jim@why.dont.jablowme.net>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060207230245.GD2753@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1139282017.2041.44.camel@mindpipe> <20060207093737.GC1742@elf.ucw.cz> <200602071940.53843.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602071940.53843.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Personally I agree with you on suspend2, I think this is something that
> > > needed to Just Work yesterday, and every day it doesn't work we are
> > > losing users... but who am I to talk, I'm not the one who will have to
> > > maintain it.
> > 
> > It does just work in mainline now. If it does not please open bug
> > account at bugzilla.kernel.org.
> > 
> > If mainline swsusp is too slow for you, install uswsusp. If it is
> > still too slow for you, mail me a patch adding LZW to userland code
> > (should be easy).
> 
> <horrified rebuke>
> 
> Pavel!
> 
> Responses like this are precisely why you're not the most popular kernel 
> maintainer. Telling people to use beta (alpha?) code or fix it

I do not *want* to be the most popular maintainer. That is your place ;-).

> themselves 
> (and then have their patches rejected by you) is no way to maintain a part 
> of the kernel. Stop being a liability instead of an asset!

Ugh?

Lee is a programmer. He wants faster swsusp, and improving uswsusp is
currently best way to get that. It may be alpha/beta quality, but
someone has to start testing, and Lee should be good for that (played
with realtime kernels etc...). Actually it is in good enough state
that I'd like non-programmers to test it, too.

And yes, I'm a maintainer, and that means I have to reject bad
patches from time to time, too.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
