Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136711AbREJO7i>; Thu, 10 May 2001 10:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136710AbREJO71>; Thu, 10 May 2001 10:59:27 -0400
Received: from idiom.com ([216.240.32.1]:3855 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S136708AbREJO7V>;
	Thu, 10 May 2001 10:59:21 -0400
Message-ID: <3AFAABFF.54CEA711@namesys.com>
Date: Thu, 10 May 2001 07:56:00 -0700
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14cl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: john slee <indigoid@higherplane.net>
CC: Martin Hamilton <martin@net.lut.ac.uk>,
        Mart?n Marqu?s <martin@bugs.unl.edu.ar>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <indigoid@higherplane.net> <E14xqGx-0006Y6-00@gadget.lut.ac.uk> <20010511003255.C7653@higherplane.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john slee wrote:

> > quite a bit of scope for improvement.  Commercial caching systems have
> > demonstrated thoughput of thousands of requests/s with similar
> > hardware, but I suspect Tux-ification of Squid will be necessary to
>
> not at all, search for X15 in april/may linux-kernel archives.  most of
> the specific improvements tux made have been reduced to improvements for
> the general case, hence squid (or equivalent) could probably improve a
> fair amount.
>
> j.
>
> --
> "Bobby, jiggle Grandpa's rat so it looks alive, please" -- gary larson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

squid needs a deep rewrite, and the sponsor for our doing that is flaking
regarding sending us money, so for now I have to say to people that even
though reiserfs is faster for squid than ext2, the bottleneck is squid not
reiserfs, and you really should use the proprietary stuff because the
proprietary guys have taken squid, rewritten its engine which is badly
designed, stolen the gpl code, and nobody is suing them for it and they are
so much faster than squid that the cost of the software is worth paying for
(unless you dislike stolen gpl code:-(, and even then there are some like
Novell that didn't steal from squid and are faster).

Hans

