Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbQL1Cpo>; Wed, 27 Dec 2000 21:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130460AbQL1Cpe>; Wed, 27 Dec 2000 21:45:34 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:31717 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129736AbQL1CpQ>; Wed, 27 Dec 2000 21:45:16 -0500
Date: Wed, 27 Dec 2000 21:15:24 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 dies on my 486..
In-Reply-To: <200012280113.eBS1DUD00873@webber.adilger.net>
Message-ID: <Pine.LNX.4.31.0012272111330.802-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Dec 2000, Andreas Dilger wrote:

>Mike Harris writes:
>> I just upgraded my 486 firewall's kernel to pure 2.2.18 from
>> 2.2.17, with no other changes, and now it dies with all sorts
>> of hard disk failures.
>>
>> I get:
>>
>> hdb: lost interrupt
>>
>> And stuff about DRQ lost...
>
>Is it possible you compiled the kernel with gcc 2.95.2?  I've been having
>a similar problem, but I'm having trouble tracking it down.

Absolutely not possible.  ;o)  Compiled with kgcc on Red Hat 7
(egcs 2.91.66).  I've been building kernels with egcs since Red
Hat 5.0 was released, no problems.

I've never used gcc 2.95.x at all, so I can't comment on it at
all..

It seems my hard disk may be failing...


>Because I normally use a very heavily modified 2.2.18 kernel,
>I'm trying to isolate just where the problem is - I have no
>problems with a stock 2.2.18 kernel. If I compile with gcc
>2.7.2.3 it works fine.

Hmm.. must be a different problem than I'm having.  I've tracked
my problem down to disk accesses to hdb.  hda/hdc work fine, as
does the machine sitting idling doing its job.  If I do a copy
from hdb to hdc it explodes.  Very odd..  ;o(


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------


[Quote: Linus Torvalds - Aug 27, 2000 - linux-kernel mailing list]
"And I'm right.  I'm always right, but in this case I'm just a bit more
right than I usually am." -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
