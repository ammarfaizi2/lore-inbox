Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWATUll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWATUll (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWATUll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:41:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42257 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932113AbWATUlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:41:40 -0500
Date: Fri, 20 Jan 2006 21:41:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: thomas@winischhofer.net, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/misc/sisusbvga/: possible cleanups
Message-ID: <20060120204140.GB31803@stusta.de>
References: <20060119011854.GV19398@stusta.de> <20060120011132.GA28981@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120011132.GA28981@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 05:11:32PM -0800, Greg KH wrote:
> On Thu, Jan 19, 2006 at 02:18:54AM +0100, Adrian Bunk wrote:
> > This patch contains the following possible cleanups:
> > - make needlessly global functions static
> > - function and struct declarations belong into header files
> > - make SiS_VCLKData const
> > - #if 0 the following unused global functions:
> >   - sisusb.c: sisusb_writew()
> >   - sisusb.c: sisusb_readw()
> >   - sisusb_init.c: SiSUSB_GetModeID()
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> For some reason, this doesn't apply.  Care to rediff it?

My patch was made against -mm which contains 
convert-the-semaphores-in-the-sisusb-driver-to-mutexes.patch.

Should I rediff or should I wait until you've merged this patch?

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

