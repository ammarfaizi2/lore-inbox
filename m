Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbTKWSz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 13:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTKWSz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 13:55:59 -0500
Received: from mta9.adelphia.net ([68.168.78.199]:45254 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S263400AbTKWSz5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 13:55:57 -0500
Subject: Re: DRI and AGP on 2.6.0-test9
From: Aubin LaBrosse <arl8778@rit.edu>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0311231313110.2498@montezuma.fsmlabs.com>
References: <1069571959.9574.46.camel@rain.rh.rit.edu>
	 <Pine.LNX.4.53.0311231313110.2498@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1069613755.9574.68.camel@rain.rh.rit.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 23 Nov 2003 13:55:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-11-23 at 13:15, Zwane Mwaikambo wrote:
> On Sun, 23 Nov 2003, Aubin LaBrosse wrote:
> 
> > Hi all, 
> > 
> > I'm having a problem with 2.6.0-test9 and DRI.  dmesg tells me:
> > 
> > [drm] Initialized radeon 1.9.0 20020828 on minor 0
> > [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> > [drm:radeon_unlock] *ERROR* Process 4113 using kernel context 0
> 
> For my curiosity, can you try compiling the Radeom/drm and AGP driver into 
> the kernel?

I have done it both ways with the same results, sorry, should have
mentioned that... 
> 
> > anyway, some more information:
> > 
> > this is a 2-cpu machine, AMD MP2000+'s on a Tyan Tiger MPX board
> > (AMD-760MPX chipset ) 4xAGP, Radeon AIW (the original one, so i suspect
> > 7200. certainly r200, which afaik requires no proprietary drivers at all
> > for dri to work. Perhaps it is an smp issue?  anyway, here's my kernel
> > config:
> 
> I just tried test9-mm5 with a radeon 9000 on an smp machine with the 
> desired results.

I will give -mm5 a shot (this was with stock 2.6.0-test9, i haven't
gotten into applying the -bk patches as soon as they hit, yet) Though
I'm not sure -mm5 has any patches specific to DRI or agp, but it's
definitely worth a shot.  thanks Zwane.

-Aubin


