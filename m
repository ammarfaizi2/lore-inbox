Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbUJaTpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbUJaTpg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 14:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbUJaTpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 14:45:33 -0500
Received: from gprs214-91.eurotel.cz ([160.218.214.91]:63876 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261433AbUJaTpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 14:45:14 -0500
Date: Sun, 31 Oct 2004 20:44:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, akpm@osdl.org
Subject: Re: [PATCH] Configurable Magic Sysrq
Message-ID: <20041031194457.GE1430@elf.ucw.cz>
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz> <20041031185222.GB5578@elf.ucw.cz> <200410311409.16400.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410311409.16400.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >   I know about a few people who would like to use some functionality of
> > > the Magic Sysrq but don't want to enable all the functions it provides.
> > > So I wrote a patch which should allow them to do so. It allows to
> > > configure available functions of Sysrq via /proc/sys/kernel/sysrq (the
> > > interface is backward compatible). If you think it's useful then use it :)
> > > Andrew, do you think it can go into mainline or it's just an overdesign?
> > 
> > Actually, there's one more thing that wories me... Original choice of
> > PC hotkey (alt-sysrq-key) works *very* badly on many laptop
> > keyboards. Like sysrq is only recognized with fn, but key is not
> > recognized when you hold fn => you have no chance to use magic sysrq.
> > 
> 
> Actually if I understand it correctly it is Alt-PrtScrn-key - just let go
> of your "Fn" key and I think it will work fine. At least it does on my
> laptop.

Okay, it looks like I can actually type it on all notebooks here if I
try hard enough. On HP machines, the trick is
alt,fn,sysrq,releasealtandfn,key. Ouch.

The thing that confused me was some SuSE script redirecting messages
to other tty, so I saw nothing after magic-9, and assumed I did not
press it correctly.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
