Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129660AbRB0RaA>; Tue, 27 Feb 2001 12:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129661AbRB0R3v>; Tue, 27 Feb 2001 12:29:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33551 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129660AbRB0R3m>; Tue, 27 Feb 2001 12:29:42 -0500
Subject: Re: i2o & Promise SuperTrak100
To: david2@maincube.net (David Priban)
Date: Tue, 27 Feb 2001 17:32:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <MPBBILLJAONHMANIJOPDIEBIFMAA.david2@maincube.net> from "David Priban" at Feb 27, 2001 12:14:14 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Xnz8-0003rQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> c029072a
> Call Trace:
> [<c01b33fe>] [<c01b349c>] [<c01b308f>] [<c01b4774>]
> [<c01b47a6>] [<c011b0fe>] [<c011b4bf>] [<c018969d>]
> [<c0189731>] [<c018918e>] [<c018a12d>] [<c018a19f>]
> [<c0109f6d>] [<c010a0ce>] [<c0107120>] [<c0107120>]
> [<c0108e00>] [<c0107120>] [<c0107120>] [<c0100018>]
> [<c0107143>] [<c01071a9>] [<c0105000>] [<c0100191>]
> Code:
> 0f 0b 8d 65 dc 5b 5e 5f 89 ec 5d c3 55 89 e5 83 ec 10 57 56
> Kernel panic: Aiee, killing interrupt handler !
> In interrupt handler - not syncing

Run it through ksymoops and I might be able to guess what went wrong.

In theory however i2o is a standard and all i2o works alike. In practice i2o
is a pseudo standard and nobody seems to interpret the spec the same way, the
implementations all tend to have bugs and the hardware sometimes does too.

