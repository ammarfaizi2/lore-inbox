Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293125AbSB1Nt7>; Thu, 28 Feb 2002 08:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293400AbSB1Nrc>; Thu, 28 Feb 2002 08:47:32 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38415 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293395AbSB1NpH>; Thu, 28 Feb 2002 08:45:07 -0500
Date: Thu, 28 Feb 2002 14:44:55 +0100
From: Pavel Machek <pavel@suse.cz>
To: Davidovac Zoran <zdavid@unicef.org.yu>
Cc: Alexander Viro <viro@math.psu.edu>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: /proc/mounts: two different loop devices mounted on same mountpoint?!
Message-ID: <20020228134455.GA28490@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020228095948.GG774@elf.ucw.cz> <Pine.LNX.4.33.0202281200230.15246-100000@unicef.org.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0202281200230.15246-100000@unicef.org.yu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I think that is normal behaviour in 2.4.X
> that one can mount more than once
> on same mount point.

But two different devices? What's the semantics, then?
> > Hi!
> >
> > Kernel 2.4.17:
> >
> > pavel@amd:~/misc$ cat /proc/mounts
> > /dev/root / ext2 rw 0 0
> > /dev/hda3 /suse ext2 rw 0 0
> > none /proc proc rw 0 0
> > none /proc/bus/usb usbdevfs rw 0 0
> > /dev/cfs0 /overlay coda rw 0 0
> > /dev/loop0 /mnt ext2 rw 0 0
> > /dev/loop1 /mnt ext2 rw 0 0
> > pavel@amd:~/misc$
> >
> > Both /dev/loop0 *and* /dev/loop1 mounted on /mnt at same time? Oops?
> > What's the semantics of that? [And I guess it should not be allowed)
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
