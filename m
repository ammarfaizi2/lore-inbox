Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135220AbRAFV5P>; Sat, 6 Jan 2001 16:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135217AbRAFV44>; Sat, 6 Jan 2001 16:56:56 -0500
Received: from hera.cwi.nl ([192.16.191.1]:20722 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S135209AbRAFV4e>;
	Sat, 6 Jan 2001 16:56:34 -0500
Date: Sat, 6 Jan 2001 22:56:30 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101062156.WAA145870.aeb@texel.cwi.nl>
To: Andries.Brouwer@cwi.nl, BJerrick@easystreet.com,
        linux-kernel@vger.kernel.org, p_gortmaker@yahoo.com
Subject: Re: 500 ms offset in i386 Real Time Clock setting
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Neither hwclock nor the /dev/rtc driver takes the following comment from
> set_rtc_mmss() in arch/i386/kernel/time.c into account.
> As a result, using hwclock --systohc or --adjust always leaves the
> Hardware Clock 500 ms ahead of the System Clock

By pure coincidence Q@ping.be sent me patches just one day ago.
I still have to look at the details, but it seems very likely
that this will be corrected in the next util-linux release.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
