Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275003AbRJQHhJ>; Wed, 17 Oct 2001 03:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274990AbRJQHg7>; Wed, 17 Oct 2001 03:36:59 -0400
Received: from mail.science.uva.nl ([146.50.4.51]:56270 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S274872AbRJQHgv>; Wed, 17 Oct 2001 03:36:51 -0400
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Date: Wed, 17 Oct 2001 09:36:04 +0200 (CEST)
From: Kamil Iskra <kamil@science.uva.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Poor floppy performance in kernel 2.4.10
Message-ID: <Pine.LNX.4.33.0110170926050.3761-100000@krakow.science.uva.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Since kernel 2.4.10, I observe a rather poor performance of the good old
floppy drive.  It used to work find in kernel 2.4.9.  Kernel 2.4.10 broke
it, and 2.4.12 did not fix it.  I access my floppy using mtools-3.9.7-4 as
found in RH 7.1.

Not knowing anything about the kernel internals, I would say that the
floppy driver does not do any caching anymore.  With kernel 2.4.9, "mdir"
of a standard 1.44 MB, completely empty floppy disk takes about 1 second
for the first invocation, and next to nothing for the subsequent ones.
>From 2.4.10 on, it takes over 2 seconds every time.  Writing a 30 KB file
with 2.4.9 takes below 3 seconds, with >=2.4.10 it's over 6 seconds.

Maybe I should just keep quiet and be happy that it works at all, after
all floppies are rarely used nowadays, but letting such a performance
degradation go unreported is just beyond me :-).

Regards,

-- 
Kamil Iskra                 http://www.science.uva.nl/~kamil/
Section Computational Science, Faculty of Science, Universiteit van Amsterdam
kamil@science.uva.nl  tel. +31 20 525 75 35  fax. +31 20 525 74 90
Kruislaan 403  room F.202  1098 SJ Amsterdam  The Netherlands

