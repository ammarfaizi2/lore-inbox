Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282959AbRLIEDb>; Sat, 8 Dec 2001 23:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282961AbRLIEDW>; Sat, 8 Dec 2001 23:03:22 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:24080 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S282959AbRLIEDG>; Sat, 8 Dec 2001 23:03:06 -0500
Date: Sun, 9 Dec 2001 05:02:49 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Roman Zippel <zippel@linux-m68k.org>, Rene Rebe <rene.rebe@gmx.net>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@lists.sourceforge.net>
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] 
 /ALSA-0.9.0beta[9,10]
In-Reply-To: <200112090308.fB938N504764@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0112090447290.13049-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 8 Dec 2001, Richard Gooch wrote:

> > devfs_mk_dir returns an error now, so the driver won't be able to
> > make new dev nodes available. So far it was legal to manually create
> > a directory under devfs, now it's suddenly an error.
>
> It was always an error, you just got away with it.

Sorry, but this is bullshit. You even included an example script with this
"error" (Documentation/filesystems/devfs/rc.devfs). You suddenly change
the behaviour of devfs during a stable release in a noncompatible way.
Distributions and their users that followed _your_ advice are suddenly
fucked up, that's irresponsible. How do you think devfs should be ever
taken seriously?

bye, Roman

