Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWBRXsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWBRXsR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 18:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWBRXsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 18:48:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21123 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932343AbWBRXsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 18:48:17 -0500
Date: Sun, 19 Feb 2006 00:48:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: ghrt <ghrt@dial.kappa.ro>
Cc: kernel list <linux-kernel@vger.kernel.org>, perex@suse.cz, tiwai@suse.de
Subject: Re: No sound from SB live!
Message-ID: <20060218234805.GA3235@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz> <200602190127.27862.ghrt@dial.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602190127.27862.ghrt@dial.kappa.ro>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > root@hobit:~# uname -a
> > Linux hobit 2.6.16-rc4 #1 SMP PREEMPT Sat Feb 18 23:53:41 CET 2006
> > i686 GNU/Linux
> >
> Same problem here some time ago. See below forwarded message.

Thanks.

> > First check /proc/asound/cards to see whether the emu10k1 model is
> > detected properly.  If '[Unknown]' is shown, your model is not
> > listed in the whitelist.
> 
> Seems ok (see below). But i came to the conclusion that it might be
> KMix as well, because alsa-mixer (console) works fine.
> Maybe if the name of the output (or input) device (now both are
> "Wave") is changed to be different from the other names the problem
> will dissapear. I didn't have time to do this (i am not a programmer
> also).

I tried enabled everything I could in alsamixer, but still could not
get it to produce some sound :-(.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
