Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265125AbUD3JQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUD3JQg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 05:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265126AbUD3JQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 05:16:36 -0400
Received: from witte.sonytel.be ([80.88.33.193]:41722 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265125AbUD3JQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 05:16:33 -0400
Date: Fri, 30 Apr 2004 11:16:13 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Timothy Miller <miller@techsource.com>
cc: Rik van Riel <riel@redhat.com>, Marc Boucher <marc@linuxant.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <40911C01.80609@techsource.com>
Message-ID: <Pine.GSO.4.58.0404301115190.8585@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com>
 <40911C01.80609@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004, Timothy Miller wrote:
> Rik van Riel wrote:
> > On Wed, 28 Apr 2004, Marc Boucher wrote:
> >>At the same time, I think that the "community" should, without
> >>relinquishing its principles, be less eager before getting the facts to
> >>attack people and companies trying to help in good faith, and be more
> >>realistic when it comes to satisfying practical needs of ordinary
> >>users.
> >
> > I wouldn't be averse to changing the text the kernel prints
> > when loading a module with an incompatible license. If the
> > text "$MOD_FOO: module license '$BLAH' taints kernel." upsets
> > the users, it's easy enough to change it.
> >
> > How about the following?
> >
> > "Due to $MOD_FOO's license ($BLAH), the Linux kernel community
> > cannot resolve problems you may encounter. Please contact
> > $MODULE_VENDOR for support issues."
>
> Sounds very "politically correct", but certainly more descriptive and
> less alarming.

And I suggest not to print $MODULE_VENDOR, but `the supplier of $MOD_FOO' to
prevent people playing games with $MODULE_VENDOR (e.g. pointing it to lkml).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
