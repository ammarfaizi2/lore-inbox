Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130065AbRCWHqJ>; Fri, 23 Mar 2001 02:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130129AbRCWHqA>; Fri, 23 Mar 2001 02:46:00 -0500
Received: from www.wen-online.de ([212.223.88.39]:64527 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130065AbRCWHpp>;
	Fri, 23 Mar 2001 02:45:45 -0500
Date: Fri, 23 Mar 2001 08:44:59 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Kevin Buhr <buhr@stat.wisc.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <vba1yrp30qb.fsf@mozart.stat.wisc.edu>
Message-ID: <Pine.LNX.4.33.0103230844090.2031-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Mar 2001, Kevin Buhr wrote:

> Mike Galbraith <mikeg@wen-online.de> writes:
> >
> > 2.4.2.ac20.virgin   2.4.3-pre6
> > real    11m0.708s   11m58.617s
> > user    15m8.720s   7m29.970s
> > sys     1m31.410s   0m41.590s
> >
> > It looks like ac20 is doing some double accounting.

[snip]

> Mike, would you like to try out the following (untested) patch against
> vanilla ac20 to see if it does the trick?

Yes, that fixed it.

	-Mike


