Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWDFWnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWDFWnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 18:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWDFWnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 18:43:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11271 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932198AbWDFWnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 18:43:40 -0400
Date: Fri, 7 Apr 2006 00:43:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problem compiling 2.6.16.1
Message-ID: <20060406224339.GC7118@stusta.de>
References: <4d8e3fd30604060221i1d49cf2brd5fd786b6ce75822@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8e3fd30604060221i1d49cf2brd5fd786b6ce75822@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 11:21:46AM +0200, Paolo Ciarrocchi wrote:

> Hi all,
> a friend of mine got this error compiling 2.6.16.1 and we don't know
> what's wrong:
> 
> uno:/usr/src/linux-2.6.16.1#   make O=/home/dan/build/kernel menuconfig
>  HOSTCC  scripts/basic/fixdep
>...
> /usr/include/bits/local_lim.h:36:26: linux/limits.h: No such file or directory
>...
> Any hint?

Your friend has gcc installed, but not the kernel headers that should 
be provided by his distribution for usage with his libc (although they 
are similar, these are _not_ the headers of the kernel he is trying 
to compile).

> Paolo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

