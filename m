Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWFMTX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWFMTX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 15:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWFMTX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 15:23:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43752 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751173AbWFMTX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 15:23:58 -0400
Date: Tue, 13 Jun 2006 21:23:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Oliver Bock <o.bock@fh-wolfenbuettel.de>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] usb: new driver for Cypress CY7C63xxx mirco controllers
Message-ID: <20060613192304.GG27312@elf.ucw.cz>
References: <200606100042.19441.o.bock@fh-wolfenbuettel.de> <20060609224957.GA15130@elf.ucw.cz> <200606121934.05619.o.bock@fh-wolfenbuettel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606121934.05619.o.bock@fh-wolfenbuettel.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > BTW could we get come better name for the driver? cy7c63 looks like
> > password of very paranoid sysadmin.
> 
> Hm, the chipset family is just called like that and there're at least three 
> other Cypress related drivers (cypress, cypress_m8 and cytherm) with generic 
> names. I think this name shows clearly what kind of device it supports, 
> doesn't it?

cypress_63 might be unique and still easier to pronounce?

> Apart from that there are again other drivers (ark3116.c, cp2101.c) which do 
> it the same way, and I assumed that this might be some sort of naming 
> convention...

Well, at least it is not ark2a116.c :-).

> > > +	/* let the user know what node this device is now attached to */
> > > +	dev_info(&interface->dev,
> > > +		"Cypress CY7C63xxx device now attached\n");
> >
> > In cases like this we aling " one character to the right.
> 
> You mean the whole string (line) one character to the right, correct?

Yes. It should be

foo(BAR,
    BAZ).

(You have it at few more places).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
