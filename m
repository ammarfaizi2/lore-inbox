Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264439AbTCXWAa>; Mon, 24 Mar 2003 17:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264443AbTCXWAa>; Mon, 24 Mar 2003 17:00:30 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3332 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264439AbTCXWA3>;
	Mon, 24 Mar 2003 17:00:29 -0500
Date: Tue, 25 Mar 2003 10:14:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: ncunningham@clear.net.nz, linux-kernel@vger.kernel.org,
       swsusp@lister.fornax.hu, rock-linux@rocklinux.org
Subject: Re: Testers wanted: Software Suspend for 2.4
Message-ID: <20030325091406.GC1083@zaurus.ucw.cz>
References: <1048023854.2163.16.camel@laptop-linux.cunninghams> <20030320.233918.730551503.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320.233918.730551503.rene.rebe@gmx.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Thanks for your work!
> 
> I just manged to suspend and resume a freshly booted 2.4.20 + "your
> latest patch" system ;-)
> 
> I had to read the kernel source a hour to do so, because I use devfs
> and naively used resume=/dev/ide/host0/.... which obiously does not
> work.
> 
> For now you might add to the docs that devfs users simply have to use
> the corresponding old /dev/hdX name. If I have too much time I'll take
> a look to make swsuspend devfs aware. But this might not be that soon
> :-(

Is root= devfs aware? If yes fix swsusp
else fix docs.
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

