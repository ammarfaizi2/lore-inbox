Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWCPUjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWCPUjA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932724AbWCPUjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:39:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1029 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S932723AbWCPUi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:38:59 -0500
Date: Wed, 15 Mar 2006 23:13:09 +0000
From: Pavel Machek <pavel@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: j4K3xBl4sT3r <jakexblaster@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel config problem between 2.4.x to 2.6.x!
Message-ID: <20060315231309.GC2462@ucw.cz>
References: <436c596f0603121015j2a091ab2sf43d0c5c396bbb72@mail.gmail.com> <7c3341450603121247n7afe018m@mail.gmail.com> <436c596f0603121632qe3151k793fd3ccd9a0eacb@mail.gmail.com> <200603130708.13685.nick@linicks.net> <436c596f0603130342u4d38445bt5e9f129349cda0c8@mail.gmail.com> <1142273196.25358.317.camel@mindpipe> <20060316112523.GA3078@elf.ucw.cz> <1142535968.9395.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142535968.9395.7.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > 1. before, the mouse worked fine. now, it doesnt works
> > > 
> > > Probably /dev/input/mice vs. /dev/psaux isue
> > > 
> > > > 2. before, the sound worked. and now, still working, just with ALSA,
> > > > no OSS support (tested with mpg321 and ogg123 on bash terminal) 
> > > 
> > > 
> > > Best:
> > > aoss ./oss-app
> > > 
> > > Not as good:
> > > modprobe snd-pcm-oss
> > > ./oss-app
> > 
> > Could snd-pcm-oss be fixed? If OSS is to be removed from kernel, it
> > would be nice to have working and compatible emulation.
> 
> Well, snd-pcm-oss is a working and compatible emulation, but it can't
> provide all of the features that ALSA implements in userspace like
> channel routing, mixing of multiple streams, software volume control,
> etc.  So aoss is the recommended way to run OSS apps on a moden distro.

Aha, I see. Does snd-pcm-oss have all the features OSS used to have on
that hardware? If so, sorry for the noise (but please tell me).
								Pavel
-- 
Thanks, Sharp!
