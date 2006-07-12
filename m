Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWGLAgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWGLAgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWGLAgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:36:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61960 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932114AbWGLAgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:36:08 -0400
Date: Wed, 12 Jul 2006 02:36:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove mentionings of devfs in documentation
Message-ID: <20060712003606.GA32259@stusta.de>
References: <20060711152546.GV13938@stusta.de> <44B3C781.8060005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B3C781.8060005@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 05:45:05PM +0200, Michal Piotrowski wrote:
> Hi Adrian,
> 
> Adrian Bunk:
> > Now that devfs is removed, there's no longer any need to document how to 
> > do this or that with devfs.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > ---
> [snip]
> > --- linux-2.6.18-rc1-mm1-full/Documentation/ABI/obsolete/devfs	2006-07-09 11:22:37.000000000 +0200
> > +++ /dev/null	2006-04-23 00:42:46.000000000 +0200
> > @@ -1,13 +0,0 @@
> > -What:		devfs
> > -Date:		July 2005
> > -Contact:	Greg Kroah-Hartman <gregkh@suse.de>
> > -Description:
> > -	devfs has been unmaintained for a number of years, has unfixable
> > -	races, contains a naming policy within the kernel that is
> > -	against the LSB, and can be replaced by using udev.
> > -	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
> > -	along with the the assorted devfs function calls throughout the
> > -	kernel tree.
> > -
> > -Users:
> > -
> 
> According to Documentation/ABI/README
> "  removed/
>         This directory contains a list of the old interfaces that have
>         been removed from the kernel.
> "
> 
> we should add devfs to removed/

Thanks, agreed.

> Regards,
> Michal
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

