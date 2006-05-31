Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbWFABPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbWFABPy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 21:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWFABPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 21:15:53 -0400
Received: from smtp.enter.net ([216.193.128.24]:6158 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S965132AbWFABPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 21:15:53 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: OpenGL-based framebuffer concepts
Date: Wed, 31 May 2006 21:15:44 +0000
User-Agent: KMail/1.8.1
Cc: Dave Airlie <airlied@gmail.com>, Jon Smirl <jonsmirl@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605282316.50916.dhazelton@enter.net> <Pine.LNX.4.61.0605312341240.30170@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605312341240.30170@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605312115.44907.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 May 2006 21:42, Jan Engelhardt wrote:
> >> c) Lots of distros don't use fbdev drivers, forcing this on them to
> >> use drm isn't an option.
> >
> >what distro's? The only ones that don't are either the ones that hold the
> >users hand or the ones where the user is meant to be able to quickly
> > change and modify the system.
>
> As long as I can continue to use 80x25 or any of the "pure text modes"
> (vga=scan boot option says more) without loading any FB/DRM, I am satisfied
> :)
>
>
>
> Jan Engelhardt

Jan, I don't plan on forcing fbdev/DRM on anyone. My work is going to leave 
vgacon alone, and if my work at making DRM and FBdev cooperate goes as 
planned, those two will remain independant, though part of my work aims at 
having fbdev provide all 2D graphics acceleration for DRM while DRM handles 
the 3D stuff via the Mesa libraries or similar.

DRH
