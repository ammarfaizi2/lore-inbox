Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVKZVI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVKZVI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 16:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVKZVI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 16:08:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33975 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750750AbVKZVI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 16:08:56 -0500
Date: Sat, 26 Nov 2005 22:08:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mark Underwood <basicmark@yahoo.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, David Vrabel <dvrabel@cantab.net>,
       lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       dkrivoschokov@dev.rtsoft.ru
Subject: Re: pxa27x_udc -- support for usb gadget for pxa27x?
Message-ID: <20051126210840.GE17663@elf.ucw.cz>
References: <20051126192436.GC17663@elf.ucw.cz> <20051126210437.76662.qmail@web36914.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051126210437.76662.qmail@web36914.mail.mud.yahoo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Ultimately, it would be nice to have the Zaurus detect whether a usb
> > > host or client was present (using gpio 41 maybe?) and then activate the
> > > host (ohci) or client (pxa27x_udc) driver as appropriate.
> > 
> > Unfortunately, that would make ohci unfunctional for me. I have normal
> > usb device cable, connected to "USB gender changer" -- basically two
> > female connectors -- so that I can plug USB network card into that.
> > 
> 
> Just a thought. How about a sysfs entry which you can use to jam the device into either slave or
> host mode?

Yes, that would do the trick. Auto sense is probably good solution,
too, it is just that it should have /sys override or something like
that.

							Pavel
-- 
Thanks, Sharp!
