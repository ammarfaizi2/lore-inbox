Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVCVE2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVCVE2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVCVE1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:27:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:58820 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262312AbVCVEXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:23:35 -0500
Date: Mon, 21 Mar 2005 20:23:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       apatard@mandrakesoft.com, perex@suse.cz, tiwai@suse.de
Subject: Re: ALSA bugs in list [was Re: 2.6.12-rc1-mm1]
Message-Id: <20050321202303.58300ec6.akpm@osdl.org>
In-Reply-To: <1111465002.3058.26.camel@mindpipe>
References: <20050321025159.1cabd62e.akpm@osdl.org>
	<20050321202022.B16069@flint.arm.linux.org.uk>
	<20050321124159.0fbf1bef.akpm@osdl.org>
	<1111463491.3058.15.camel@mindpipe>
	<20050321201040.2a241f15.akpm@osdl.org>
	<1111465002.3058.26.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> On Mon, 2005-03-21 at 20:10 -0800, Andrew Morton wrote:
> > Lee Revell <rlrevell@joe-job.com> wrote:
> > >
> > > On Mon, 2005-03-21 at 12:41 -0800, Andrew Morton wrote:
> > >  > From: bugme-daemon@osdl.org
> > >  > Subject: [Bug 4282] ALSA driver in Linux 2.6.11 causes a kernel panic when loading the EMU10K1 driver
> > >  > 
> > > 
> > >  This one is a real mystery.  No one can reproduce it.
> > 
> > OK.  But we don't seem to have heard from the originator since March 5th.
> > 
> > >  > From: bugme-daemon@osdl.org
> > >  > Subject: [Bugme-new] [Bug 4348] New: snd_emu10k1 oops'es with Audigy 2 and
> > >  > 
> > > 
> > >  This one is fixed in ALSA CVS.
> > 
> > But not in http://linux-sound.bkbits.net/linux-sound yet.  How does stuff
> > propagate from ALSA CVS into bk?
> > 
> > 
> 
> The ALSA maintainers periodically ask Linus to pull from the linux-sound
> tree.  But that's just the general "ALSA update" process.

Oh.  I was always under the impression that
http://linux-sound.bkbits.net/linux-sound contains the latest devel stuff
for -mm.

> I'm not aware of a mechanism for getting critical fixes like this in
> ASAP.  The last few have been shepherded through manually by various
> people.  Looks like we need a better system.
> 

It's not a trivial problem.
