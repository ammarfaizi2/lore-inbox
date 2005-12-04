Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVLDTwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVLDTwL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 14:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVLDTwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 14:52:11 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:772 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932326AbVLDTwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 14:52:09 -0500
Date: Sun, 4 Dec 2005 20:52:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] remove code for WIRELESS_EXT < 18
Message-ID: <20051204195207.GA9973@stusta.de>
References: <20051203122720.GF31395@stusta.de> <4393447E.3020003@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4393447E.3020003@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 02:33:18PM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >WIRELESS_EXT < 18 will never be true in the kernel.
> >
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> >---
> >
> > drivers/net/wireless/ipw2100.c           |  434 ----------------------
> > drivers/net/wireless/tiacx/acx_struct.h  |    5 
> > drivers/net/wireless/tiacx/common.c      |    4 
> > drivers/net/wireless/tiacx/conv.c        |    2 
> > drivers/net/wireless/tiacx/ioctl.c       |  441 -----------------------
> > drivers/net/wireless/tiacx/pci.c         |    8 
> > drivers/net/wireless/tiacx/usb.c         |    6 
> > drivers/net/wireless/tiacx/wlan.c        |    2 
> > drivers/net/wireless/tiacx/wlan_compat.h |    9 
> > 9 files changed, 1 insertion(+), 910 deletions(-)
> 
> NAK, patches non-existent files.
> 
> [jgarzik@pretzel linux-2.6]$ ls drivers/net/wireless/tiacx
> ls: drivers/net/wireless/tiacx: No such file or directory

As the subject says, it's against -mm.

How should I resend it?
One patch against ipw2100.c and one patch for the tiacx stuff?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

