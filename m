Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVBAXdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVBAXdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVBAXc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:32:59 -0500
Received: from gprs214-253.eurotel.cz ([160.218.214.253]:51074 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262170AbVBAXcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:32:47 -0500
Date: Wed, 2 Feb 2005 00:29:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ide-dev 3/5] generic Power Management for IDE devices
Message-ID: <20050201232950.GB29350@elf.ucw.cz>
References: <Pine.GSO.4.58.0501220004050.23959@mion.elka.pw.edu.pl> <20050122184124.GL468@openzaurus.ucw.cz> <58cb370e05020115032fdb8b59@mail.gmail.com> <1107300288.1665.33.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107300288.1665.33.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Move PM code from ide-cd.c and ide-disk.c to IDE core so:
> > > > * PM is supported for other ATAPI devices (floppy, tape)
> > > > * PM is supported even if specific driver is not loaded
> > > 
> > > Why do you need to have state-machine? During suspend we are running
> > > single-threaded, it should be okay to just do the calls directly.
> > 
> > If we are running single-threaded I also see no reason for state-machine.
> > Ben?
> > 
> > Pavel, I assume that changes contained in the patch are OK with you?
> 
> We aren't always running single threaded. On PPC we are definitely
> not :)

Ok, Ben is right, I forgot about PPC.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
