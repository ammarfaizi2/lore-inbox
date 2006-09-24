Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbWIXUUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWIXUUj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 16:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbWIXUUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 16:20:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28588 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751528AbWIXUUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 16:20:38 -0400
Date: Sun, 24 Sep 2006 22:20:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Theodoros V. Kalamatianos" <thkala@softlab.ece.ntua.gr>
Cc: kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] usb still sucks battery in -rc7-mm1
Message-ID: <20060924202025.GE1873@elf.ucw.cz>
References: <20060924090858.GA1852@elf.ucw.cz> <Pine.LNX.4.64.0609241457250.17306@rhama.deepcore.ngn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609241457250.17306@rhama.deepcore.ngn>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I made some quick experiments, and usb still eats 4W of battery
> >power. (With whole machine eating 9W, that's kind of a big deal)...
> >
> >This particular machine has usb bluetooth, but it can be disabled by
> >firmware, and appears unplugged. (I did that). It also has fingerprint
> >scanner, that can't be disabled, but that does not have driver (only
> >driven by useland, and was unused in this experiment).
> >
> >Any ideas?
> 
> (I have not followed the thread, so bear with me if I say anything 
> irrelavant)
> 
> I have encountered at least 3 hubs (2 usb2 & 1 usb1) that will consume a 
> lot of power (about 2-2.5W if the laptop power consumption readings are to 
> be trusted) and heat up a lot (to the point of being too hot to touch for 
> more than a few seconds) even when no devices are connected, at least on 
> Linux. I have not tested them on a Windows machine to see if this is the 
> case there. The USB2 ones used Cypress chips. I do not know what your h/w 
> config is, but perhaps this is a similar case ?

> PS: Note that the 2-2.5W consumption is the maximum that the laptop USB 
> port can provide, and I have noticed that with the hub's external power 
> supply connected it heats up even more.

I'm not using any external hubs. I believe it is old "uhci keeps cpu
from reaching deep c states" problem. I just want to ping greg/list,
because greg told me problem is solved in -mm.
								Pavel 
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
