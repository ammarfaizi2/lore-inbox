Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281440AbRKHEHW>; Wed, 7 Nov 2001 23:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281445AbRKHEHM>; Wed, 7 Nov 2001 23:07:12 -0500
Received: from viper.haque.net ([66.88.179.82]:9877 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S281440AbRKHEHF>;
	Wed, 7 Nov 2001 23:07:05 -0500
Date: Wed, 7 Nov 2001 23:07:05 -0500
Subject: Re: kernel compilation failure, 'deactivate_page'
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v475)
Cc: <linux-kernel@vger.kernel.org>
To: Wouter Van Hemel <wouter@fort-knox.rave.org>
From: "Mohammad A. Haque" <mhaque@haque.net>
In-Reply-To: <Pine.LNX.4.33.0111080403170.1247-100000@fort-knox.rave.org>
Message-Id: <1228C3EC-D3FE-11D5-A423-00306569F1C6@haque.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.475)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday, November 7, 2001, at 10:26 PM, Wouter Van Hemel wrote:

>
> I can't get the (clean) 2.4.14 kernel to compile. In the end, during
> linking I guess, it fails with:
>
> [...]
> drivers/block/block.o: In function `lo_send':
> drivers/block/block.o(.text+0x854f): undefined reference to 
> `deactivate_page'
> drivers/block/block.o(.text+0x8599): undefined reference to 
> `deactivate_page'
> make: *** [vmlinux] Error 1
>
> And this is what happens before, while compiling loop.c:
> loop.c: In function `lo_send':
> loop.c:210: warning: implicit declaration of function `deactivate_page'

Durn it wouter, you creating problems here too? =P

http://marc.theaimsgroup.com/?l=linux-kernel&m=100502447823220&w=2

--

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                                mhaque@haque.net

   "Alcohol and calculus don't mix.             Developer/Project Lead
    Don't drink and derive." --Unknown          http://wm.themes.org/
                                                batmanppc@themes.org
=====================================================================

