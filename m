Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTIMRK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 13:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbTIMRK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 13:10:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42956 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261757AbTIMRK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 13:10:56 -0400
Date: Sat, 13 Sep 2003 19:10:48 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030913171048.GJ27368@fs.tum.de>
References: <20030913125103.GE27368@fs.tum.de> <3F632790.1020002@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F632790.1020002@cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 07:20:00AM -0700, Kevin P. Fleming wrote:
> Adrian Bunk wrote:
> 
> >I'd appreciate it if more people could try this patch and report whether 
> >their kernel compiles and works.
> 
> Compiling with config below produces linking errors:
> 
> arch/i386/lib/lib.a(usercopy.o): In function `__copy_to_user_ll':
> usercopy.o(.text+0x279): undefined reference to `movsl_mask'
> arch/i386/lib/lib.a(usercopy.o): In function `__copy_from_user_ll':
> usercopy.o(.text+0x2e9): undefined reference to `movsl_mask'
> 
> .config:
>...

Thanks for your report. I found the problem and I'll send an updated 
patch soon.

cu
Adrian

BTW: It's easier if you send the complete .config.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

