Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277357AbRJOJfw>; Mon, 15 Oct 2001 05:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277361AbRJOJfm>; Mon, 15 Oct 2001 05:35:42 -0400
Received: from eispost12.serverdienst.de ([212.168.16.111]:7175 "EHLO imail")
	by vger.kernel.org with ESMTP id <S277357AbRJOJfb>;
	Mon, 15 Oct 2001 05:35:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
To: Peter Jay Salzman <p@dirac.org>
Subject: Re: something's wrong with the 2.4.12 compilation
Date: Mon, 15 Oct 2001 11:35:25 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <20011014235017.A17420@dirac.org>
In-Reply-To: <20011014235017.A17420@dirac.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011015114275.SM00161@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. Oktober 2001 08:50 schrieb Peter Jay Salzman:
> hi all,
>
> grabbed 2.4.12, copied .config from my current 2.4.10, did a make
> oldconfig and make dep && make bzImage.   here's the error:
>
>   ieee1284_ops.c: In function `ecp_forward_to_reverse':
>   ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first
> use in this function)
>   ieee1284_ops.c:365: (Each undeclared identifier is reported
> only once ieee1284_ops.c:365: for each function it appears in.)
>   ieee1284_ops.c: In function `ecp_reverse_to_forward':
>   ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first
> use in this function)
>   make[3]: *** [ieee1284_ops.o] Error 1
>   make[3]: Leaving directory
> `/usr/src/linux-2.4.12/drivers/parport' make[2]: *** [first_rule]
> Error 2
>   make[2]: Leaving directory
> `/usr/src/linux-2.4.12/drivers/parport' make[1]: ***
> [_subdir_parport] Error 2
>   make[1]: Leaving directory `/usr/src/linux-2.4.12/drivers'
>   make: *** [_dir_drivers] Error 2
>   satan#
>
> i don't need 2.4.12 for anything in particular, so please don't
> feel like i need help or anything.  i'm perfectly happy with
> 2.4.10.
>
> my only concern is for the kernel itself.  someone out there may
> really depend on the new release.
>
> if you want to ask any questions or a copy of .config, please
> email me at p(at)dirac.org.

You have run into the parport compile bug.
It is fixed in 2.4.13-pre1

>
> thank you!  :)
>
> pete

hth,
 Robert

-- 
Where do you want to be tomorrow?

Entracom. Building Linux systems.
http://www.entracom.de
