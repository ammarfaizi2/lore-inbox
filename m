Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129215AbQKDU6w>; Sat, 4 Nov 2000 15:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129093AbQKDU6n>; Sat, 4 Nov 2000 15:58:43 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:48142 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129057AbQKDU62>; Sat, 4 Nov 2000 15:58:28 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14852.30826.706592.165270@wire.cadcamlab.org>
Date: Sat, 4 Nov 2000 14:58:18 -0600 (CST)
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: asm/resource.h
In-Reply-To: <3A032C1D.D50C8D46@transmeta.com>
	<3A032E4E.A08DC0EB@timpanogas.org>
	<20001103203336.L1041@wire.cadcamlab.org>
	<20001104143703.A14407@vger.timpanogas.org>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jeff V. Merkey <jmerkey@vger.timpanogas.org>]
> I got a little further with the lock up problem, and it is related to
> MPS reporting a 2nd processor being present in some PPro systems when
> in fact only one CPU is really installed (but MPS is reporting
> default table entry 6 with a second CPU as present).

Wow, that's a lousy BIOS.  You mean it actually *can't tell* if there's
a CPU in the second socket or not?

I remember a couple years ago Linus remarked that *every time* Linux
tried to rely on a BIOS feature, there'd be at least one bug report
traceable to a buggy BIOS somewhere.  Proven once again.... (:

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
