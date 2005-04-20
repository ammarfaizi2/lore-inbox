Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVDTUti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVDTUti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 16:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVDTUti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 16:49:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31507 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261804AbVDTUtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 16:49:36 -0400
Date: Wed, 20 Apr 2005 22:49:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dan Dennedy <dan@dennedy.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/: remove unneeded EXPORT_SYMBOL's
Message-ID: <20050420204932.GQ5489@stusta.de>
References: <20050417195706.GD3625@stusta.de> <20050419191328.GJ1111@conscoop.ottawa.on.ca> <1113939827.6277.86.camel@laptopd505.fenrus.org> <42657F7C.8060305@s5r6.in-berlin.de> <1113981989.6238.30.camel@laptopd505.fenrus.org> <426683E9.4080708@s5r6.in-berlin.de> <1114029144.5085.20.camel@kino.dennedy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114029144.5085.20.camel@kino.dennedy.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 04:32:24PM -0400, Dan Dennedy wrote:
>...
> Based upon my experience of several years on this project there is only
> one external kernel module project we need to consider because that
> developer has been involved and voiced requirements. That is Arne
> Caspari's (The Imaging Source) DFG/1394 driver. 

The ideal solution would be to get this driver included in the kernel.
Are there any reasons against including it?

> I vote to remove external symbols not used by the Linux1394.org modules
> or the module at http://sourceforge.net/projects/video-2-1394/
> Of course, I may be voted down, but I ask the others to be realistic
> about what we are arguing for (i.e. just being defensive?) and consider
> the fact that there are valid reasons for their removal.

The DFG/1394 driver requires hpsb_read and hpsb_write.

Are there any Linux1394.org modules that are not in 2.6.12-rc2-mm3?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

