Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268556AbTBSNYL>; Wed, 19 Feb 2003 08:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268557AbTBSNYL>; Wed, 19 Feb 2003 08:24:11 -0500
Received: from tomts17-srv.bellnexxia.net ([209.226.175.71]:52659 "EHLO
	tomts17-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268556AbTBSNYK>; Wed, 19 Feb 2003 08:24:10 -0500
Date: Wed, 19 Feb 2003 08:31:27 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: a really annoying feature of the config menu structure
In-Reply-To: <3E538479.1040305@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0302190823270.29022-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003, Helge Hafting wrote:

> Robert P. J. Day wrote:
> >   i finally decided to get serious and start looking at the
> > overall config menu structure, to re-arrange the menus and
> > submenus so that it made more sense and flowed more logically,
> [...]
> >   other areas where this would have made sense would be for
> > something like a "Networking" main menu, with submenus for
> > things like ISDN, Wireless and so on, those all being 
> > subsets of networking.  
> 
> It isn't that simple.  ISDN is more than networking, and even
> useable without it.  Non-network uses of isdn:
> 
> * Making an answering machine or voicemail from a pc
> and one or more isdn cards.
> * Use isdn for dialing into non-IP services like a BBS.
> 
> So you have a choice between sticking all networking
> things in a network menu (and have stuff like ISDN
> spread out in different places (network and other ISDN at least)
> 
> or put all ISDN in one plave and have network etc. spread over
> various networking technologies like today.
> 
> There is no config layout that is "clean" for everybody,
> because it is fundamentally trying to stuff a generic graph
> into a hierarchical tree.

ok, so i could have picked a better example than ISDN as a 
submenu for "Networking", but my main point still stands --
the "Networking support" menu cannot have submenus incorporated
below it without changing the specific Kconfig file for that
directory.  and that gets incredibly messy as one tries to 
follow a menu structure around the various kernel source
directories.  ("Multimedia" was another example of an
unfortunately inflexible menu, so you see my point.)

perhaps you're right -- perhaps there is no nice solution
and there's not much point pursuing this.  but given that
linux is being more widely adopted every day, it's clear
that more and more people are going to be building kernels,
it still might be worth trying to address this before it
goes much further.

i'll go with tomas' suggestion to wait until the new 
config grammar is out.  until then, i'm just going to
play with theoretically reorganizing the menus and see
what eventually makes sense to me, regardless of whether
it's ever implemented or not.

rday



