Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbSLLTNW>; Thu, 12 Dec 2002 14:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbSLLTNW>; Thu, 12 Dec 2002 14:13:22 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:20101 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265008AbSLLTNV>;
	Thu, 12 Dec 2002 14:13:21 -0500
Date: Thu, 12 Dec 2002 19:20:59 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: BoehmeSilvio <Boehme.Silvio@afb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-ac1 KT400 AGP support
Message-ID: <20021212192059.GC6039@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	BoehmeSilvio <Boehme.Silvio@afb.de>, linux-kernel@vger.kernel.org
References: <2F4E8F809920D611B0B300508BDE95FE29444E@AFB91>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2F4E8F809920D611B0B300508BDE95FE29444E@AFB91>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 07:04:02PM +0100, BoehmeSilvio wrote:
 > Hi !
 > 
 > Hopefully I'm right here.....
 > 
 > I have some trouble to get agpgart working in kernel 2.4.20-ac1.
 > 
 > My setup:
 > - ASUS A7V8X with VIA KT400 Chip (AGP 8X)
 > - ATI Radeon 9700 PRO (also AGP 8X)
 > 
 > The original 2.4.20 kernel doesn't know this chipset, so I tried the
 > 2.4.20-ac1, which has some patches for the KT400.
 > 
 > With 2.4.20-ac1 I get the following error:
 > 
 > agpgart: Maximum main memory to use for agp memory: 690M
 > agpgart: Detected Via Apollo KT-400 chipset
 > agpgart: unable to determine aperture size

Currently AGPGART doesn't support AGP 3.0 (which is needed for X8 mode)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
