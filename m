Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbTKWWhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 17:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbTKWWhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 17:37:15 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:57986
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263513AbTKWWhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 17:37:11 -0500
Date: Sun, 23 Nov 2003 17:35:52 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Aubin LaBrosse <arl8778@rit.edu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: DRI and AGP on 2.6.0-test9
In-Reply-To: <1069613755.9574.68.camel@rain.rh.rit.edu>
Message-ID: <Pine.LNX.4.53.0311231732300.2498@montezuma.fsmlabs.com>
References: <1069571959.9574.46.camel@rain.rh.rit.edu> 
 <Pine.LNX.4.53.0311231313110.2498@montezuma.fsmlabs.com>
 <1069613755.9574.68.camel@rain.rh.rit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Nov 2003, Aubin LaBrosse wrote:

> > > [drm] Initialized radeon 1.9.0 20020828 on minor 0
> > > [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> > > [drm:radeon_unlock] *ERROR* Process 4113 using kernel context 0
> > 
> > For my curiosity, can you try compiling the Radeom/drm and AGP driver into 
> > the kernel?
> 
> I have done it both ways with the same results, sorry, should have
> mentioned that... 

Ok let me double check things here, my radeon 9000 is also R200 so we 
should be hitting the same code paths.

> > I just tried test9-mm5 with a radeon 9000 on an smp machine with the 
> > desired results.
> 
> I will give -mm5 a shot (this was with stock 2.6.0-test9, i haven't
> gotten into applying the -bk patches as soon as they hit, yet) Though
> I'm not sure -mm5 has any patches specific to DRI or agp, but it's
> definitely worth a shot.  thanks Zwane.

As far as i know it shouldn't make any difference, but being on the same 
tree doesn't hurt for now.

Good luck,
	Zwane

