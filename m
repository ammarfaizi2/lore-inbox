Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310189AbSCEUZu>; Tue, 5 Mar 2002 15:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310196AbSCEUZj>; Tue, 5 Mar 2002 15:25:39 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:11791 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S310186AbSCEUYR>;
	Tue, 5 Mar 2002 15:24:17 -0500
Date: Tue, 5 Mar 2002 21:06:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Drop support for egcs from 2.5
Message-ID: <20020305200653.GA175@elf.ucw.cz>
In-Reply-To: <Pine.NEB.4.44.0202262131000.9458-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0202262131000.9458-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> the patch below drops support for egcs from 2.5. This patch doesn't remove
> egcs workarounds, it only causes the kernel to refuse to build with egcs
> and to document this. The affected files are:


Why would you like to do that?
									Pavel

> --- init/main.c.old	Tue Feb 26 21:25:30 2002
> +++ init/main.c	Tue Feb 26 21:25:55 2002
> @@ -50,7 +50,7 @@
>   * To avoid associated bogus bug reports, we flatly refuse to compile
>   * with a gcc that is known to be too old from the very beginning.
>   */
> -#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 91)
> +#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 95)
>  #error Sorry, your GCC is too old. It builds incorrect kernels.
>  #endif
> 

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
