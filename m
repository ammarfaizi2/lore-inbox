Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVACS4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVACS4w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVACRtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:49:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29201 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261764AbVACRoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:44:08 -0500
Date: Mon, 3 Jan 2005 18:44:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix inlining related build failures in mxser.c
Message-ID: <20050103174403.GI2980@stusta.de>
References: <Pine.LNX.4.61.0412240155070.3504@dragon.hygekrogen.localhost> <Pine.LNX.4.61.0412241306340.19395@yvahk01.tjqt.qr> <Pine.LNX.4.61.0412241431580.3707@dragon.hygekrogen.localhost> <87zn03u7h8.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zn03u7h8.fsf@deneb.enyo.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2004 at 02:54:43PM +0100, Florian Weimer wrote:
> * Jesper Juhl:
> 
> >> Add -funit-at-a-time to the CFLAGS, and the compiler is happy.
> >> 
> > But, does unit-at-a-time work reliably for all compilers on all archs back 
> > to and including gcc 2.95.3 ? 
> 
> Unit-at-a-time is only available in GCC 3.4 and above.
> Function-at-a-time will still be supported in GCC 4.0, but this
> version will use unit-at-a-time by default (if optimization is
> enable).

unit-at-a-time is already enabled at -O2 in 3.4 .

The kernel Makefile explicitely disables it on i386.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

