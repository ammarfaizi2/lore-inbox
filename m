Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932734AbVKDM5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbVKDM5s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 07:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbVKDM5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 07:57:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11019 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932734AbVKDM5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 07:57:46 -0500
Date: Fri, 4 Nov 2005 13:57:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-joystick@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] drivers/input/: possible cleanups
Message-ID: <20051104125742.GE5587@stusta.de>
References: <20051104123541.GC5587@stusta.de> <20051104124207.GA4937@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104124207.GA4937@ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 01:42:07PM +0100, Vojtech Pavlik wrote:
> On Fri, Nov 04, 2005 at 01:35:41PM +0100, Adrian Bunk wrote:
> > This patch contains the following possible cleanups:
> > - make needlessly glbal code static
> 
> Agreed.
> 
> > - gameport/gameport: #if 0 the unused global function gameport_reconnect
> 
> That one should be an EXPORT_SYMBOL() API. If the export is missing,
> then that's the bug that needs to be fixed.
>...

There isn't even a header providing a function prototype which is quite 
strange for a part of an API.

> Vojtech Pavlik

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

