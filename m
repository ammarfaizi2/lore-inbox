Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWFAJna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWFAJna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWFAJna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:43:30 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:48535 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932184AbWFAJn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:43:29 -0400
Date: Thu, 1 Jun 2006 11:43:15 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "D. Hazelton" <dhazelton@enter.net>
cc: Dave Airlie <airlied@gmail.com>, Jon Smirl <jonsmirl@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <200605312115.44907.dhazelton@enter.net>
Message-ID: <Pine.LNX.4.61.0606011140110.3533@yvahk01.tjqt.qr>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
 <200605282316.50916.dhazelton@enter.net> <Pine.LNX.4.61.0605312341240.30170@yvahk01.tjqt.qr>
 <200605312115.44907.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> As long as I can continue to use 80x25 or any of the "pure text modes"
>> (vga=scan boot option says more) without loading any FB/DRM, I am satisfied
>
>Jan, I don't plan on forcing fbdev/DRM on anyone. My work is going to leave 
>vgacon alone, and if my work at making DRM and FBdev cooperate goes as 
>planned, those two will remain independant, though part of my work aims at 
>having fbdev provide all 2D graphics acceleration for DRM while DRM handles 
>the 3D stuff via the Mesa libraries or similar.
>
That sounds acceptable.

But current vesafb is slower, noticable with scrolling as in `ls -Rl /`.
Does it lack 2D acceleration?


Jan Engelhardt
-- 
