Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262126AbRE2XvP>; Tue, 29 May 2001 19:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262058AbRE2XvG>; Tue, 29 May 2001 19:51:06 -0400
Received: from chromium11.wia.com ([207.66.214.139]:58636 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S262468AbRE2Xux>; Tue, 29 May 2001 19:50:53 -0400
Message-ID: <3B1436DC.60869CFB@chromium.com>
Date: Tue, 29 May 2001 16:55:08 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@kernel.org>
CC: "Leeuw van der, Tim" <tim.leeuwvander@nl.unisys.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac2
In-Reply-To: <DD0DC14935B1D211981A00105A1B28DB033ED2F0@NL-ASD-EXCH-1> <3B13542A.5DBA3903@chromium.com> <20010529121954.J26871@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes I get a performance improvement of about 5%

could you port your patches to the 2.4.5-ac4 kernel? I'd love to see if the ac
improvements and yours add to each other.

 Thanks,

 - Fabio

Jens Axboe wrote:

> On Tue, May 29 2001, Fabio Riccardi wrote:
> > "Leeuw van der, Tim" wrote:
> >
> > > But the claim was that 2.4.5-ac2 is faster than 2.4.5 plain, so which
> > > changes are in 2.4.5-ac2 that would make it faster than 2.4.5 plain? Also, I
> > > don't know if 2.4.5-ac1 is as fast as 2.4.5-ac2 for Fabio. If not, then it's
> > > a change in the 2.4.5-ac2 changelog. If it is as fast, it is one of the
> > > changes in the 2.4.5-ac1 changelog.
> >
> > 2.4.5-ac1 crashed on my machine, vanilla 2.4.5 worked but slower than 2.4.2
> >
> > 2.4.5-ac2 is _a lot_ faster than all the 2.4.4 and of vanilla 2.4.5
> >
> > please notice that I have a 4G machine, dual proc, and I run a very
> > memory/IO/CPU intensive test, so your mileage may vary with different
> > applications.
>
> Could you try the 4GB I/O patches and see if they boost performance of
> such cases?
>
> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.5/
>
> --
> Jens Axboe
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

