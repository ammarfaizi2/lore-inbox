Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbSKUXJW>; Thu, 21 Nov 2002 18:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbSKUXJW>; Thu, 21 Nov 2002 18:09:22 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:46231 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265385AbSKUXJW>;
	Thu, 21 Nov 2002 18:09:22 -0500
Date: Thu, 21 Nov 2002 23:14:32 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unsupported AGP-bridge on VIA VT8633
Message-ID: <20021121231432.GA28783@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Stian Jordet <liste@jordet.nu>, linux-kernel@vger.kernel.org
References: <1037916067.813.7.camel@chevrolet.hybel> <20021121221134.GA25741@suse.de> <1037917231.3ddd5c2f5d98a@webmail.jordet.nu> <20021121224035.GA28094@suse.de> <1037919383.856.3.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037919383.856.3.camel@chevrolet.hybel>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 11:56:23PM +0100, Stian Jordet wrote:
 > >  > I'll do that now. But why do I have to use agp_try_unsupported=1?
 > > Because if it works, we can then add it to the ID table.
 > It works, i think. I get this message when I load it:
 > Linux agpgart interface v0.99 (c) Jeff Hartmann
 > agpgart: Maximum main memory to use for agp memory: 439M
 > agpgart: Trying generic Via routines for device id: 3091
 > agpgart: AGP aperture is 64M @ 0xf8000000

And it survives a 3d app / testgart run ?
 
 > Thank you very much. I'm very sorry if this was a lame question.

No problem. I'll add this ID to the pending patch I have
for Linus to add various other GARTs.

		Dave
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
