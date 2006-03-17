Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWCQXZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWCQXZA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWCQXZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:25:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25866 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751245AbWCQXY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:24:59 -0500
Date: Sat, 18 Mar 2006 00:24:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: Re: [PATCH 05/21] Added no_overlay option and quirks to saa7134
Message-ID: <20060317232457.GB9717@stusta.de>
References: <20060317205359.PS65198900000@infradead.org> <20060317205433.PS91497800005@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317205433.PS91497800005@infradead.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 05:54:34PM -0300, mchehab@infradead.org wrote:
> 
> From: Mauro Carvalho Chehab <mchehab@infradead.org>
> Date: 1142020010 \-0300
> 
> Some chipsets have several problems when pci to pci transfers are activated
> on overlay mode. the option no_overlay allows disabling such feature of
> the driver, in favor of keeping the system stable.
> The default is to use pcipci_fail flag defined on drivers/pci/quirks.c.
> It also allows the user to override it by forcing disable overlay or forcing
> enable. Forcing enable may generate PCI transfer corruption, including disk
> mass corruption, so should be used with care.
> Added a text description to this option and make messages looks the same at
> both bttv and saa7134 drivers.
>...

As far as I can see, the the no_overlay option in the saa7134 driver 
doesn't change anything (except for a printk).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

