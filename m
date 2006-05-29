Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWE2VY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWE2VY3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWE2VYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:24:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:51928 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751338AbWE2VYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:24:09 -0400
Message-ID: <447B666F.5080109@garzik.org>
Date: Mon, 29 May 2006 17:23:59 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Dave Airlie <airlied@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Jon Smirl <jonsmirl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <20060529102339.GA746@elf.ucw.cz> <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com> <20060529124840.GD746@elf.ucw.cz>
In-Reply-To: <20060529124840.GD746@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> These are very reasonable rules... but still, I think we need to move
> away from vgacon/vesafb. We need proper hardware drivers for our
> hardware.

I agree we need proper drivers, but moving away from vesafb will be 
tough... moving away from vgacon is likely impossible for many many 
years yet.

Once proper hardware drivers exist, you will still need to support 
booting into a situation where you probably need video before a driver 
can be loaded -- e.g. distro installers.  Server owners will likely 
prefer vgacon over a huge video driver they will never use for anything 
but text mode console.

	Jeff


