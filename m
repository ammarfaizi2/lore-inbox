Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVAKBDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVAKBDX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVAKBAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:00:31 -0500
Received: from waste.org ([216.27.176.166]:43492 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262562AbVAKAzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:55:06 -0500
Date: Mon, 10 Jan 2005 16:54:39 -0800
From: Matt Mackall <mpm@selenic.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       John Richard Moser <nigelenki@comcast.net>, znmeb@cesmail.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: starting with 2.7
Message-ID: <20050111005439.GI2995@waste.org>
References: <1105045853.17176.273.camel@localhost.localdomain> <1105115671.12371.38.camel@DreamGate> <41DEC5F1.9070205@comcast.net> <1105237910.11255.92.camel@DreamGate> <41E0A032.5050106@comcast.net> <1105278618.12054.37.camel@localhost.localdomain> <41E1CCB7.4030302@comcast.net> <21d7e99705010917281c6634b8@mail.gmail.com> <1105361337.12054.66.camel@localhost.localdomain> <21d7e99705011014197b8a9767@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e99705011014197b8a9767@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 09:19:24AM +1100, Dave Airlie wrote:
> Say theoretically ATI decide tomorrow:
> 1. GPL in kernel source code (ATI is based on the DRM so it isn't such
> a leap of faith as say NVIDIA doing it...)
> 2. clean it all up so that it follows every single kernel coding
> practice to the letter
> 3. submit it for inclusion into the kernel as a device driver,
> drivers/char/drm/fglrx.c
> 
> Now would you include it? we can't use the no-one is using it excuse,
> as people are using fglrx already and many have no choice, the driver
> would have no userspace applications other than the binary only 2D/3D
> drivers they supply for X... ATI would then benefit from the kernel
> development process for keeping the things up-to-date with respect to
> interfaces etc...

I think so, yes. We'd be able to fix kernelspace bugs in it, for
starters.

> In this way, people who are running on ppc etc would still not have or
> be any closer to 3D acceleration for their graphics cards, but ATI
> would have followed the rules as far as the kernel is concerned....

They'd certainly be closer in that userspace code is significantly
easier to emulate and/or reverse engineer.

> The main reason 3D graphics drivers are the big one here as of course
> we can't put OpenGL into the kernel, so it requires a split
> kernel/userspace solution, and one is of little use without the other,
> if the kernel one is GPL and userspace one is closed source how do
> people sit with it? (uneasy?)

If the userspace portion is using a standard API and not just using
the driver to open gaping holes in the kernel/user barrier, I see it
as a step forward.

-- 
Mathematics is the supreme nostalgia of our time.
