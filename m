Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWIMTJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWIMTJX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWIMTJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:09:23 -0400
Received: from witte.sonytel.be ([80.88.33.193]:226 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750904AbWIMTJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:09:22 -0400
Date: Wed, 13 Sep 2006 21:09:13 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: David Howells <dhowells@redhat.com>, Matthew Wilcox <matthew@wil.cx>,
       Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/6] Implement a general log2 facility in the kernel
In-Reply-To: <20060913184558.GB15563@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.62.0609132108120.27940@pademelon.sonytel.be>
References: <20060913163806.GA15563@flint.arm.linux.org.uk>
 <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com>
 <20060913130300.32022.69743.stgit@warthog.cambridge.redhat.com>
 <20060913161734.GE3564@stusta.de> <20060913163136.GA2585@parisc-linux.org>
 <4143.1158166615@warthog.cambridge.redhat.com>
 <Pine.LNX.4.62.0609132038350.27940@pademelon.sonytel.be>
 <20060913184558.GB15563@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006, Russell King wrote:
> On Wed, Sep 13, 2006 at 08:38:59PM +0200, Geert Uytterhoeven wrote:
> > On Wed, 13 Sep 2006, David Howells wrote:
> > > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > > 
> > > > Therefore, re-using "log2()" is about as bad as re-using the "strcmp()"
> > > > name to implement a function which copies strings.
> > > 
> > > I should probably use ilog2() then which would at least be consistent with the
> > > powerpc arch.
> > > 
> > > > t.c:2: warning: conflicting types for built-in function 'log2'
> > 
> > And apparently gcc < 4.0 doesn't give the warning.
> 
> Eh?  That's gcc 3.4.3 producing that warning.  It probably depends on
> the target configuration.

I have to admit I didn't try all versions. So < 4.0 was a guess, based on the
(Debian) versions I have installed on my laptop...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
