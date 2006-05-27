Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWE0WBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWE0WBr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 18:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWE0WBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 18:01:47 -0400
Received: from smtp.enter.net ([216.193.128.24]:17931 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S964931AbWE0WBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 18:01:47 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: OpenGL-based framebuffer concepts
Date: Sat, 27 May 2006 18:01:36 +0000
User-Agent: KMail/1.8.1
Cc: Dave Airlie <airlied@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com> <20060526173913.GA3357@ucw.cz>
In-Reply-To: <20060526173913.GA3357@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605271801.36942.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 17:39, Pavel Machek wrote:
> Hi!
>
> > >I am currently looking for some information or help in
> > >making the Framebuffer
> > >devices use DRM and setting up a userspace system that
> > >interfaces with the
> > >DRM backed framebuffer device to provide full 2D and 3D
> > >acceleration of all
> > >supported features and *userspace* emulation of the
> > >unsupported stuff.
> >
> > The first step is to provide some sort of communication
> > between the
> > DRM and fb drivers so they know the other one exists,
> >
> > previous attempts at this by myself have come apart in
> > the device
> > model which just plainly cannot support this without
> > adding a couple
> > of dirty hacks,
>
> Could fb and drm simply be 'merged' into one driver (at least as far
> as rest of system is concerned)? That should have no driver model
> issues...?
> 							Pavel

And such was my original idea. However I've been informed that doing such 
would either constitute "Breaking working systems" or "introducing a third 
and unneeded driver".

For that reason I've begun doing a bit of research and planning... it might 
show fruit in a couple of days.

DRH
