Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVBKJtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVBKJtu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 04:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVBKJtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 04:49:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21775 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262227AbVBKJtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 04:49:47 -0500
Date: Fri, 11 Feb 2005 10:49:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mws <mws@twisted-brains.org>
Cc: Andreas Oberritter <obi@linuxtv.org>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: DVB at76c651.c driver seems to be dead code
Message-ID: <20050211094934.GO2958@stusta.de>
References: <20050210235605.GN2958@stusta.de> <200502110211.29055.mws@twisted-brains.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502110211.29055.mws@twisted-brains.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 02:11:17AM +0100, Mws wrote:

> FYI
> 
> The atmel at76c651 frontend driver is used for the 
> Sagem DBox2 Digital Cable Receiver. 
> 
> As all other parts of the dbox2 drivers are atm not hosted at kernel cvs but at
> cvs.tuxbox.org you won't find any components in mainline kernel tree using this.
> 
> thus we are a hobby project - but even well known - there are not so many developer
> available to make every kernel driver and other parts of it "kernel-style-alike". 
> maybe there is more progress and kernel driver patching into mainline in the future.
> we are having 2.6.9 running on dbox2 - higher versions are atm broken for support of
> the mpc 823 architecture :/
> 
> removing this driver is not wanted.

If I understand it correctly, there are several drivers that only make 
sense if they are used together. at76c651.c alone makes zero sense?
This means it would be highly appreciated to have all parts inside the 
kernel at some time in the future.

Something different:
The atmel at76c651 frontend driver is specific to the MPC823 
architecture?
In this case this dependency should be expressed in the Kconfig file 
since it then makes no sense to offer this driver on other 
architectures.

> regards
> Marcel Siegert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

