Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131539AbRATSvP>; Sat, 20 Jan 2001 13:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131721AbRATSvE>; Sat, 20 Jan 2001 13:51:04 -0500
Received: from mx1out.umbc.edu ([130.85.253.51]:63627 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S131461AbRATSus>;
	Sat, 20 Jan 2001 13:50:48 -0500
Date: Sat, 20 Jan 2001 13:50:40 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
cc: Otto Meier <gf435@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "neilb@cse.unsw.edu.au" <neilb@cse.unsw.edu.au>
Subject: Re: Serious file system corruption with RAID5+SMP and kernels
 above2.4.0
In-Reply-To: <Pine.LNX.4.30.0101201930500.16941-100000@talentix.dwd.de>
Message-ID: <Pine.SGI.4.31L.02.0101201349560.1762158-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't even get RAID5 to assemble thew md devices under 2.4.0 and
2.4.1-pre7.


On Sat, 20 Jan 2001, Holger Kiehl wrote:

> Date: Sat, 20 Jan 2001 19:42:04 +0100 (CET)
> From: Holger Kiehl <Holger.Kiehl@dwd.de>
> To: Otto Meier <gf435@gmx.net>
> Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
>      "neilb@cse.unsw.edu.au" <neilb@cse.unsw.edu.au>
> Subject: Re: Serious file system corruption with RAID5+SMP and kernels
>     above2.4.0
>
> On Sat, 20 Jan 2001, Otto Meier wrote:
>
> > Two days ago I tried new kernels on my SMP SW RAID5 System
> > and expirienced serous file system corruption with kernels 2.4.1-pre8,9 as 2.4.0-ac8,9,10.
> > The same error has been reported by other people on this list. With 2.4.0 release
> > everything runs fine. So I backsteped to it and had no error since.
> >
> I just tried 2.4.0 and still get filesystem corruption. My system is
> also SMP and SW Raid5. So far I have tried 2.4.0, 2.4.1-pre3,8 and
> 2.4.0-ac10 and all corrupt my filesystem. 2.2.18 is ok.
>
> With the help of Manfred Spraul I can now reproduce this problem
> within 10 minutes.
>
> Holger
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-- 
--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
