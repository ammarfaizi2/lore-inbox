Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSKXPsd>; Sun, 24 Nov 2002 10:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSKXPsd>; Sun, 24 Nov 2002 10:48:33 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:30080 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S261411AbSKXPsc>;
	Sun, 24 Nov 2002 10:48:32 -0500
Subject: Re: Unsupported AGP-bridge on VIA VT8633
From: Stian Jordet <liste@jordet.nu>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021121231432.GA28783@suse.de>
References: <1037916067.813.7.camel@chevrolet.hybel>
	 <20021121221134.GA25741@suse.de>
	 <1037917231.3ddd5c2f5d98a@webmail.jordet.nu>
	 <20021121224035.GA28094@suse.de> <1037919383.856.3.camel@chevrolet.hybel>
	 <20021121231432.GA28783@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1038153359.998.56.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 24 Nov 2002 16:55:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre, 2002-11-22 kl. 00:14 skrev Dave Jones:
> On Thu, Nov 21, 2002 at 11:56:23PM +0100, Stian Jordet wrote:
>  > >  > I'll do that now. But why do I have to use agp_try_unsupported=1?
>  > > Because if it works, we can then add it to the ID table.
>  > It works, i think. I get this message when I load it:
>  > Linux agpgart interface v0.99 (c) Jeff Hartmann
>  > agpgart: Maximum main memory to use for agp memory: 439M
>  > agpgart: Trying generic Via routines for device id: 3091
>  > agpgart: AGP aperture is 64M @ 0xf8000000
> 
> And it survives a 3d app / testgart run ?

Bah, I'm not sure anymore. I have two motherboards. Asus CUV-266DLS and
Rioworks SDVIA. Both are dual cpu P3 motherboards. The first has a Via
Apollo Pro 266 chipset, while the Rioworks has a Via Apollo Pro 133A. I
have two graphics-adapters. ATI Radeon All-in-Wonder, and one ATI Radeon
9700 Pro.

With the SDVIA board, I get dri to work with both vga-cards. (On the
Radeon 9700 using the ATI-binary drivers.)

On the Asus, I have to load agpgart with agp_try_unsupported=1. Then I
get the old Radeon AIW to work perfectly with dri, but with the 9700, my
box crashes hard everytime I try anything 3d related.

But this can probably be blamed on the ATI-binary drivers? I just wanted
to let you know.

Best regards,
Stian Jordet

