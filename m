Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289532AbSAWWtA>; Wed, 23 Jan 2002 17:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289511AbSAWWsz>; Wed, 23 Jan 2002 17:48:55 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:8461 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S289532AbSAWWp4>;
	Wed, 23 Jan 2002 17:45:56 -0500
Date: Wed, 23 Jan 2002 12:31:22 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jakob ?stergaard <jakob@unthought.net>,
        Ville Herva <vherva@twilight.cs.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 18, 2002
Message-ID: <20020123113122.GC965@elf.ucw.cz>
In-Reply-To: <20020119232455.D12692@unthought.net> <Pine.GSO.4.21.0201191749300.5397-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0201191749300.5397-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > All this seems very neat. One question: what about forced umount / forced
> > > remount readonly stuff? Any plans on that?
> > > 
> > 
> > That would be *very* nice indeed.  Even if it was only for things like NFS
> > and SMBFS.
> 
> umount(mountpoint, MNT_DETACH);
> 
> Had been there for quite a while...
> 
> It's not a forced umount - it detaches the subtree from mountpoint and
> filesystem(s) go away when they stop being busy.  But for remote
> filesystems that's precisely what you want.

Can I umount filesystems below them? Can I reboot with
busy-but-detached filesystems? Can I kill the processes accessing busy
filesystems? [That was big point of force umount, I believe.]
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
