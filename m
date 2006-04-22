Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWDVRS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWDVRS6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 13:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWDVRS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 13:18:56 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:45973 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750805AbWDVRSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 13:18:55 -0400
Date: Sat, 22 Apr 2006 10:57:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: chrisw@sous-sol.org, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the Root Plug Support sample module
Message-ID: <20060422085737.GL19754@stusta.de>
References: <20060421201943.GJ19754@stusta.de> <20060421202918.GB32119@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421202918.GB32119@suse.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 01:29:18PM -0700, Greg KH wrote:
>...
> So, I'd like to keep this in the tree, for as long as the LSM interface
> sticks around, if possible.  It's not hurting anything, and it does work
> for users, and is a good example starting point for people wanting to
> use the LSM interface.
> 
> Unless there are any known security problems with it?  If so, please let
> me know.

Using USB Vendor ID/USB Product ID for identifying an USB device doesn't 
seem to bring real security since:
- every other device of the same type works as well
- using an arbitrary USB device with a manipulated
  USB Vendor ID/USB Product ID seems quite possible

It might work as an example, but if people think it would bring them 
real security that's a dangerous misunderstanding.

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

