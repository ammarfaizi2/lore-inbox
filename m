Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbUKHVZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbUKHVZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUKHVZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:25:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33546 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261237AbUKHVZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:25:34 -0500
Date: Mon, 8 Nov 2004 22:25:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pawe?? Sikora <pluto@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill IN_STRING_C
Message-ID: <20041108212503.GG15077@stusta.de>
References: <20041107142445.GH14308@stusta.de> <200411081942.38954.pluto@pld-linux.org> <20041108185222.GE15077@stusta.de> <200411082011.46775.pluto@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411082011.46775.pluto@pld-linux.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 08:11:46PM +0100, Pawe?? Sikora wrote:
> 
> gcc -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -Wall
> -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2
> -Wdeclaration-after-statement -pipe -msoft-float -mpreferred-stack-boundary=2
> -fno-unit-at-a-time -march=pentium3 -Iinclude/asm-i386/mach-default -S sp.c
> 
>...
>         call    strcpy
>...
> strcpy:
>         pushl   %ebp
>...

That's no function call.  :-)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

