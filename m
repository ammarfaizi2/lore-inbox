Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbULTBfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbULTBfx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 20:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbULTBfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 20:35:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38416 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261369AbULTBfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 20:35:48 -0500
Date: Mon, 20 Dec 2004 02:35:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: mdharm-usb@one-eyed-alien.net, zaitcev@yahoo.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Message-ID: <20041220013542.GK21288@stusta.de>
References: <20041220001644.GI21288@stusta.de> <20041220003146.GB11358@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041220003146.GB11358@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2004 at 04:31:46PM -0800, Greg KH wrote:
> On Mon, Dec 20, 2004 at 01:16:44AM +0100, Adrian Bunk wrote:
> > I've already seen people crippling their usb-storage driver with 
> > enabling BLK_DEV_UB - and I doubt the warning in the help text added 
> > after 2.6.9 will fix all such problems.
> > 
> > Is there except for kernel size any good reason for using BLK_DEV_UB 
> > instead of USB_STORAGE?
> 
> You don't want to use the scsi layer?  You like the stability of it at
> times?  :)
>...

What about a dependency of BLK_DEV_UB on USB_STORAGE=n ?

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

