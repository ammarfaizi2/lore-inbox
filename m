Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWE2VrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWE2VrD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWE2Vqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:46:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36266 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751325AbWE2Vq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:46:29 -0400
Date: Mon, 29 May 2006 23:45:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jeff@garzik.org>
Cc: Dave Airlie <airlied@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Jon Smirl <jonsmirl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060529214540.GB7537@elf.ucw.cz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <20060529102339.GA746@elf.ucw.cz> <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com> <20060529124840.GD746@elf.ucw.cz> <447B666F.5080109@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447B666F.5080109@garzik.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 29-05-06 17:23:59, Jeff Garzik wrote:
> Pavel Machek wrote:
> >These are very reasonable rules... but still, I think we need to move
> >away from vgacon/vesafb. We need proper hardware drivers for our
> >hardware.
> 
> I agree we need proper drivers, but moving away from vesafb will be 
> tough... moving away from vgacon is likely impossible for many many 
> years yet.
> 
> Once proper hardware drivers exist, you will still need to support 
> booting into a situation where you probably need video before a driver 
> can be loaded -- e.g. distro installers.  Server owners will likely 
> prefer vgacon over a huge video driver they will never use for anything 
> but text mode console.

Well, I agree that vesafb and vgacon need to exist and are useful for
installation/servers/etc. I was arguing that some combinations are
bad.

Like vgacon + X + 3D acceleration.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
