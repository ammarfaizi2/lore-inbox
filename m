Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264247AbTDWTDM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264250AbTDWTDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:03:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:7649 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264247AbTDWTDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:03:08 -0400
Date: Wed, 23 Apr 2003 16:13:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Ben Collins <bcollins@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
In-Reply-To: <20030423152914.GM820@hottah.alcove-fr>
Message-ID: <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva>
References: <20030423125315.GH820@hottah.alcove-fr> <20030423130139.GD354@phunnypharm.org>
 <20030423132227.GI820@hottah.alcove-fr> <20030423133256.GG354@phunnypharm.org>
 <20030423135814.GJ820@hottah.alcove-fr> <20030423135448.GI354@phunnypharm.org>
 <20030423142131.GK820@hottah.alcove-fr> <20030423142353.GL354@phunnypharm.org>
 <20030423145122.GL820@hottah.alcove-fr> <20030423144857.GN354@phunnypharm.org>
 <20030423152914.GM820@hottah.alcove-fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Apr 2003, Stelian Pop wrote:

> On Wed, Apr 23, 2003 at 10:48:58AM -0400, Ben Collins wrote:
>
> > > As for 2.4.21, well, we want something pretty well tested. Will this
> > > be the case with your new mega-patch ? I don't think so. The safest
> > > is to go back to a version which worked. At least the bugs of that
> > > version are known, which is not the case for the new version.
> >
> > BTW, have you even tested the patch? I can almost guarantee is is more
> > stable than what was in -pre7 (outside of the one small fix I had to
> > apply for the IRM looping). The -pre7 code has loads of irq disabling
> > problems and dead lock issues, not to mention the race conditions.
> >
> > The problem you see with the irq disabling around kernel_thread() may
> > not be there in -pre7, but that's only because the shared data with the
> > thread was not protected from a race condition that causes an oops in
> > some not-so-rare cases.
>
> I confirm that your patch at least solves the initialisation issues.
> I'll test later with some ieee devices and I'll report back if I found
> other issues.

Any news on that, Stelian ?

I guess Ben's mega patch (and yes, I also consider it a megapatch for
-rc) has to be applied. I just mailed him asking about the possibility
of getting only fixes in and not the cleanups, but I guess that might be a
bit hard to do _today_. Right Ben ?

And about the sweet complaints about -pre timing, I will release -pre's
each damn week for .22.

*!@#!&*.
