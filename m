Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWFMWTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWFMWTB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFMWTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:19:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23447 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932270AbWFMWTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:19:00 -0400
Date: Wed, 14 Jun 2006 00:18:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Oliver Bock <o.bock@fh-wolfenbuettel.de>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] usb: new driver for Cypress CY7C63xxx mirco controllers
Message-ID: <20060613221812.GJ27312@elf.ucw.cz>
References: <200606100042.19441.o.bock@fh-wolfenbuettel.de> <200606121934.05619.o.bock@fh-wolfenbuettel.de> <20060613192304.GG27312@elf.ucw.cz> <200606132330.24677.o.bock@fh-wolfenbuettel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200606132330.24677.o.bock@fh-wolfenbuettel.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 13-06-06 23:30:24, Oliver Bock wrote:
> Hi Pavel,
> 
> > > Hm, the chipset family is just called like that and there're at least
> > > three other Cypress related drivers (cypress, cypress_m8 and cytherm)
> > > with generic names. I think this name shows clearly what kind of device
> > > it supports, doesn't it?
> >
> > cypress_63 might be unique and still easier to pronounce?
> 
> Hm, what about something related to the vendor "AK Modul-Bus Computer GmbH"?
> I think my driver might (!) only work for their firmware implementations...
> 
> cypress_akmb
> cypress_akmodbus
> cypress_akmodulbus
> 
> The third would be my favourite. Are there any length restrictions for 
> driver/files names? Is it a problem to use parts of company names
> for this

No length limit; cypress_akmodulbus is quite long, but probably okay.

> > (You have it at few more places).
> 
> I changed it. I had the rule "only tabs for indentation" on my mind and tried 
> to choose the closest ;-) Now I first use tabs followed by spaces for 
> fine-tuning (if needed).
> 
> What about the macro discussion?
> If there's any convention I'm happy to follow it...

I'd prefer to do it using functions... it should be feasible. Only
repeated code will be function calls with different arguments.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
