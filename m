Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130737AbQKHCQl>; Tue, 7 Nov 2000 21:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130687AbQKHCQb>; Tue, 7 Nov 2000 21:16:31 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:34565 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S130737AbQKHCQT>; Tue, 7 Nov 2000 21:16:19 -0500
Message-ID: <3A08B759.1C36A9C0@holly-springs.nc.us>
Date: Tue, 07 Nov 2000 21:15:53 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Weinehall <tao@acc.umu.se>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre20
In-Reply-To: <E13tKjj-00085w-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > On Tue, Nov 07, 2000 at 09:02:36PM -0500, Michael Rothwell wrote:
> > > 64-bit printk.
> >
> > Please consider this one Alan, if not for v2.2.18, then at least for
> > v2.2.19pre1.
> 
> Nobody has explained why we even need it.

Alan Cox wrote:
> 
> Why do we need it ?

To print 64-bit debugging output on 32-bit machines. I personally need
it to aid with development of a 64-bit filesystem. We're maintaining our
own 2.2.17 patched kernel here, but I figure that other people can make
use of 64-bit printk in their efforts as well.

Perhaps a better question would be, why reject it? 2.4 supports 64-bit
printk, right? It would be nice to have it on 2.2 as well, as it may be
a while before 2.4 is widely used in production machines.

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
