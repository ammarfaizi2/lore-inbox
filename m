Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVBGQEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVBGQEu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVBGQEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:04:49 -0500
Received: from gprs215-44.eurotel.cz ([160.218.215.44]:48614 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261169AbVBGQEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:04:48 -0500
Date: Mon, 7 Feb 2005 17:01:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Paulo Marques <pmarques@grupopie.com>, Adam Sulmicki <adam@cfar.umd.edu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Li-Ta Lo <ollie@lanl.gov>
Subject: Re: [RFC] Reliable video POSTing on resume
Message-ID: <20050207160105.GF8040@elf.ucw.cz>
References: <4202DF7B.2000506@gmx.net> <1107485504.5727.35.camel@desktop.cunninghams> <9e4733910502032318460f2c0c@mail.gmail.com> <20050204074454.GB1086@elf.ucw.cz> <9e473391050204093837bc50d3@mail.gmail.com> <20050205093550.GC1158@elf.ucw.cz> <1107695583.14847.167.camel@localhost.localdomain> <Pine.BSF.4.62.0502062107000.26868@www.missl.cs.umd.edu> <42077AC4.5030103@grupopie.com> <42077CFD.7030607@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42077CFD.7030607@gmx.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 3 - it's always there and can be executed at *any* time: booting,
> > returning from suspend, etc. Also it would allow the VESA framebuffer
> > driver to change graphics mode at any time (for instance).
> 
> OK, and what would force you to do the above in the kernel? If the code
> lives in initramfs, it can be called very early, too.

It will be easier to debug in kernel than in initramfs, for
one. Kernel code is bad enough, but initramfs running while kernel is
not even initialized is going to be even more "fun".
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
