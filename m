Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVBPByl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVBPByl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 20:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVBPByl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 20:54:41 -0500
Received: from gprs214-60.eurotel.cz ([160.218.214.60]:56203 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261968AbVBPBye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 20:54:34 -0500
Date: Wed, 16 Feb 2005 02:54:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alistair John Strachan <alistair@devzero.co.uk>
Cc: Lorenzo Colitti <lorenzo@colitti.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
Message-ID: <20050216015418.GC13753@elf.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz> <1108500194.12031.21.camel@elrond.flymine.org> <42126506.8020407@colitti.com> <200502160141.11633.alistair@devzero.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502160141.11633.alistair@devzero.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I would advise trying to compile a custom kernel from scratch with my
> > .config first.
> >
> > I got S3 working first with a very basic kernel config, but I couldn't
> > get it to work with my usual kernel. Assuming it was some feature that
> > caused the problem, I started disabling features in the hope of getting
> > it to work, but I ended up with two different kernels with seemingly
> > irrelevant differences, of which one would succesfully resume and one
> > wouldn't. So I started added features to the other kernel, and I never
> > found out what caused the problem.
> 
> I took your advice and built your kernel with a few modifications (XFS instead 
> of ext, etc.). If I boot the kernel with init=/bin/sh, I can actually 
> suspend! Thanks!
> 
> I will exhaustively enable and disable drivers tomorrow to figure out which 
> one is causing suspend to fail when I do a complete boot. Whatever we find is 
> clearly a bug that should be fixed.
> 
> It is not the framebuffer driver (I always ran without vesafb or radeonfb), 
> and it is not my ipw2200 or USB drivers.
> 
> Also, is USB suspend/resume supposed to work? My brief trials involved 
> modprobing the USB HCD modules, which still allowed me to suspend/resume, but 
> my USB mouse was non-functional on resume.

Yes, it seems to work quite okay. You may need to unplug/replug
devices after resume, but it should be basically ok.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
