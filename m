Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317452AbSFMFSB>; Thu, 13 Jun 2002 01:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317453AbSFMFSB>; Thu, 13 Jun 2002 01:18:01 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:37789 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317452AbSFMFR7>; Thu, 13 Jun 2002 01:17:59 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: kuebelr@email.uc.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [TRIVIAL] tdfxfb - compiler warning 
In-Reply-To: Your message of "Wed, 12 Jun 2002 23:46:00 -0400."
             <20020613034600.GA3927@cartman> 
Date: Thu, 13 Jun 2002 15:19:53 +1000
Message-Id: <E17IN1V-0004WP-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020613034600.GA3927@cartman> you write:
> When tdfxfb is compiled into the kernel proper, tdfxfb_remove is not
> needed.  Don't compile it if we don't need it.  There is one other
> reference to tdfxfb_remove in tdfxfb.c but, __devexit_p() takes care of
> it.

It'd already defined as __devexit, which (unless hotplug is enabled)
discards the result.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
