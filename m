Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVCKXkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVCKXkk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVCKXTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:19:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22533 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261798AbVCKXDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:03:18 -0500
Date: Sat, 12 Mar 2005 00:03:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Luca Risolia <luca.risolia@studio.unibo.it>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: status of the USB w9968cf.c driver in kernel 2.6?
Message-ID: <20050311230312.GR3723@stusta.de>
References: <20050228231430.GW4021@stusta.de> <1109699163.4224aa5b1e4dc@posta.studio.unibo.it> <20050303152908.GC4608@stusta.de> <1109930313.42283149b4ae6@posta.studio.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109930313.42283149b4ae6@posta.studio.unibo.it>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 10:58:33AM +0100, Luca Risolia wrote:
> Scrive Adrian Bunk <bunk@stusta.de>:
> 
> > On Tue, Mar 01, 2005 at 06:46:03PM +0100, Luca Risolia wrote:
> > > Scrive Adrian Bunk <bunk@stusta.de>: 
>...
> > > > - there's no w9968cf-vpp module in the kernel sources 
> > >  
> > > w9968cf-vpp is an optional, gpl'ed module, which can not be included in the
> > 
> > > mainline kernel, as I explained in the documentation of the driver. 
> > 
> >   Please keep in mind that official kernels do not include the second 
> >   module for performance purposes.
> > 
> > What exactly does this mean?
> 
> Frame decoding/decompression should be done in userspace, although you can 
> still download and use a separate kernel module.
>...

If it's deprecated to do this in a kernel module, shouldn't at some time 
the EXPORT_SYMBOL's for the decoding/decompression module be removed 
from the kernel?

> Regards,
> Luca

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

