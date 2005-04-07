Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVDGKmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVDGKmp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 06:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVDGKmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 06:42:45 -0400
Received: from witte.sonytel.be ([80.88.33.193]:65236 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262423AbVDGKmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 06:42:37 -0400
Date: Thu, 7 Apr 2005 12:41:33 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>
cc: Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <16980.64324.87931.513333@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.62.0504071236080.9236@numbat.sonytel.be>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <1112858331.6924.17.camel@localhost.localdomain> <20050407015019.4563afe0.akpm@osdl.org>
 <16980.64324.87931.513333@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2005, Paul Mackerras wrote:
> Andrew Morton writes:
> > The problem with those is letting other people get access to it.  I guess
> > that could be fixed with a bit of scripting and rsyncing.
> 
> Yes.

Me too ;-)

> > (I don't do that for -mm because -mm basically doesn't work for 99% of the
> > time.  Takes 4-5 hours to out a release out assuming that nothing's busted,
> > and usually something is).
> 
> With -mm we get those nice little automatic emails saying you've put
> the patch into -mm, which removes one of the main reasons for wanting
> to be able to get an up-to-date image of your tree.  The other reason,

FYI, for Linus' BK tree procmail was telling me, if it encountered a patch on
the commits list which was signed-off by me.

> of course, is to be able to see if a patch I'm about to send conflicts
> with something you have already taken, and rebase it if necessary.

And yet another reason: to monitor if files/subsystems I'm interested in are
changed.

Summarized: I'd be happy with a mailing list that would send out all patches
(incl. full comment headers, cfr. bk-commit) that Linus commits.

An added bonus would be that people would really be able to reconstruct the
full tree from the mails, unlike with bk-commits (due to `strange' csets caused
by merges). Just make sure there are strictly monotone sequence numbers in the
individual mails.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
