Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSLCMRq>; Tue, 3 Dec 2002 07:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSLCMRq>; Tue, 3 Dec 2002 07:17:46 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:50356 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261645AbSLCMRp>;
	Tue, 3 Dec 2002 07:17:45 -0500
Date: Tue, 3 Dec 2002 12:22:38 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Ian Chilton <ian@ichilton.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 Compile Failure
Message-ID: <20021203122238.GD30431@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ian Chilton <ian@ichilton.co.uk>, linux-kernel@vger.kernel.org
References: <20021203120928.GC8351@buzz.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203120928.GC8351@buzz.ichilton.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 12:09:29PM +0000, Ian Chilton wrote:

 > If I remove this..:
 > --- DRM 4.1 drivers
 > <*>   SiS
 > ...it works fine.
 > drivers/char/drm/drm.o: In function `sis_fb_alloc':
 > drivers/char/drm/drm.o(.text+0x73d8): undefined reference to
 > `sis_malloc'
 > drivers/char/drm/drm.o(.text+0x7486): undefined reference to `sis_free'
 > drivers/char/drm/drm.o: In function `sis_fb_free':
 > drivers/char/drm/drm.o(.text+0x74f9): undefined reference to `sis_free'
 > drivers/char/drm/drm.o: In function `sis_final_context':
 > drivers/char/drm/drm.o(.text+0x791f): undefined reference to `sis_free'
 > make: *** [vmlinux] Error 1

compile in the sis frame buffer too. They need each other iirc.

		Dave
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
