Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbSKUWGf>; Thu, 21 Nov 2002 17:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264934AbSKUWGf>; Thu, 21 Nov 2002 17:06:35 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:63894 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264920AbSKUWGd>;
	Thu, 21 Nov 2002 17:06:33 -0500
Date: Thu, 21 Nov 2002 22:11:34 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unsupported AGP-bridge on VIA VT8633
Message-ID: <20021121221134.GA25741@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Stian Jordet <liste@jordet.nu>, linux-kernel@vger.kernel.org
References: <1037916067.813.7.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037916067.813.7.camel@chevrolet.hybel>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 11:01:07PM +0100, Stian Jordet wrote:
 > Based on agpgart interface v0.99 (c) Jeff Hartmann
 > agpgart: Maximum main memory to use for agp memory: 439M
 > agpgart: Unsupported Via chipset (device id: 3091), you might want to
 > try agp_try_unsupported=1.
 > agpgart: no supported devices found.
 > 
 > I have tried with agp_try_unsupported=1, but no luck.

You tried agp_try_unsupported=1 as a modprobe argument,
not as a boot time argument right ?
Quite a few people seem to fall into this trap.

When I get chance, I'll make that a boottime arg too.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
