Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSFYQnd>; Tue, 25 Jun 2002 12:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315611AbSFYQnc>; Tue, 25 Jun 2002 12:43:32 -0400
Received: from n184.ols.wavesec.net ([209.151.19.184]:40832 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315607AbSFYQnb>; Tue, 25 Jun 2002 12:43:31 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: James Mayer <james@cobaltmountain.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Typo in arch/mips/dec/wbflush.c 
In-reply-to: Your message of "Mon, 24 Jun 2002 15:55:05 CST."
             <20020624215505.GA7864@galileo> 
Date: Wed, 26 Jun 2002 02:48:20 +1000
Message-Id: <E17MtUK-0002mL-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020624215505.GA7864@galileo> you write:
> --- linux.orig-2.4.19-rc1/arch/mips/dec/wbflush.c	Fri Oct  5 13:06:51 200
1
> +++ linux/arch/mips/dec/wbflush.c	Mon Jun 24 15:49:53 2002
> @@ -97,7 +97,7 @@
>  }
>  
>  /*
> - * The DS500/2x0 doesnt need to write back the WB.
> + * The DS500/2x0 doesn't need to write back the WB.
>   */
>  static void wbflush_kn03(void)
>  {

Hmm...

	I've only applied the one that was an actually a definite
spellfix.  While I prefer to use apostrophes, it's a common
abbreviation to skip it: 1/10 according to google.  Compare with
another common misspelling (recieve) which is 1/50.

Given there is a non-zero cost (patch conflict with developers) even
with trivial patches, I've decided not to apply your 41
"doesnt"->"doesn't" patches, unless someone convinces me otherwise.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
