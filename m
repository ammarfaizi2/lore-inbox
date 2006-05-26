Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWE0QYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWE0QYl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 12:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWE0QYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 12:24:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40199 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964870AbWE0QYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 12:24:40 -0400
Date: Fri, 26 May 2006 17:39:13 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Dave Airlie <airlied@gmail.com>
Cc: "D. Hazelton" <dhazelton@enter.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060526173913.GA3357@ucw.cz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <1148379089.25255.9.camel@localhost.localdomain> <200605232338.54177.dhazelton@enter.net> <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I am currently looking for some information or help in 
> >making the Framebuffer
> >devices use DRM and setting up a userspace system that 
> >interfaces with the
> >DRM backed framebuffer device to provide full 2D and 3D 
> >acceleration of all
> >supported features and *userspace* emulation of the 
> >unsupported stuff.
> 
> The first step is to provide some sort of communication 
> between the
> DRM and fb drivers so they know the other one exists,
> 
> previous attempts at this by myself have come apart in 
> the device
> model which just plainly cannot support this without 
> adding a couple
> of dirty hacks,

Could fb and drm simply be 'merged' into one driver (at least as far
as rest of system is concerned)? That should have no driver model
issues...?
							Pavel
-- 
Thanks for all the (sleeping) penguins.
