Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130235AbRAaF2z>; Wed, 31 Jan 2001 00:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130339AbRAaF2q>; Wed, 31 Jan 2001 00:28:46 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:59401 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130235AbRAaF22>; Wed, 31 Jan 2001 00:28:28 -0500
Date: Tue, 30 Jan 2001 23:26:08 -0600
To: Daniel Chemko <dchemko@intrinsyc.com>,
        "Michael B. Trausch" <fd0man@crosswinds.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Off-Topic?]  Mixer device and controls (/dev/mixer)
Message-ID: <20010130232608.A18746@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0101300442420.30532-100000@fd0man.accesstoledo.com> <3A774A2A.6294B6D4@intrinsyc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A774A2A.6294B6D4@intrinsyc.com>; from dchemko@intrinsyc.com on Tue, Jan 30, 2001 at 06:11:38PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Michael B. Trausch]
> > I've noticed that with some audio devices, I have a Bass and Treble
> > setting that I can play with (and usually do, becuase it makes
> > things sound MUCH better).  Why don't I have that in some devices,
> > and is there a way (through the kernel, or through a userspace
> > program) to make up the difference?

[Daniel Chemko]
> I have not really looked into this but I think this option is only
> supported when the audio hardware supports bass and treble.

...and in case the hardware does *not* have such mixer settings, the
right place to introduce them is probably 'esd' or equivalent.  I don't
remember if mpg123 (or its 21st-century equivalent, ogg123) support esd
but I think they do, and if not they should be hacked to.

> > I am building myself a new installation of Linux (from the kernel
> > on up ;p... the Distributions aren't keeping up as much as I want

I've just got to ask: what exactly do you feel you need for which
Debian 'unstable' is not up-to-date?  (Check http://packages.debian.org
to see what versions of things are available in 'unstable'.)  I ask
because in my experience, they have very rarely been more than a few
weeks out of date on any major software, except where a significant
architecture change was involved (such as the migration to xfree86
4.x), or a feature not deemed "ready for prime time" (BIND 9.0)..

> > and I want all my own home-built software anyway, except for X,
> > 'cuz that's a bitch to attempt to compile on my own).

Well, that's understandable - don't compile in support for features you
know you won't need, etc, save maybe 10% of your disk space that way..

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
