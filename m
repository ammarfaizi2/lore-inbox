Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280708AbRKGAVN>; Tue, 6 Nov 2001 19:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280713AbRKGAVE>; Tue, 6 Nov 2001 19:21:04 -0500
Received: from [209.195.52.30] ([209.195.52.30]:18199 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S280708AbRKGAU4>;
	Tue, 6 Nov 2001 19:20:56 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: imran.badr@cavium.com, linux-kernel@vger.kernel.org
Date: Tue, 6 Nov 2001 15:56:55 -0800 (PST)
Subject: Re: Linux kernel 2.4 and TCP terminations per second.
In-Reply-To: <E161FY0-0002AE-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0111061555210.24952-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from a recent test I just was running with apache on a 1.2GHZ athlon 512MB
ram it looks like it will do ~1800 connections/sec.

just to put the numbers below in perspective :-)

David Lang

On Tue, 6 Nov 2001, Alan Cox wrote:

> > Does anybody know , what is the maximum number of TCP (http)
> > terminations/per second a server (single/dual/.. processor)  in todays
> > market can do, without much CPU load. The server would be running linux
> > kernel 2.4 and apache web server.
>
> If you are running any kind of high performance connections/second load then
> you dont run apache. That isnt what apache is good at
>
> thttpd will do 2000/sec on a decent box. zeus (non free) more, and tux
> (kernel http accelerator) holds some records
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
