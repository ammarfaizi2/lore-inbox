Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbWB0W31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWB0W31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWB0W31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:29:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4365 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751694AbWB0W30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:29:26 -0500
Date: Mon, 27 Feb 2006 23:29:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "James C. Georgas" <jgeorgas@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-ID: <20060227222926.GX3674@stusta.de>
References: <20060225160150.GX3674@stusta.de> <1141078686.28136.20.camel@Rainsong.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141078686.28136.20.camel@Rainsong.home>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 05:18:06PM -0500, James C. Georgas wrote:
> On Sat, 2006-25-02 at 17:01 +0100, Adrian Bunk wrote:
> > CONFIG_UNIX=m doesn't make much sense.
> 
> I've been building it as a module forever. I often load kernels from
> floppy disk, and building CONFIG_UNIX as a module often makes the
> difference between the kernel fitting or not fitting on the disk. Could
> we please keep this functionality?

If size is important for you, you should consider completely disabling 
module support in your kernels:

In my testing, disabling module support brings you a space gain in the 
range of 10%.

> James C. Georgas <jgeorgas@rogers.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

