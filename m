Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbVCVEcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVCVEcv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVCVE05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:26:57 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47586 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262367AbVCVEQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:16:47 -0500
Subject: Re: ALSA bugs in list [was Re: 2.6.12-rc1-mm1]
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       apatard@mandrakesoft.com, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20050321201040.2a241f15.akpm@osdl.org>
References: <20050321025159.1cabd62e.akpm@osdl.org>
	 <20050321202022.B16069@flint.arm.linux.org.uk>
	 <20050321124159.0fbf1bef.akpm@osdl.org> <1111463491.3058.15.camel@mindpipe>
	 <20050321201040.2a241f15.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 21 Mar 2005 23:16:42 -0500
Message-Id: <1111465002.3058.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 20:10 -0800, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > On Mon, 2005-03-21 at 12:41 -0800, Andrew Morton wrote:
> >  > From: bugme-daemon@osdl.org
> >  > Subject: [Bug 4282] ALSA driver in Linux 2.6.11 causes a kernel panic when loading the EMU10K1 driver
> >  > 
> > 
> >  This one is a real mystery.  No one can reproduce it.
> 
> OK.  But we don't seem to have heard from the originator since March 5th.
> 
> >  > From: bugme-daemon@osdl.org
> >  > Subject: [Bugme-new] [Bug 4348] New: snd_emu10k1 oops'es with Audigy 2 and
> >  > 
> > 
> >  This one is fixed in ALSA CVS.
> 
> But not in http://linux-sound.bkbits.net/linux-sound yet.  How does stuff
> propagate from ALSA CVS into bk?
> 
> 

The ALSA maintainers periodically ask Linus to pull from the linux-sound
tree.  But that's just the general "ALSA update" process.

I'm not aware of a mechanism for getting critical fixes like this in
ASAP.  The last few have been shepherded through manually by various
people.  Looks like we need a better system.

Lee

