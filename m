Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbSKLRnp>; Tue, 12 Nov 2002 12:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266769AbSKLRne>; Tue, 12 Nov 2002 12:43:34 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:15625 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266760AbSKLRnL>; Tue, 12 Nov 2002 12:43:11 -0500
Date: Tue, 12 Nov 2002 17:49:56 +0000 (GMT)
From: James Simmons <jsimmons@phoenix.infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Priit Laes <amd@tt.ee>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.46 & 2.5.47: Errors in drivers/video/aty128fb.c
In-Reply-To: <1037094697.8907.245.camel@zion>
Message-ID: <Pine.LNX.4.44.0211121748560.14340-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > My configuration is following
> > # Frame-buffer support
> > CONFIG_FB=y
> > CONFIG_DUMMY_CONSOLE=y
> > CONFIG_FB_VESA=y
> > CONFIG_FB_ATY128=y
> > when i tried to compile CONFIG_FB_ATY128 as module it also failed with same errors...
> > PS. This also happened in 2.5.46, but i didn't bother to report :(
> 
> There are fixed versions of the aty128 and radeon fb drivers in
> the PPC tree. Paulus is now taking care of aty128fb and will probably
> send linus and updated version soon. I did a port of radeonfb but have
> been waiting for Ani Joshi, the driver's maintainer, to send it to
> Linus.

Ben do you mind if I grab your work and place it in my fbdev BK tree. The 
reason being is there are some more api changes (the last ones) to be 
pushed to linus. 

