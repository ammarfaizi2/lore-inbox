Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbUJZFxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbUJZFxN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 01:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbUJZFxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 01:53:11 -0400
Received: from sd291.sivit.org ([194.146.225.122]:40935 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262157AbUJZFvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 01:51:21 -0400
Date: Tue, 26 Oct 2004 07:55:31 +0200
From: Stelian Pop <stelian@popies.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Message-ID: <20041026055530.GA2885@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Pavel Machek <pavel@ucw.cz>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <200410210154.58301.dtor_core@ameritech.net> <20041025125629.GF6027@crusoe.alcove-fr> <200410250822.46023.dtor_core@ameritech.net> <20041025135635.GB3161@crusoe.alcove-fr> <20041025220921.GA5207@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025220921.GA5207@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 12:09:21AM +0200, Pavel Machek wrote:

> > Ok. Suspending never really worked on my laptop so I'll have to assume
> > you're correct. :)
> > 
> > [ Just tried once again to do a suspend to ram, seems that there were
> > some enhancements in this area lately. 
> > 
> >   No luck. Machine suspends ok, but upon waking up, the power led goes
> >   greek ok, the disk led lights up, but the keyboard is dead, the
> >   network card is dead, the screen doesn't turn on...
> > 
> >   Since this laptop has no serial port I don't see what else I can do,
> >   except wait another 6 months and try again... :(
> 
> Debug using pc speaker... Or paralel port, or something like that.

This is a laptop which has no serial or parallel port.

All the interfaces it has are all too high level to be used for
debugging (USB, firewire, pcmcia etc).

I think the speaker would probably work. I'll give it a try and
see if it helps next time...

Stelian.
-- 
Stelian Pop <stelian@popies.net>
