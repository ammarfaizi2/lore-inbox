Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVBAX3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVBAX3N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVBAX3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:29:12 -0500
Received: from gprs214-253.eurotel.cz ([160.218.214.253]:40834 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262176AbVBAX27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:28:59 -0500
Date: Wed, 2 Feb 2005 00:24:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [ide-dev 3/5] generic Power Management for IDE devices
Message-ID: <20050201232429.GF1790@elf.ucw.cz>
References: <Pine.GSO.4.58.0501220004050.23959@mion.elka.pw.edu.pl> <20050122184124.GL468@openzaurus.ucw.cz> <58cb370e05020115032fdb8b59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e05020115032fdb8b59@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Move PM code from ide-cd.c and ide-disk.c to IDE core so:
> > > * PM is supported for other ATAPI devices (floppy, tape)
> > > * PM is supported even if specific driver is not loaded
> > 
> > Why do you need to have state-machine? During suspend we are running
> > single-threaded, it should be okay to just do the calls directly.
> >                                 Pavel
> 
> If we are running single-threaded I also see no reason for state-machine.
> Ben?
> 
> Pavel, I assume that changes contained in the patch are OK with you?

I do not think I looked too closely but yes, they are probably ok.

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
