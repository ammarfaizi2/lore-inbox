Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVHXIUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVHXIUC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 04:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbVHXIUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 04:20:01 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34575 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750707AbVHXIUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 04:20:00 -0400
Date: Wed, 24 Aug 2005 10:19:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sergio Paracuellos <sparacuellos@lock-linux.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>
Subject: Re: Exporting symbols between modules
Message-ID: <20050824081958.GD5603@stusta.de>
References: <1124869718.3073.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124869718.3073.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 09:48:38AM +0200, Sergio Paracuellos wrote:

> Hi all,

Hi Sergio,

> I'm new in this list and I have some problems exporting symbols in a
> module to see them in other module.
> 
> In the module I want to export the symbol I do:
> 
> tList list;
> EXPORT_SYMBOL(list);
> 
> I compile it and install without any problem.
> 
> And in the module I want to use them I declare list with "extern"
> prototype:
> 
> extern tList list;
> 
> When I compile the module It says me that list is undefined, and I don't
> know what I am doing wrong.
> 
> Does anybody know what is happening? 
> 
> Maybe a makefile example would be appreciated... 
> 
> Thanks in advance.

1. the kernel-mentors list [1] is a better place for such questions
2. please post an URL to the full source of your driver, without it
   debugging your problem is not possible

> Regards,
> 
>         Sergio 

cu
Adrian

[1] http://selenic.com/mailman/listinfo/kernel-mentors

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

