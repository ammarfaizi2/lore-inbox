Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266392AbTGEQWR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 12:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266394AbTGEQWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 12:22:17 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41700
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266392AbTGEQWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 12:22:13 -0400
Date: Sat, 5 Jul 2003 18:36:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Status of the IO scheduler fixes for 2.4
Message-ID: <20030705163635.GH23578@dualathlon.random>
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva> <Pine.LNX.4.55L.0307021927370.12077@freak.distro.conectiva> <1057197726.20903.1011.camel@tiny.suse.com> <Pine.LNX.4.55L.0307041639020.7389@freak.distro.conectiva> <20030705000016.GB23578@dualathlon.random> <Pine.LNX.4.55L.0307051257420.13074@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307051257420.13074@freak.distro.conectiva>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 05, 2003 at 12:59:19PM -0300, Marcelo Tosatti wrote:
> 
> On Sat, 5 Jul 2003, Andrea Arcangeli wrote:
> 
> > On Fri, Jul 04, 2003 at 05:01:54PM -0300, Marcelo Tosatti wrote:
> > > release today), then fix pausing in -pre4. If the IO fairness still doesnt
> >
> > fix pausing is a showstopper bugfix, the box will hang for days without
> > it.
> >
> > lowlatency elevator is for the desktop complains we get about
> > interactivity compared to 2.5, so it's much lower prio than fix pausing.
> > I would never merge fix pausing after lowlatency elevator. But that's
> > just me.
> 
> You're right. I'll merge both patches in -pre3.

agreed, thanks.

> Danke

prego ;)

Andrea
