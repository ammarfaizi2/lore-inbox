Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWJESOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWJESOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWJESOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:14:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64672 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750732AbWJESOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:14:35 -0400
Date: Thu, 5 Oct 2006 20:14:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Duncan Sands <baldrick@free.fr>, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, ueagle <ueagleatm-dev@gna.org>,
       matthieu castet <castet.matthieu@free.fr>
Subject: Re: [linux-usb-devel] [PATCH 1/3] UEAGLE : be suspend friendly
Message-ID: <20061005181426.GA27838@elf.ucw.cz>
References: <200610050917.36442.baldrick@free.fr> <Pine.LNX.4.44L0.0610051221520.6596-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610051221520.6596-100000@iolanthe.rowland.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Plug/unplug should be easy enough to simulate from usb driver, no?
> > 
> > if a USB driver doesn't define suspend/resume methods, then the core simply
> > unplugs it on suspend, and replugs on resume (IIRC).
> 
> No longer true, and IIRC it never was.  All that happens is that URB 
> submissions fail with -EHOSTUNREACH once the device is suspended.

Could we get "old" behaviour for devices like this? "printk("please
unplug/replug me\n")" is not a good solution.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
