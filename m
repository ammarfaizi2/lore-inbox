Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130131AbQLJDPU>; Sat, 9 Dec 2000 22:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130647AbQLJDPK>; Sat, 9 Dec 2000 22:15:10 -0500
Received: from peterb.dsl.telerama.com ([205.201.10.76]:14597 "EHLO
	peterb.dsl.telerama.com") by vger.kernel.org with ESMTP
	id <S130131AbQLJDPG>; Sat, 9 Dec 2000 22:15:06 -0500
Message-ID: <000f01c06253$3ba12cc0$a600000a@toucan>
From: "Peter Berger" <peterb@telerama.com>
To: "Kevin Buhr" <buhr@stat.wisc.edu>
Cc: <linux-kernel@vger.kernel.org>, "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
In-Reply-To: <Pine.BSI.4.02.10012081150130.17198-100000@frogger.telerama.com> <vbasnny3xy9.fsf@mozart.stat.wisc.edu>
Subject: Re: Pthreads, linux, gdb, oh my! (fwd)
Date: Sat, 9 Dec 2000 10:15:08 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

.

> It looks like a GDB bug.  GDB contains code to recognize when the
> "pthreads" shared library has been loaded.  When this happens, it sets
> itself up to properly handle threads (including setting up correct
> SIG32 signal handling).  If you trick GDB into thinking "pthreads"
> hasn't been loaded and set the SIG32 stuff up yourself, like so:
[elided]

Kevin,

This sure looks like it -- I was able to get it working using your
technique.  Thank you!  It is a relief to know that this was just an
application layer issue rather than something deeper.

My apologies for soaking up cycles on linux-kernel for what turned out to be
a non-kernel issue -- but a big THANKS to everyone that helped track the
problem down -- let me know the next time you're in Pittsburgh, and I'll buy
you a beer (or the beverage of your choice).

-p


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
