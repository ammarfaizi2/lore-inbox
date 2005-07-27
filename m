Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVG0KIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVG0KIP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 06:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVG0KIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 06:08:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55194 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262147AbVG0KII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 06:08:08 -0400
Date: Wed, 27 Jul 2005 12:05:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu, linux-kernel@vger.kernel.org
Subject: Re: [patch] Support powering sharp zaurus sl-5500 LCD up and down
Message-ID: <20050727100553.GG4270@elf.ucw.cz>
References: <20050727092613.GA4713@elf.ucw.cz> <20050727023754.6846f3a2.akpm@osdl.org> <20050727095042.GD4270@elf.ucw.cz> <20050727030029.3bab4889.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727030029.3bab4889.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > +/*
> > > > + * Backlight control code for Sharp Zaurus SL-5500
> > > > + *
> > > > + * Copyright 2005 John Lenz <lenz@cs.wisc.edu>
> > > > + * GPL v2
> > > 
> > > Who is the maintainer for this stuff?
> > 
> > I guess I'll maintain in.
> > 
> > > > +static struct locomo_dev *locomolcd_dev = NULL;
> > > 
> > > bah.
> > 
> > Well, sa1100fb_lcd_power is not provide us with void * we could use,
> > and by definition you only have one frontlight in a PDA, so that
> > should be okay...
> 
> "bah" means "there's no need to initialise this to NULL".

Okay, that's kind of easier to fix ;-). Done here, it will eventually
propagate.
							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
