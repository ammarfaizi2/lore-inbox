Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUG0Wgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUG0Wgq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUG0Wfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:35:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21241 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266678AbUG0Wf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:35:27 -0400
Date: Wed, 28 Jul 2004 00:35:16 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ed Sweetman <safemode@comcast.net>, Jim Gifford <maillist@jg555.com>,
       "Adam J. Richter" <adam@yggdrasil.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Future devfs plans
Message-ID: <20040727223515.GJ2349@fs.tum.de>
References: <200407261445.i6QEjAS04697@freya.yggdrasil.com> <057601c472a3$9df39ac0$d100a8c0@W2RZ8L4S02> <41044DA6.5080501@comcast.net> <20040726180901.GG11817@fs.tum.de> <41057B58.1040808@comcast.net> <1090963455.1094.106.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090963455.1094.106.camel@mindpipe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 05:24:15PM -0400, Lee Revell wrote:
> On Mon, 2004-07-26 at 17:44, Ed Sweetman wrote:
> > Adrian Bunk wrote:
> > 
> > >On Sun, Jul 25, 2004 at 08:17:42PM -0400, Ed Sweetman wrote:
> > >     
> > >  apt-get install alsa-base
> > >
> > >  
> > >
> > And someone who compiles the kernel for themselves and never needs the 
> > alsa-base deb wouldn't have any ability to create the devices.  MAKEDEV 
> > is the proper place to create devices, not a separate snddevices 
> > script.  This is still a debian bug.
> 
> Ditto someone hacking on ALSA, or who needs to use ALSA CVS to get some
> new feature, who doesn't want to have to build a .deb every time they
> recompile.
>...

Please check the facts before sending such emails (or read at least all 
mails in this thread).

alsa-base does _not_ contain any modules.

alsa-base only contains some scripts like the one that saves the ALSA 
mixer settings on shutdown and restores them after booting.

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

