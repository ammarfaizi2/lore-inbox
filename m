Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTJaC6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 21:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbTJaC6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 21:58:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13284 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262792AbTJaC6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 21:58:52 -0500
Date: Fri, 31 Oct 2003 03:58:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Announce: Swsusp-2.0-2.6-alpha1 [warning: eats disks with loop!]
Message-ID: <20031031025849.GA21818@atrey.karlin.mff.cuni.cz>
References: <1067064107.1974.44.camel@laptop-linux> <20031025204940.GB276@elf.ucw.cz> <1067153848.13594.49.camel@laptop-linux> <20031026092551.GB293@elf.ucw.cz> <1067163344.13594.170.camel@laptop-linux> <20031030080430.GB198@elf.ucw.cz> <1067542303.4041.9.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067542303.4041.9.camel@laptop-linux>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi!


> > 
> > > First thing I would suggest would be bumping up the printk buffer size.
> > > I use 1 meg. Then you'll get the full set of messages.
> > 
> > Here it is:
> > 
> > [I guess I should try again without USB and without pccard?]
> 
> Yes, I know I have to do work on pccard yet. I haven't tried pcmcia on
> the 2.6 kernel yet. Will do so today. USB... are they making progress
> implementing the driver model for it?


I made it to "work", unfortunately.

It seemed to suspend / resume okay, altrough suspend took *way* too
long (like 1 minute without any apparent disk activity).

Unfortunately now my "main" filesystem (mounted via loop), is
*gode*. Damaged beyond repair, I never managed to trash a filesystem
this badly....

Tommorow I'll try to restore  from backup and run fsck from alternate
superblock; cross your fingers for me.

						Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
