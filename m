Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbVIAWAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbVIAWAW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbVIAWAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:00:21 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51982 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030433AbVIAWAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:00:19 -0400
Date: Fri, 2 Sep 2005 00:00:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "J.A. Magallon" <jamagallon@able.es>,
       Christoph Hellwig <hch@infradead.org>
Cc: Linux-Kernel Lista <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm1
Message-ID: <20050901220017.GA3657@stusta.de>
References: <1125598910l.24887l.2l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125598910l.24887l.2l@werewolf.able.es>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 06:21:50PM +0000, J.A. Magallon wrote:

> Hi...
> 
> Back from holydays and trying to get up-to-date with new kernel releases.
> With 2.6.13-mm1, I get this:
> 
> 
> werewolf:/usr/src/linux# make
>   CHK     include/linux/version.h
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
>   LD      drivers/scsi/aic7xxx/built-in.o
> drivers/scsi/aic7xxx/aic79xx.o: In function `aic_parse_brace_option':
> : multiple definition of `aic_parse_brace_option'
> drivers/scsi/aic7xxx/aic7xxx.o:: first defined here
> make[3]: *** [drivers/scsi/aic7xxx/built-in.o] Error 1
> make[2]: *** [drivers/scsi/aic7xxx] Error 2
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2
>...

This problem exists since 2.6.13-rc6-mm1, and Christoph said he wanted 
to fix it...

> by

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

