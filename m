Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264488AbUEVBgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbUEVBgW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264843AbUEVBfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 21:35:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28100 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265168AbUEUX5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:57:01 -0400
Date: Thu, 20 May 2004 00:56:45 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Martin Knoblauch <knobi@knobisoft.de>, "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm4: missing symbol __log_start_commit in ext3.o
Message-ID: <20040519225644.GG24287@fs.tum.de>
References: <20040519151913.47070.qmail@web13906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519151913.47070.qmail@web13906.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 08:19:13AM -0700, Martin Knoblauch wrote:
> Hi,
> 
>  ext3 complains about a missing symbol in 2.6.6.-mm4:
> 
>   SPLIT   include/linux/autoconf.h -> include/config/*
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CC [M]  fs/ext3/balloc.o
>   LD [M]  fs/ext3/ext3.o
>   Building modules, stage 2.
>   MODPOST
> *** Warning: "__log_start_commit" [fs/ext3/ext3.ko] undefined!
> 
>  .config attached.

Thanks for this report.

@Ted:
Your "Retry allocation after transaction commit" patch broke modular 
ext3.

> Cheers
> Martin

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

