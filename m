Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVHRWxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVHRWxX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbVHRWxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:53:23 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22023 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750705AbVHRWxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:53:22 -0400
Date: Fri, 19 Aug 2005 00:53:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Imanpreet Arora <imanpreet@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux under 8MB
Message-ID: <20050818225312.GG3822@stusta.de>
References: <c26b9592050818151154ff1a89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26b9592050818151154ff1a89@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 03:41:30AM +0530, Imanpreet Arora wrote:
> Hi all,
> 
>               For the last couple of days, I have been trying to set
> up linux kernel under 8MB. So far I have set up a linux 2.4.31, which
> just works under 8MB. However, I would be grateful if someone could
> help with the following queries
> 
> a)          Is linux2.4 just the right option? What about linux 2.0.x?
> Or for that matter even <2.0

The more interesting case would ne a recent 2.6 kernel with

  General setup
    Configure standard kernel features (for small systems)

enabled and appropriate options below this option selected.

> b)          What are the specific issues that are to be considered
> while compiling an old kernel on a newer setup? I ask this because I
> compiled my current setup on a 2.6.11 machine and while doing "make
> modules_install", I got errors from depmod[%], complaining about
> depmod.old.  I had to kludge my way through by setting up a link from
> depmod.old to depmod.

What userspace do you want to use on the 8MB machine?
You need a userspace that supports such an old kernel.

> [%] Not to mention that on a FC4 machine, gcc 4,x meowed  while
> compiling the kernel.

gcc 4.0 is not a working compiler for _any_ kernel below 2.6.12.

> TIA,

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

