Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWBWRzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWBWRzd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWBWRzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:55:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:56036 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932380AbWBWRzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:55:31 -0500
Date: Thu, 23 Feb 2006 09:52:42 -0800
From: Greg KH <gregkh@suse.de>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Gabor Gombas <gombasg@sztaki.hu>,
       "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060223175242.GA32750@suse.de>
References: <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org> <20060222154820.GJ16648@ca-server1.us.oracle.com> <20060222162533.GA30316@thunk.org> <20060222173354.GJ14447@boogie.lpds.sztaki.hu> <20060222185923.GL16648@ca-server1.us.oracle.com> <20060222191832.GA14638@suse.de> <1140636588.2979.66.camel@laptopd505.fenrus.org> <20060222194024.GA15703@suse.de> <43FDF10E.3030001@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FDF10E.3030001@mbligh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 09:29:50AM -0800, Martin Bligh wrote:
> >I totally agree.  Distros are changing into two different groups these
> >days:
> >	- everything tied together and intregrated nicely for a specific
> >	  kernel version, userspace tool versions, etc.
> >	- flexible and works with multiple kernel versions, different
> >	  userspace tools, etc.
> >
> >Distros in the first category are the "enterprise" releases (RHEL, SLES,
> >etc.), as well as some consumer oriented distros (SuSE, Ubuntu, Fedora
> >possibly.)
> >
> >More flexible distros that handle different kernel versions are Gentoo,
> >Debian, and probably Fedora.
> >
> >And this is a natural progression as people try to provide a more
> >complete "solution" for users.
> >
> >When people to complain that they can't run a "kernel-of-the-day" on
> >their "enterprise" distro, they are not realizing that that distro was
> >just not developed to support that kind of thing at all.
> >
> >So, in short, if you are going to do kernel development, pick a distro
> >that handles different kernel versions.  Likewise, if you are doing
> >userspace development (X.org, HAL, KDE, Gnome, etc.) you pick a distro
> >that allows you to change that level of the stack.
> 
> That sort of thing is going to make distros incredibly reluctant to 
> update kernels, which just encourages them to operate inside their own
> fiefdoms, rather than working together with mainline, which is what we
> want.

They are very reluctant to upgrade kernels today, for released versions
of the distro, and so they backport kernel fixes and security updates to
that older kernel, just like all of the packages in a distro.  That's
they way they work.

But they work together with mainline as they need it for their _next_
release that happens again in 6 months or so, with the updated kernel
and everything else.

thanks,

greg k-h
