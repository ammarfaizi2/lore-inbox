Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <156721-25206>; Mon, 22 Feb 1999 08:21:11 -0500
Received: by vger.rutgers.edu id <155898-25206>; Mon, 22 Feb 1999 08:21:03 -0500
Received: from mx02.uni-tuebingen.de ([134.2.3.12]:25184 "EHLO mx02.uni-tuebingen.de" ident: "root") by vger.rutgers.edu with ESMTP id <156773-25208>; Mon, 22 Feb 1999 08:18:53 -0500
Date: Mon, 22 Feb 1999 11:23:40 +0100
From: Harald Koenig <koenig@tat.physik.uni-tuebingen.de>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: revision control for the kernel (BitKeeper)
Message-ID: <19990222112340.B11234@turtle.tat.physik.uni-tuebingen.de>
Mail-Followup-To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.rutgers.edu
References: <199902220905.BAA01077@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <199902220905.BAA01077@bitmover.com>; from Larry McVoy on Mon, Feb 22, 1999 at 01:05:25AM -0800
X-fingerprint: 3B CD 5A A9 73 44 DD 04  A0 4E A0 34 20 7B 1E 38
Sender: owner-linux-kernel@vger.rutgers.edu

On Feb 22, Larry McVoy wrote:

> I just went and did some timings to make sure gzip is fast enough.
> I can uncompress a 1.2 MB file (from .2M -> 1.2M) in 100 milliseconds
> (aka an effective rate of 12MB/sec) on a 300Mhz K6.  Going the other
> way is slower, about 4MB/sec.  But that's reasonable, it means that a
> reasonably high end machine can keep up with the disk arm.

I know that compression ratio is important, but at least for me 
(still using a slow PODP83, and maybe may others too) CPU usage is
at least as important.  did you ever check `lzo' compression
from Markus Oberhumer <markus.oberhumer@jk.uni-linz.ac.at>
which is much faster than gzip (I'm using it for compressed backups
to keep the tape streaming rather than dripping;) which offers
in-memory compression library.  for more information have a look at

	http://wildsau.idv.uni-linz.ac.at/mfx/lzo.html


Harald
--
All SCSI disks will from now on                     ___       _____
be required to send an email notice                0--,|    /OOOOOOO\
24 hours prior to complete hardware failure!      <_/  /  /OOOOOOOOOOO\
                                                    \  \/OOOOOOOOOOOOOOO\
                                                      \ OOOOOOOOOOOOOOOOO|//
Harald Koenig,                                         \/\/\/\/\/\/\/\/\/
Inst.f.Theoret.Astrophysik                              //  /     \\  \
koenig@tat.physik.uni-tuebingen.de                     ^^^^^       ^^^^^

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
