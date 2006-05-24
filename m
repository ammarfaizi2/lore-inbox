Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWEXPmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWEXPmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 11:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWEXPmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 11:42:04 -0400
Received: from witte.sonytel.be ([80.88.33.193]:46028 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932340AbWEXPmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 11:42:03 -0400
Date: Wed, 24 May 2006 17:41:48 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: Kyle Moffett <mrmacman_g4@mac.com>, Jon Smirl <jonsmirl@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <44740533.7040702@aitel.hist.no>
Message-ID: <Pine.LNX.4.62.0605241741190.4644@pademelon.sonytel.be>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
 <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
 <200605230048.14708.dhazelton@enter.net> <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>
 <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com> <44740533.7040702@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2006, Helge Hafting wrote:
> Kyle Moffett wrote:
> > The one really significant potential problem with the exo-kernel model for
> > graphics is that the kernel *must* have a stable way to display kernel
> > panics regardless of current video mode, framebuffer settings, 3D rendering,
> > etc.  The kernel driver should be able to provide some fundamental
> > operations for compositing text on top of the framebuffer at the primary
> > viewport regardless of whatever changes userspace makes to the GPU
> > configuration.  We don't have this now, but I see it as an absolute
> > requirement for any replacement graphics system.  This means that the kernel
> > driver should be able to understand and modify the entire GPU state to the
> > extent necessary for such a text console.
> I am not so sure I want this at all.
> In the early 90's, I used unix machines wich did exactly this - spamming the
> framebuffer console with occational messages while X was running.
> Yuck yuck yuck yuck yuck .  .  .

And the funny thing is that Linux used to do this as well ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
