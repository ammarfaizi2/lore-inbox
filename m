Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWGWP7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWGWP7S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 11:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWGWP7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 11:59:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3602 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751241AbWGWP7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 11:59:17 -0400
Date: Sun, 23 Jul 2006 17:59:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: Graphic: userspace headers interdependencies
Message-ID: <20060723155913.GV25367@stusta.de>
References: <20060723101523.GS25367@stusta.de> <20060723152551.GA6816@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060723152551.GA6816@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2006 at 07:25:51PM +0400, Alexey Dobriyan wrote:
> On Sun, Jul 23, 2006 at 12:15:23PM +0200, Adrian Bunk wrote:
> > I've written a quick'n'dirty script for visualizing the
> > interdependencies of the i386 userspace headers in 2.6.18-rc2.
> >
> > In case anyone is interested, it's at [1] (warning: it's big).
> >
> > The graphic also shows some problems like headers including not exported
> > headers. I'm currently working on fixing such issues in my hdrcleanup
> > tree.
> 
> [PATCH] mqueue.h: don't include linux/types.h
>...

Thanks, applied to the hdrcleanup tree.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

