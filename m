Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUBEArC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbUBEApv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:45:51 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:3789 "EHLO fed1mtao03.cox.net")
	by vger.kernel.org with ESMTP id S265125AbUBEAcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:32:35 -0500
Date: Wed, 4 Feb 2004 17:32:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mundt <lethal@linux-sh.org>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kgdb support in vanilla 2.6.2
Message-ID: <20040205003234.GB5219@smtp.west.cox.net>
References: <20040204230133.GA8702@elf.ucw.cz> <20040204235215.GA1086@smtp.west.cox.net> <20040205001733.GA31020@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205001733.GA31020@linux-sh.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 07:17:33PM -0500, Paul Mundt wrote:
> On Wed, Feb 04, 2004 at 04:52:15PM -0700, Tom Rini wrote:
> > > +++ b/Documentation/sh/kgdb.txt Tue Feb  3 19:45:43 2004
> > > @@ -0,0 +1,179 @@
> > > +
> > > +This file describes the configuration and behavior of KGDB for the SH
> > > +kernel. Based on a description from Henry Bell <henry.bell@st.com>, it
> > > +has been modified to account for quirks in the current implementation.
> > > +
> > > 
> > > That's great, can we get i386 kgdb, too? Or at least amd64 kgdb
> > > ;-). [Or was it a mistake? It seems unlikely that kgdb could enter
> > > Linus tree without major flamewar...]
> > 
> > FWIW, there has been PPC32 KGDB support in kernel.org for ages.  OTOH,
> > I'm quite happy that SH kgdb support came in (mental note made to talk
> > to Henry about the KGDB merging stuffs).
> > 
> The SH kgdb work is a combination of effort by Henry Bell and Jeremy Siegel,
> (ST and MV both had their own versions, Jeremy did the sync work between
> the two) neither of which have touched it since mid 2.4 or so when it was
> first merged into the LinuxSH tree.
> 
> Getting the SH kgdb stuff updated is on my TODO list, I'd definitely be
> interested in getting this stuff in sync with Amit's work as well. Any
> pointers?

What Amit has is at http://kgdb.sf.net/
What I've done on top of this is at bk://ppc.bkbits.net/linux-2.6-kgdb
and http://www.codemonkey.org.uk/projects/bitkeeper/kgdb .

-- 
Tom Rini
http://gate.crashing.org/~trini/
