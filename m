Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263817AbUEMGTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbUEMGTk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 02:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbUEMGTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 02:19:40 -0400
Received: from out-of-band.media.mit.edu ([18.85.16.22]:38661 "EHLO
	out-of-band.media.mit.edu") by vger.kernel.org with ESMTP
	id S263824AbUEMGTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 02:19:37 -0400
Date: Thu, 13 May 2004 02:19:20 -0400 (EDT)
Message-Id: <200405130619.CAA18064@out-of-band.media.mit.edu>
From: foner+x-forcedeth@media.mit.edu
To: c-d.hailfinger.kernel.2004@gmx.net
CC: XFree86@XFree86.Org, manfred@colorfullife.com,
       debian-user@lists.debian.org, linux-kernel@vger.kernel.org,
       foner+x-forcedeth@media.mit.edu
In-reply-to: <409FD316.6010506@gmx.net> (message from Carl-Daniel Hailfinger
	on Mon, 10 May 2004 21:08:06 +0200)
Subject: forcedeth breaks X in Debian-testing 2.4.25 on MSI K7N2 Delta-L mobo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Date: Mon, 10 May 2004 21:08:06 +0200
    From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>

    foner+x-forcedeth@media.mit.edu wrote:

    You could have googled for "forcedeth". The first hit would have given you
    all the information you need. Quoting from there:

    | Send any reports to linux-kernel or netdev@oss.sgi.com and CC:
    | Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net> to get
    | the remaining issues fixed.

You know, I looked at that page at least 3 separate times on different
days, and missed that paragraph -every- time.  It also doesn't help
that my next try was to google for
  forcedeth bug
and
  forcedeth bugs
but that page doesn't mention the word "bug" -anywhere- and hence
fails to show up when someone is looking precisely for where to file
bug reports.  You might want to rephase "send any reports" to be
'send any bug reports" or "send bugs and other reports" so that google
can find the page when people are trying to report a bug.

I'm not sure how to make the paragraph itself more prominent once
someone lands on the page---all I know is that -I- couldn't find it
until I knew it was there and searched for "netdev" via my browser.
Dunno why; I'm not blind or illiterate... :)

    > obviously short-term address of one of its maintainers and an address
    > of another author gleaned a random mailing list.  Doesn't it have its
    > own buglist?  Lots of googling has failed to turn one up and its

    Forcedeth is integrated into current 2.4 and 2.6, so there is no point in
    setting up a dedicated mailing list for it.

Okay.

    > I'm now in the state where I can reliably cause X to not start if
    > forcedeth is loaded, and vice versa.  Logfiles for both cases are
    > appended below.
    > 
    > Does anyone know of a workaround?  It looks like forcedeth is doing
    > something fishy that's breaking X's VESA handling.  Googling for

    forcedeth only accesses the nForce nic. If that confuses the VESA BIOS
    code, the bug most probably is in the BIOS itself.

So do you (or anyone) have any suggestions for what to do?  This is a
reasonably new motherboard (I don't think it has any new firmware
versions out yet) and this leaves me dead in the water---all I can do
at this point is to just try the nVidia drivers and hope they work
better than forcedeth.  (And I'll have to make sure that forcedeth
does -not- get loaded; I'm not yet sure how to ensure that.)

I also don't -know- that's what's going on---all I know is the various
errors (and eventual abort) I get from X if I try to start it up with
forcedeth loaded.
