Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272676AbRILHYE>; Wed, 12 Sep 2001 03:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272681AbRILHXx>; Wed, 12 Sep 2001 03:23:53 -0400
Received: from shaker.worfie.net ([203.8.161.33]:13830 "HELO mail.worfie.net")
	by vger.kernel.org with SMTP id <S272676AbRILHXp>;
	Wed, 12 Sep 2001 03:23:45 -0400
Date: Wed, 12 Sep 2001 15:24:03 +0800 (WST)
From: "J.Brown (Ender/Amigo)" <ender@enderboi.com>
X-X-Sender: <ender@shaker.worfie.net>
To: Peter Horton <pdh@berserk.demon.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [GOLDMINE!!!] Athlon optimisation bug (was Re: Duron kernel
 crash)
In-Reply-To: <20010912072853.A479@berserk.demon.co.uk>
Message-ID: <Pine.LNX.4.31.0109121523130.23923-100000@shaker.worfie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Intresting. I'll try that, because it sounds exactly what I had (constant
segfaults in 2.2.18, occasional and more random in 2.4.x).


 - Ender

> A colleague purchased a number of A7V133s all of which exhibited seg faults
> in make and gcc. make reproducibly seg faulted in vfork(). This was
> with 2.2.18 kernels compiled for i586. We next tried a 2.4.8 kernel
> built for i686 and the problem persisted, though less reproducibly. The
> kernel reports 'Applying VIA southbridge workaround', but it looks
> like we need another fix.
>
> Most of the BIOS options had no effect, but changing the 'PCI latency'
> setting from 32 to 64 seems to have fixed it, fingers crossed.
>
> P.
>
> --
> +--------------------------------------------------+
> | Peter Horton      | pdh@colonel-panic.org        |
> | Software Engineer | http://www.colonel-panic.org |
> +--------------------------------------------------+
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

