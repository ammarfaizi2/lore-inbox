Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbRDBXOL>; Mon, 2 Apr 2001 19:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131508AbRDBXOE>; Mon, 2 Apr 2001 19:14:04 -0400
Received: from waste.org ([209.173.204.2]:5733 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S131497AbRDBXNp>;
	Mon, 2 Apr 2001 19:13:45 -0400
Date: Mon, 2 Apr 2001 18:12:25 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Tom Leete <tleete@mountain.net>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, David Lang <dlang@diginsite.com>,
   Manfred Spraul <manfred@colorfullife.com>,
   "Albert D. Cahalan" <acahalan@cs.uml.edu>, <lm@bitmover.com>,
   <linux-kernel@vger.kernel.org>
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <3AC9058F.580E268B@mountain.net>
Message-ID: <Pine.LNX.4.30.0104021808040.29801-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Apr 2001, Tom Leete wrote:

> Oliver Xymoron wrote:
> >
> > On Sun, 1 Apr 2001, Jeff Garzik wrote:
> >
> > > On Sun, 1 Apr 2001, David Lang wrote:
> > > > if we want to get the .config as part of the report then we need to make
> > > > it part of the kernel in some standard way (the old /proc/config flamewar)
> > > > it's difficult enough sometimes for the sysadmin of a box to know what
> > > > kernel is running on it, let alone a bug reporting script.
> > >
> > > Let's hope it's not a flamewar, but here goes :)
> > >
> > > We -need- .config, but /proc/config seems like pure bloat.
> >
> > As a former proponent of /proc/config (I wrote one of the much-debated
> > patches), I tend to agree. Debian's make-kpkg does the right thing, namely
> > treating .config the same way it treats System-map, putting it in the
> > package and eventually installing it in /boot/config-x.y.z. If Redhat's
> > kernel-install script did the same it would rapidly become a non-issue.
>
> How about /lib/modules/$(uname -r)/build/.config ? It's already there.

It'd be great if we got away from the config being hidden too.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

