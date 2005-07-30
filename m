Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbVG3Ugg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbVG3Ugg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbVG3Ud4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:33:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45725 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263173AbVG3UcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:32:03 -0400
Date: Sat, 30 Jul 2005 22:31:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Brian Schau <brian@schau.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wireless Security Lock driver.
Message-ID: <20050730203159.GB9418@elf.ucw.cz>
References: <42EB940E.5000008@schau.com> <20050730194215.GA9188@elf.ucw.cz> <42EBDEA9.60505@schau.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EBDEA9.60505@schau.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hehe - the WSLs are already reality.  Sitecom is a producer of
> these and you can get another brand from ThinkGeek.

Aha, ok.

> Sitecom device:
> http://www.sitecom.com/products_info.php?product_id=293&grp_id=1
> 
> ThinkGeek:
> http://www.thinkgeek.com/gadgets/security/698d/
> 
> Why in kernel?   Well, the device is based on the Cypress Ultra
> Mouse.  So with a non WSL aware kernel the events from the WSL
> will be merged into the standard mouse input queue which will
> make your mouse pointer move uncontrollable - it'll jump across
> the screen in a couple of steps every 3 seconds or so.
> Quite amusing but not very handy!

Well, that is if you use /dev/psaux, right? Using event devices you
should be able to access it from userland. Or you could drive it using
libusb driver.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
