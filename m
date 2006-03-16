Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932714AbWCPTGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbWCPTGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbWCPTGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:06:14 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:34235 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932714AbWCPTGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:06:12 -0500
Subject: Re: Kernel config problem between 2.4.x to 2.6.x!
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: j4K3xBl4sT3r <jakexblaster@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060316112523.GA3078@elf.ucw.cz>
References: <436c596f0603121015j2a091ab2sf43d0c5c396bbb72@mail.gmail.com>
	 <7c3341450603121247n7afe018m@mail.gmail.com>
	 <436c596f0603121632qe3151k793fd3ccd9a0eacb@mail.gmail.com>
	 <200603130708.13685.nick@linicks.net>
	 <436c596f0603130342u4d38445bt5e9f129349cda0c8@mail.gmail.com>
	 <1142273196.25358.317.camel@mindpipe>  <20060316112523.GA3078@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 14:06:07 -0500
Message-Id: <1142535968.9395.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 12:25 +0100, Pavel Machek wrote:
> On Po 13-03-06 13:06:35, Lee Revell wrote:
> > On Mon, 2006-03-13 at 08:42 -0300, j4K3xBl4sT3r wrote:
> > > 1. before, the mouse worked fine. now, it doesnt works
> > 
> > Probably /dev/input/mice vs. /dev/psaux isue
> > 
> > > 2. before, the sound worked. and now, still working, just with ALSA,
> > > no OSS support (tested with mpg321 and ogg123 on bash terminal) 
> > 
> > 
> > Best:
> > aoss ./oss-app
> > 
> > Not as good:
> > modprobe snd-pcm-oss
> > ./oss-app
> 
> Could snd-pcm-oss be fixed? If OSS is to be removed from kernel, it
> would be nice to have working and compatible emulation.

Well, snd-pcm-oss is a working and compatible emulation, but it can't
provide all of the features that ALSA implements in userspace like
channel routing, mixing of multiple streams, software volume control,
etc.  So aoss is the recommended way to run OSS apps on a moden distro.

Lee

