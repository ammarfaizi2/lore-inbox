Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317453AbSFMFU1>; Thu, 13 Jun 2002 01:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317455AbSFMFU0>; Thu, 13 Jun 2002 01:20:26 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:9628 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317453AbSFMFUY>; Thu, 13 Jun 2002 01:20:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: kuebelr@email.uc.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [TRIVIAL] namespace.c - compiler warning 
In-Reply-To: Your message of "Wed, 12 Jun 2002 23:53:39 -0400."
             <20020613035339.GA3950@cartman> 
Date: Thu, 13 Jun 2002 15:24:23 +1000
Message-Id: <E17IN5r-0004a8-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020613035339.GA3950@cartman> you write:
> init_rootfs() (from ramfs) doesn't appear in any header file.  I didn't
> see any that looked like a good home, so lets put a prototype at the top
> of fs/namespace.c.  This only use of this function is in namespace.c.
> 
> Patch is agains 2.4.19-pre10.

Please simply backport the declaration from 2.5: it gets the function
type correct.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
