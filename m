Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131380AbQLPLYk>; Sat, 16 Dec 2000 06:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131626AbQLPLYa>; Sat, 16 Dec 2000 06:24:30 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:40206 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S131380AbQLPLYT>; Sat, 16 Dec 2000 06:24:19 -0500
From: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: TIOCGDEV ioctl
Date: 16 Dec 2000 10:54:06 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <91fhke$6gk$1@enterprise.cistron.net>
In-Reply-To: <20001216015537.G21372@garloff.suse.de> <Pine.LNX.4.21.0012151709591.1176-100000@euclid.oak.suse.com>
X-Trace: enterprise.cistron.net 976964046 6676 195.64.65.67 (16 Dec 2000 10:54:06 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0012151709591.1176-100000@euclid.oak.suse.com>,
James Simmons  <jsimmons@suse.com> wrote:
>Based on fgconsole.c. I just threw it together in a few minutes.
>/*
> * consolewhat.c - Prints which VC /dev/console is.
> */

You're confusing /dev/console and /dev/tty0. /dev/console might be
associated with /dev/ttyS0 or /dev/lp1

Mike.
-- 
RAND USR 16514
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
