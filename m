Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVFFTcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVFFTcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 15:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVFFTax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:30:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62144 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261647AbVFFT1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:27:09 -0400
Date: Mon, 6 Jun 2005 21:26:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
Message-ID: <20050606192654.GA3155@elf.ucw.cz>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It's being uploaded right now, the git tree is already up-to-date, and by 
> the time this hits the mailing list the mirroring of the tar-ball will 
> hopefully be done too.
> 
> And since Jeff wrote me a shortlog script for git, the easist way to tell
> what's new since -rc5 is to just do the shortlog and diffstat output. 
> Network drivers, USB and CPU-freq stand out.
> 
> And the good news is that people do seem to have taken my rumblings about 
> calming down for 2.6.12 seriously. Let's hope that pans out, and I can 
> release that one asap.. But give this a good beating first, and holler 
> (again, if you must) about any issues you have,


> Pavel Machek:
>   fix jumpy mouse cursor on console

This one was from Dmitry, and git logs know that:

author Pavel Machek <pavel@suse.cz> Fri, 27 May 2005 12:53:03 -0700
committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat, 28 May 2005 11:14:01 -0700

    [PATCH] fix jumpy mouse cursor on console

    Do not send empty events to gpm.  (Keyboards are assumed to have scroll
    wheel these days, that makes them part-mouse.  That means typing on
    keyboard generates empty mouse events).

    From: Dmitry Torokhov <dtor_core@ameritech.net>
    Signed-off-by: Pavel Machek <pavel@suse.cz>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

...perhaps shortlog script needs some updating?
									Pavel
