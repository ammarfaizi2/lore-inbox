Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVKWUb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVKWUb7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVKWUb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:31:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23825 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932356AbVKWUbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:31:52 -0500
Date: Wed, 23 Nov 2005 21:31:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: gregkh@suse.de, Thomas Winischhofer <thomas@winischhofer.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/misc/sisusbvga/sisusb.c: remove dead code
Message-ID: <20051123203150.GT3963@stusta.de>
References: <20051120232239.GI16060@stusta.de> <20051123190237.GA28080@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123190237.GA28080@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 11:02:37AM -0800, Greg KH wrote:
> On Mon, Nov 21, 2005 at 12:22:39AM +0100, Adrian Bunk wrote:
> > The Coverity checker found this obviously dead code.
> 
> I think the checker is wrong, this does not look correct to me.

Why?

Due to the while(length), length can't be 0 at the switch.

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

