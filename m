Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUJ3WTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUJ3WTV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbUJ3WTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:19:21 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29958 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261358AbUJ3WTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:19:19 -0400
Date: Sun, 31 Oct 2004 00:18:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: Re: [2.6 patch] let FW_LOADER select HOTPLUG
Message-ID: <20041030221841.GG4374@stusta.de>
References: <20041030220309.GE4374@stusta.de> <20041030231156.E15392@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030231156.E15392@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 11:11:56PM +0100, Russell King wrote:
> On Sun, Oct 31, 2004 at 12:03:09AM +0200, Adrian Bunk wrote:
> > 
> > If it wasn't for external modules, FW_LOADER wasn't user-visible.
> > Let FW_LOADER select HOTPLUG To make the dependencies easier for users.
> 
> You know what I'm going to say about this patch, so I'll won't repeat,
> except to say it has to do with select on user visible symbols.

I can send a patch that changes all dependencies on HOTPLUG to selects.
Would thids be acceptable?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

