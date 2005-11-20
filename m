Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVKTXqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVKTXqO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVKTXqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:46:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54032 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932138AbVKTXqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:46:13 -0500
Date: Mon, 21 Nov 2005 00:46:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jody McIntyre <scjody@steamballoon.com>
Cc: bcollins@debian.org, dan@dennedy.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/raw1394.c: fix a NULL pointer dereference
Message-ID: <20051120234612.GQ16060@stusta.de>
References: <20051120232009.GH16060@stusta.de> <20051120233351.GA20781@conscoop.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120233351.GA20781@conscoop.ottawa.on.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 at 06:33:51PM -0500, Jody McIntyre wrote:
> On Mon, Nov 21, 2005 at 12:20:09AM +0100, Adrian Bunk wrote:
> > +	if(cache->filled_head)
> > +		kfree(cache->filled_head);
> 
> Try again.  kfree() of a NULL pointer is perfectly fine.

The problem is that cache is NULL...

> Jody

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

