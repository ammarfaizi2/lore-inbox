Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317179AbSEXPTV>; Fri, 24 May 2002 11:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317180AbSEXPTU>; Fri, 24 May 2002 11:19:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46076 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317179AbSEXPTT>; Fri, 24 May 2002 11:19:19 -0400
Subject: Re: Compiling 2.2.19 with -O3 flag
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: samson swanson <intellectcrew@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E17BGGw-0006NO-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 24 May 2002 08:19:03 -0700
Message-Id: <1022253543.962.236.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-24 at 07:42, Alan Cox wrote:

> Bench it and see. From my own experience -O3 made the kernel a lot larger
> and reduced overall performance - in part because the kernel already 
> explicitly figures out what it wants inlined.
> 
> Interestingly enough -Os outperformed -O2

Heh, now that is interesting.

Or maybe not - not too long ago I did some tests of the various
optimization options in gcc 2.96 or so and found that -O2 generates
smaller code in most cases than -Os.  -Os also did not perform as good,
but I was just testing a few bits of code - nothing as versatile as the
kernel.

The end result was I recommend -O2 for both performance and size.  Maybe
I should retest against the kernel...

	Robert Love

