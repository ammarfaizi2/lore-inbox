Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129913AbRAFOzf>; Sat, 6 Jan 2001 09:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbRAFOzZ>; Sat, 6 Jan 2001 09:55:25 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:30555 "EHLO
	amsmta04-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129913AbRAFOzO>; Sat, 6 Jan 2001 09:55:14 -0500
Date: Sat, 6 Jan 2001 17:02:17 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
In-Reply-To: <20010106124204.E1334@emma1.emma.line.org>
Message-ID: <Pine.LNX.4.21.0101061658420.7042-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Sven, how did you kill the clipping ??
> > Or in generic, how do I kill the clipping ?
> 
> Go set the jumpers right. (anyhow, IBM drives are delivered unclipped,
> not sure why Maxtors seem to be)

It's not that simple.. The maxtor comes clipped,. but Linux can't kill the
clip. So it sticks with 32 MB

ibmsetmax.c does a software clip, but that bugs a bit. Sometimes even
Linux doesn't see 61 GB, but only 32, sometimes the full capacity.
(i'm talking without the hardware jumper).

the machine I used to set the limit (target machine doesn't but without
the hardware clip), seems to reset the software clip. Probably the BIOS
who does that.

It seems stable now, machine boots OK, and Linux sees 61GB. Let's hope it
will stay that way.


	Regards,

		Igmar



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
