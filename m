Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVEAOXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVEAOXe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 10:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVEAOXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 10:23:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35847 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261519AbVEAOXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 10:23:32 -0400
Date: Sun, 1 May 2005 16:23:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: 2003 John Klar <linpvr@projectplasma.com>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
Subject: Re: [2.6 patch] drivers/media/video/tveeprom.c: possible cleanups
Message-ID: <20050501142330.GE3592@stusta.de>
References: <20050419005315.GP5489@stusta.de> <20050419075348.GD15656@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419075348.GD15656@bytesex>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 09:53:48AM +0200, Gerd Knorr wrote:

> > - #if 0 the EXPORT_SYMBOL'ed but unused function tveeprom_dump
> 
> That's a debug helper function, please don't drop it.  #if 0 might be
> ok, not sure though, the tveeprom module is also used by a out-of-kernel
> driver (ivtv).  Otherwise the patch looks fine to me.

As the comment says, my patch does #if 0 the function.

>   Gerd

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

