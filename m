Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281066AbRKYVaA>; Sun, 25 Nov 2001 16:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281068AbRKYV3u>; Sun, 25 Nov 2001 16:29:50 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:39428 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S281066AbRKYV3e>; Sun, 25 Nov 2001 16:29:34 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Message-ID: <86256B0F.0075ED4C.00@smtpnotes.altec.com>
Date: Sun, 25 Nov 2001 15:28:39 -0600
Subject: Re: Linux 2.5.0
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Yes, I realize that.  When switching from one tree to another I reverse the
patches back to the fork point (using patch -R) and then apply the appropriate
patches for the tree I want.  That's the method I've used for a long time for
keeping up with both Linus' -preX kernels and Alan's -acX kernels with only a
single source tree.  (After 2.5 has been out for awhile I'll just drop 2.4
altogether and then it won't be an issue.)

Wayne




Arnaldo Carvalho de Melo <acme@conectiva.com.br> on 11/25/2001 10:51:28 AM

To:   Wayne Brown/Corporate/Altec@Altec
cc:   lkml <linux-kernel@vger.kernel.org>

Subject:  Re: Linux 2.5.0



Em Sun, Nov 25, 2001 at 09:16:17AM -0600, Wayne.Brown@altec.com escreveu:
>
>
> Thanks.  I had hoped the version number was the only change, but wanted to be
> sure.  I'll be keeping just one source tree for both 2.4.x and 2.5.x and
> switching between the versions by applying and reversing patches as needed, so
> it's important that my copy of the source stay *exactly* in sync with Linus'

But keep in mind that this is only the fork point, from now on more and
more things will diverge and patches for one will not necessarily apply to
both trees.

> copy (otherwise I've have just altered the version in the Makefile myself).
> With the help of your patch I've just built both 2.4.16-pre1 and 2.5.1-pre1
from
> the same 2.4.15 source, which is what I wanted.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




