Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263669AbVCEBU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263669AbVCEBU5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 20:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbVCEBUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 20:20:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1038 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263489AbVCEBMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:12:43 -0500
Date: Sat, 5 Mar 2005 02:12:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       adaplas@pol.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [2.6 patch] make savagefb one module
Message-ID: <20050305011241.GO3327@stusta.de>
References: <20050301024118.GF4021@stusta.de> <200503040350.51163.adaplas@hotpop.com> <20050303202039.GH4608@stusta.de> <200503040437.43495.adaplas@hotpop.com> <20050303230750.GT4608@stusta.de> <Pine.LNX.4.62.0503041017000.22831@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503041017000.22831@numbat.sonytel.be>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 10:17:17AM +0100, Geert Uytterhoeven wrote:
> On Fri, 4 Mar 2005, Adrian Bunk wrote:
> > This patch links all selected files under drivers/video/savagefb/ into 
> > one module.
> > 
> > This required a renaming of savagefb.c to savagefb_driver.c .
> > 
> > As a side effect, the EXPORT_SYMBOL's in this directory are no longer 
> > required.
> > 
> > ---
> > 
> > Other names than savagefb_driver.c (e.g. savagefb_main.c) are easily 
> > possible - I do not claim being good at picking names...
> 
> savagefb_core.c?

Antonino, what's your opinion?

> Gr{oetje,eeting}s,
> 
> 						Geert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

