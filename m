Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129190AbRBAGPI>; Thu, 1 Feb 2001 01:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbRBAGO6>; Thu, 1 Feb 2001 01:14:58 -0500
Received: from mdmgrp2-6.accesstoledo.net ([207.43.107.6]:29444 "EHLO
	rosswinds.net") by vger.kernel.org with ESMTP id <S129190AbRBAGOu>;
	Thu, 1 Feb 2001 01:14:50 -0500
Date: Wed, 31 Jan 2001 01:14:11 -0500 (EST)
From: "Michael B. Trausch" <fd0man@crosswinds.net>
To: "Michael J. Dikkema" <mjd@moot.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 - can't read root fs (devfs maybe?)
In-Reply-To: <Pine.LNX.4.21.0101312258190.227-100000@sliver.moot.ca>
Message-ID: <Pine.LNX.4.21.0101310111120.3842-100000@fd0man.accesstoledo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Michael J. Dikkema wrote:
> 
> I went from 2.4.0 to 2.4.1 and was surprised that either the root
> filesystem wasn't mounted, or it couldn't be read. I'm using devfs.. I'm
> thinking there might have been a change with regards to the devfs
> tree.. is the legacy /dev/hda1 still /dev/discs/disc0/part1?
> 

First off, are you using ext2fs for your main filesystem (for /)?  If so,
are there any *other* errors?

Also, /dev/hda1 == /dev/ide/host0/bus0/target0/lun0/part1 on my computer,
Kernel 2.4.1, with devfs enabled.  It can also be referenced via another
symlink (/dev/ide/hd/c0b0t0u0p1), which is the same thing.

	- Mike

===========================================================================
Michael B. Trausch                                    fd0man@crosswinds.net
Avid Linux User since April, '96!                           AIM:  ML100Smkr

              Contactable via IRC (DALNet) or AIM as ML100Smkr
===========================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
