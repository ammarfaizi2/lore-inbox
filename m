Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVCVKKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVCVKKz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVCVKI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:08:26 -0500
Received: from gate.perex.cz ([82.113.61.162]:14989 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S262601AbVCVKGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:06:33 -0500
Date: Tue, 22 Mar 2005 11:06:24 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org, apatard@mandrakesoft.com,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: ALSA bugs in list [was Re: 2.6.12-rc1-mm1]
In-Reply-To: <1111465002.3058.26.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0503221101060.1787@pnote.perex-int.cz>
References: <20050321025159.1cabd62e.akpm@osdl.org> 
 <20050321202022.B16069@flint.arm.linux.org.uk>  <20050321124159.0fbf1bef.akpm@osdl.org>
 <1111463491.3058.15.camel@mindpipe>  <20050321201040.2a241f15.akpm@osdl.org>
 <1111465002.3058.26.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Lee Revell wrote:

> > >  This one is fixed in ALSA CVS.
> > 
> > But not in http://linux-sound.bkbits.net/linux-sound yet.  How does stuff
> > propagate from ALSA CVS into bk?
> 
> The ALSA maintainers periodically ask Linus to pull from the linux-sound
> tree.  But that's just the general "ALSA update" process.
> 
> I'm not aware of a mechanism for getting critical fixes like this in
> ASAP.  The last few have been shepherded through manually by various
> people.  Looks like we need a better system.

I am trying to sync the linux-sound BK tree every week with our CVS.
For "urgent" fixes we need to find another faster way. Hopefully, they
are in most cases small enough, so they might be propagated automagically.
I already proposed special "tag" in our CVS commit policy, so we can 
identify these patches / changesets.

I will try to prepare some useable tool in few weeks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
