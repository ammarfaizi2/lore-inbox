Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWF2KsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWF2KsY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 06:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbWF2KsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 06:48:24 -0400
Received: from gate.perex.cz ([85.132.177.35]:48313 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932199AbWF2KsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 06:48:23 -0400
Date: Thu, 29 Jun 2006 12:48:22 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103-a.perex-int.cz
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ALSA PATCH] HG repo sync
In-Reply-To: <s5h4py4p7lz.wl%tiwai@suse.de>
Message-ID: <Pine.LNX.4.61.0606291244470.10575@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0606291138030.10575@tm8103-a.perex-int.cz>
 <20060629025306.455c89ce.akpm@osdl.org> <s5h4py4p7lz.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006, Takashi Iwai wrote:

> At Thu, 29 Jun 2006 02:53:06 -0700,
> Andrew Morton wrote:
> > 
> > On Thu, 29 Jun 2006 11:39:35 +0200 (CEST)
> > Jaroslav Kysela <perex@suse.cz> wrote:
> > 
> > > Linus, please do an update from:
> > > 
> > >   http://www.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
> > >
> > 
> > As far as I can tell none of this has had any testing in -mm.
> 
> Hmm, it's the result of infrequent update of alsa git tree...

Nope for this case. All patches prepared for the mainstream sync landed to 
the ALSA HG repo in last week (since 2006/06/23).

> > What can we do about this?
> 
> In this patchset, the biggest patch is the addition of echoaudio driver. 
> It's OK to postpone this for 2.6.19.  But this driver has been tested 
> over three years although unfortunately it didn't land to mm by mistake 
> (we forgot to move the code after 2.6.17 feature freeze).
> 
> Another relatively big patch is the fix for realtek codecs.  This is
> no intrusive patch but addition of the support of more new devices.
> It should get in, if we want to reduce the future bugzilla entries :)
> 
> The rest are obvious fixes, picked up from LKML and alsa-devel.  They
> need to be merged anyway sooner or later.

I agree. The merging of experimental code is postponed, but all other 
patches should go before first rc to mainstream in my opinion, too.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
