Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSKTWYY>; Wed, 20 Nov 2002 17:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSKTWYY>; Wed, 20 Nov 2002 17:24:24 -0500
Received: from p50829436.dip.t-dialin.net ([80.130.148.54]:27662 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S261693AbSKTWYX>; Wed, 20 Nov 2002 17:24:23 -0500
Date: Wed, 20 Nov 2002 22:30:56 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: George France <france@handhelds.org>
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [Patch] 2.5.48 Trivial to ../asm-alpha/suspend.h
Message-ID: <20021120223056.A650@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: George France <france@handhelds.org>,
	linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
References: <02112016143302.13910@shadowfax.middleearth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <02112016143302.13910@shadowfax.middleearth>; from france@handhelds.org on Wed, Nov 20, 2002 at 04:14:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 04:14:33PM -0500, George France wrote:
> Fix compilation failure.
> 
> Best Regards,
> 
> 
> --George
> 
> --- linux/include/asm-alpha/suspend.h.orig      Wed Dec 31 19:00:00 1969
> +++ linux/include/asm-alpha/suspend.h   Wed Nov 20 03:55:57 2002
> @@ -0,0 +1,4 @@
> +#ifdef _ASMALPHA_SUSPEND_H

#ifndef I suppose?

> +#define _ASMALPHA_SUSPEND_H
> + 
> +#endif
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
