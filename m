Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263611AbUJ2XxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbUJ2XxL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263550AbUJ2XxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:53:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5137 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263611AbUJ2XwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:52:19 -0400
Date: Sat, 30 Oct 2004 01:51:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: kj <kernel-janitors@osdl.org>, linux-kernel@vger.kernel.org,
       Nishanth Aravamudan <nacc@us.ibm.com>
Subject: 2.6.10-rc1-kjt1: ixgb_ethtool.c doesn't compile
Message-ID: <20041029235137.GG6677@stusta.de>
References: <20041024151241.GA1920@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041024151241.GA1920@stro.at>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 05:12:41PM +0200, maximilian attems wrote:
>...
> splitted out 168 patches:
> http://debian.stro.at/kjt/2.6.10-rc1-kjt1/split/

Could you provide a .tar.gz (or .tar.bz) of the splitted patches 
(similar to how Andrew does for -mm)?

> thanks for feedback.
> maks
>...

msleep_interruptible-drivers_net_ixgb_ixgb_ethtool.patch doesn't 
compile:

<--  snip  -->

...
  CC      drivers/net/ixgb/ixgb_ethtool.o
drivers/net/ixgb/ixgb_ethtool.c: In function `ixgb_ethtool_led_blink':
drivers/net/ixgb/ixgb_ethtool.c:407: error: `id' undeclared (first use in this function)
drivers/net/ixgb/ixgb_ethtool.c:407: error: (Each undeclared identifier is reported only once
drivers/net/ixgb/ixgb_ethtool.c:407: error: for each function it appears in.)
make[3]: *** [drivers/net/ixgb/ixgb_ethtool.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

