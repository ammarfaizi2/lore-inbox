Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVBFNcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVBFNcM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVBFNcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:32:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12301 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261241AbVBFNcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:32:05 -0500
Date: Sun, 6 Feb 2005 14:32:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] IDE: unsexport 3 functions
Message-ID: <20050206133201.GO3129@stusta.de>
References: <20050205024404.GK19408@stusta.de> <58cb370e05020605256b3ea00e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e05020605256b3ea00e@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 02:25:32PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > @@ -161,8 +161,6 @@
> >         return ide_stopped;
> >  }
> > 
> > -EXPORT_SYMBOL(do_rw_taskfile);
> > -
> 
> Is this patch against -mm or ide-dev-2.6?

This is against -mm.
But the only changes regarding do_rw_taskfile in -mm come from 
bk-ide-dev.

> do_rw_taskfile() is still needed for ide-disk.c in linus' tree,
> the other two exports can be removed

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

