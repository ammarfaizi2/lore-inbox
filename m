Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131033AbRATSmk>; Sat, 20 Jan 2001 13:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131461AbRATSm3>; Sat, 20 Jan 2001 13:42:29 -0500
Received: from dwdmx2.dwd.de ([141.38.2.10]:45324 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id <S131033AbRATSmS>;
	Sat, 20 Jan 2001 13:42:18 -0500
Date: Sat, 20 Jan 2001 19:42:04 +0100 (CET)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: Otto Meier <gf435@gmx.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "neilb@cse.unsw.edu.au" <neilb@cse.unsw.edu.au>
Subject: Re: Serious file system corruption with RAID5+SMP and kernels above2.4.0
Message-Id: <Pine.LNX.4.30.0101201930500.16941-100000@talentix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2001, Otto Meier wrote:

> Two days ago I tried new kernels on my SMP SW RAID5 System
> and expirienced serous file system corruption with kernels 2.4.1-pre8,9 as 2.4.0-ac8,9,10.
> The same error has been reported by other people on this list. With 2.4.0 release
> everything runs fine. So I backsteped to it and had no error since.
>
I just tried 2.4.0 and still get filesystem corruption. My system is
also SMP and SW Raid5. So far I have tried 2.4.0, 2.4.1-pre3,8 and
2.4.0-ac10 and all corrupt my filesystem. 2.2.18 is ok.

With the help of Manfred Spraul I can now reproduce this problem
within 10 minutes.

Holger

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
