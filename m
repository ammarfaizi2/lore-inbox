Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153893AbPGJBTs>; Fri, 9 Jul 1999 21:19:48 -0400
Received: by vger.rutgers.edu id <S153849AbPGJBTb>; Fri, 9 Jul 1999 21:19:31 -0400
Received: from stm.lbl.gov ([131.243.16.51]:3013 "EHLO stm.lbl.gov") by vger.rutgers.edu with ESMTP id <S153864AbPGJBRi>; Fri, 9 Jul 1999 21:17:38 -0400
Date: Fri, 9 Jul 1999 18:17:25 -0700
From: David Schleef <ds@stm.lbl.gov>
To: Dale Amon <amon@vnl.com>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: Linux and real time process control (Can't sleep less than 20ms)
Message-ID: <19990709181725.A3577@stm.lbl.gov>
References: <19990709202830Z154016-4163+689@vger.rutgers.edu> <Pine.LNX.3.96.990710010050.25053F-100000@angusbay.vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.3.96.990710010050.25053F-100000@angusbay.vnl.com>; from Dale Amon on Sat, Jul 10, 1999 at 01:25:27AM +0100
Sender: owner-linux-kernel@vger.rutgers.edu

On Sat, Jul 10, 1999 at 01:25:27AM +0100, Dale Amon wrote:
> First, I spent nearly 10 years doing 
> real time process control type things.
> We never used Unix because it lacked the ability
> to accurately control time-based events where
> you simply could NOT get things out of sequence or
> have two events execute at other than a correct
> time +/- some delta. Mostly I was not dealing
> with life and death... mostly.

Look at either POSIX real-time extensions (man
sched_setscheduler()), or if that is not good
enough, use RTLinux, a hard real-time extension
to Linux.  (www.rtlinux.org)  People routinely
report performance that can only be envied by other
OS's.



dave...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
