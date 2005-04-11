Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVDKGsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVDKGsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 02:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVDKGsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 02:48:17 -0400
Received: from witte.sonytel.be ([80.88.33.193]:8619 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261703AbVDKGsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 02:48:13 -0400
Date: Mon, 11 Apr 2005 08:47:01 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: New SCM and commit list
In-Reply-To: <Pine.LNX.4.58.0504102304050.1267@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.62.0504110843460.10263@numbat.sonytel.be>
References: <1113174621.9517.509.camel@gaston> <Pine.LNX.4.58.0504101621200.1267@ppc970.osdl.org>
 <425A10EA.7030607@pobox.com> <Pine.LNX.4.58.0504102304050.1267@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Apr 2005, Linus Torvalds wrote:
> Then the bad news: the merge algorithm is going to suck. It's going to be
> just plain 3-way merge, the same RCS/CVS thing you've seen before. With no

Actually 3-way merge is not that bad. It's definitely better than ClearCase's
merge (I always fall back to RCS merge if ClearCase cannot resolve a merge
automatically).

> understanding of renames etc. I'll try to find the best parent to base the
> merge off of, although early testers may have to tell the piece of crud
> what the most recent common parent was.

Yep, finding the best parent is the important part :-)

I guess 3-way merge got a bad name because CVS always uses the branch point as
the parent, which fails miserably for any but the first merge after the branch.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
