Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbTDWTRY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264621AbTDWTRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:17:24 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:40419 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264610AbTDWTRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:17:15 -0400
Date: Wed, 23 Apr 2003 16:27:50 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Ben Collins <bcollins@debian.org>
Cc: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
In-Reply-To: <20030423190545.GY354@phunnypharm.org>
Message-ID: <Pine.LNX.4.53L.0304231626510.7085@freak.distro.conectiva>
References: <20030423132227.GI820@hottah.alcove-fr> <20030423133256.GG354@phunnypharm.org>
 <20030423135814.GJ820@hottah.alcove-fr> <20030423135448.GI354@phunnypharm.org>
 <20030423142131.GK820@hottah.alcove-fr> <20030423142353.GL354@phunnypharm.org>
 <20030423145122.GL820@hottah.alcove-fr> <20030423144857.GN354@phunnypharm.org>
 <20030423152914.GM820@hottah.alcove-fr> <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva>
 <20030423190545.GY354@phunnypharm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a

On Wed, 23 Apr 2003, Ben Collins wrote:

> > > > The problem you see with the irq disabling around kernel_thread() may
> > > > not be there in -pre7, but that's only because the shared data with the
> > > > thread was not protected from a race condition that causes an oops in
> > > > some not-so-rare cases.
> > >
> > > I confirm that your patch at least solves the initialisation issues.
> > > I'll test later with some ieee devices and I'll report back if I found
> > > other issues.
> >
> > Any news on that, Stelian ?
> >
> > I guess Ben's mega patch (and yes, I also consider it a megapatch for
> > -rc) has to be applied. I just mailed him asking about the possibility
> > of getting only fixes in and not the cleanups, but I guess that might be a
> > bit hard to do _today_. Right Ben ?
>
> Yeah, it's pretty hard. I didn't do all these changes with the intent of
> it being a 2.4.21 thing, but it definitely dragged on to the point where
> I had no choice, and pulling the fixes out of the major work became too
> much work.
>
> > And about the sweet complaints about -pre timing, I will release -pre's
> > each damn week for .22.
>
> If you could just commit patches to the bk repo as you get them, instead
> of holding them for a month and dumping them all in at once, it would be
> easier to follow things. Instead, we got several huge lumps late in
> 2.4.21-pre's.
>
> Wasn't my intent to bash you, but I will admit that 2.4.21 has been a
> pain in my ass because of the cycle :)

I also agree that 2.4.21 was a _too_ long cycle. Very bad thing indeed.

Well, the megapatch is in bk already (together with some other stuff).

-rc2 should be out today.
