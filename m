Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262278AbRERIcE>; Fri, 18 May 2001 04:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262279AbRERIb5>; Fri, 18 May 2001 04:31:57 -0400
Received: from ucu-105-116.ucu.uu.nl ([131.211.105.116]:44476 "EHLO
	ronald.bitfreak.net") by vger.kernel.org with ESMTP
	id <S262278AbRERIbm>; Fri, 18 May 2001 04:31:42 -0400
Subject: Re: Linux scalability?
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: "reiser.angus" <reiser.angus@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <990173560.6346.0.camel@adslgw>
In-Reply-To: <Pine.LNX.4.33.0105180914560.29042-100000@iq.rulez.org> 
	<990173560.6346.0.camel@adslgw>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 18 May 2001 10:30:58 +0200
Message-Id: <990174686.12881.18.camel@tux.bitfreak.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 May 2001 10:12:34 +0200, reiser.angus wrote:
> > However, taking a closer look, it turns out, that the above statement
> > holds true only for 1 and 2 processor machines. Scalability already
> > suffers at 4 processors, and at 8 processors, TUX 2.0 (7500) gets beaten
> > by IIS 5.0 (8001), and these were measured on the same kind of box!
> not really the same box
> look at the disk subsystem
> 7 x 9GB 10KRPM Drives and 1 x 18GB 15KRPM (html+log & os) for Win2000
> 5 x 9GB 10KRPM Drives (html+log+os) for TUX 2.0
> 
> this is sufficient for a such difference

I read an article about TUX in the dutch C'T a few months ago (nov/dec
2000, I think) - the real difference (according to the article) was the
2.2.x kernel used in TUX. Look at the stats of the website, they used
Redhat 7.0 as base, with kernel 2.2.16. In the C'T, they also used a
2.4-test kernel for TUX, and this one didn't have these "scalibility
problems". The problem seemed to be SMP problems with systems with more
than two cpus in the 2.2.x-based kernel series. 2.4.x kernels didn't
seem to have this problem.

And as far as I know, TUX with 2.4.x kernel was faster than win2k on all
SMP-combinations.

--
Ronald

