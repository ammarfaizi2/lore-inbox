Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145322AbRA2GO2>; Mon, 29 Jan 2001 01:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145353AbRA2GOT>; Mon, 29 Jan 2001 01:14:19 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:57472
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S145323AbRA2GOJ>; Mon, 29 Jan 2001 01:14:09 -0500
Date: Sun, 28 Jan 2001 22:14:00 -0500
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200101290314.f0T3E0601647@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: zwwe@opti.cgi.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 Networking oddity
In-Reply-To: <5.0.2.1.2.20010128140720.03465e38@209.54.94.12>
In-Reply-To: <5.0.2.1.2.20010128140720.03465e38@209.54.94.12>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

>I am running a web server under the new 2.4.0 kernel and am experiencing 
>some intermittent odd behavior from the kernel.  The machine will sometimes 
>go through cycles where network response becomes slow even though top 
>reports over 60% idle CPU time.   When this is happening ping goes from 
>reasonable response times to response times of several seconds in cycles of 
>about 15 to 20 seconds.

FWIW, I have seen behaviour like this under kernel 2.2.x and 2.4.x,
for me taking the interface down and then bringing it back up usually
makes the problem stop, at least for the moment.

I have always assumed that it is caused by a bug in the Ethernet card
driver, as the first time I noticed this behaviour, I was using the
Realtek 8139 driver about two years ago, it was really not good
hardware and the driver was pretty new.  Anyway, it would do this, so
I contacted Donald Becker about it, he pointed me to a newer version
of the driver that did it _much_ less often.

Cheers,
Wayne

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
