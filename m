Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbUBONjx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 08:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUBONjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 08:39:53 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35785 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264874AbUBONjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 08:39:52 -0500
Date: Sun, 15 Feb 2004 14:39:46 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Peter Lieverdink <peter@cc.com.au>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2 PPC ALSA snd-powermac
Message-ID: <20040215133946.GT1308@fs.tum.de>
References: <1076483508.13791.6.camel@kahlua> <s5hr7x1bzvr.wl@alsa2.suse.de> <1076540202.13791.19.camel@kahlua> <20040214164707.GL1308@fs.tum.de> <1076794515.30208.0.camel@kahlua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076794515.30208.0.camel@kahlua>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 08:35:15AM +1100, Peter Lieverdink wrote:

> No prob, here you go...

Thanks.

Now I do understand the problem.

Short version:
It should work if you try 2.6.3-rc3 instead.

Long version:
arch/ppc/Kconfig didn't use drivers/Kconfig in 2.6.2 and didn't inclide 
drivers/i2c/Kconfig.
In 2.6.3-rc3, arch/ppc/Kconfig uses drivers/Kconfig.

> - Peter.
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

