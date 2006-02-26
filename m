Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWBZSNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWBZSNk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 13:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWBZSNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 13:13:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18191 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751028AbWBZSNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 13:13:39 -0500
Date: Sun, 26 Feb 2006 19:13:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Samuel Masham <samuel.masham@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] make INPUT a bool
Message-ID: <20060226181338.GL3674@stusta.de>
References: <20060220132832.GF4971@stusta.de> <Pine.LNX.4.61.0602252300200.7535@yvahk01.tjqt.qr> <20060225220737.GE3674@stusta.de> <200602251723.53349.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602251723.53349.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 05:23:52PM -0500, Dmitry Torokhov wrote:
> 
> Adrian,
> 
> There are requests to move it out of EMBEDDED because sometimes you
> just  don't need input layer at all. Dave Jones mentioned that he
> feels silly enabling EMBEDDED on iSeries... I am thinking about
> changing it to "EMBEDDED || !X86_PC" to safe-guard the most common
> platform from accidenially disabling it.

Sounds reasonable.

> I am still not convinced whether INPUT=m makes sence, especially if
> we make ACPI use input layer... Jan's example about input device with
> hot-pluggable keyboard is a bit of a stretch. 

Agreed.

> Dmitry

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

