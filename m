Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRAaNBy>; Wed, 31 Jan 2001 08:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129777AbRAaNBp>; Wed, 31 Jan 2001 08:01:45 -0500
Received: from mdmgrp1-235.accesstoledo.net ([207.43.106.235]:6148 "EHLO
	rosswinds.net") by vger.kernel.org with ESMTP id <S129561AbRAaNBg>;
	Wed, 31 Jan 2001 08:01:36 -0500
Date: Mon, 29 Jan 2001 21:14:25 -0500 (EST)
From: "Michael B. Trausch" <fd0man@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PPP broken in Kernel 2.4.1?
In-Reply-To: <Pine.LNX.4.21.0101292100520.460-100000@fd0man.accesstoledo.com>
Message-ID: <Pine.LNX.4.21.0101292113380.460-100000@fd0man.accesstoledo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Michael B. Trausch wrote:
> 
> Hi.
> 
> I'm having a weird problem with 2.4.1, and I am *not* having this problem
> with 2.4.0.  When I attempt to connect to the Internet using Kernel 2.4.1,
> I get errors about PPP something-or-another, invalid argument.  I've tried
> 

Had to do some digging, but I found the error in /var/log/syslog:

Jan 29 19:09:12 fd0man pppd[3541]: ioctl(PPPIOCGFLAGS): Invalid argument

If any other information is needed, please let me know.

	Thanks!
	Mike

===========================================================================
Michael B. Trausch                                    fd0man@crosswinds.net
Avid Linux User since April, '96!                           AIM:  ML100Smkr

              Contactable via IRC (DALNet) or AIM as ML100Smkr
===========================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
