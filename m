Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S.rHlVT160432>; Fri, 28 May 1999 18:27:43 -0400
Received: by vger.rutgers.edu id <S.rHhHm154073>; Fri, 28 May 1999 13:40:02 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:17899 "EHLO deliverator.sgi.com") by vger.rutgers.edu with ESMTP id <S.rHNe.169006>; Thu, 27 May 1999 15:18:24 -0400
Message-ID: <374D98F4.CF01D27C@engr.sgi.com>
Date: Thu, 27 May 1999 12:11:48 -0700
From: Dan Koren <dkoren@cthulhu.engr.sgi.com>
Reply-To: Dan.Koren@sgi.com
Organization: Silicon Graphics Computer Systems
X-Mailer: Mozilla 4.51C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: mcai7et2@stud.umist.ac.uk, linux-kernel@vger.rutgers.edu
Subject: Re: XFS and journalling filesystems
References: <E10m0gq-0000pk-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Alan Cox wrote:
> 
> > journalling filesystem will be opensourced this summer) what is "the
> > panel's" view of the continuing devlopment of ext3/whatever the linux
> > jfs will be called. Should we adopt XFS as the defacto replacement for
> > ext2?
> 
> XFS is 50,000 odd lines of mainframe class filing system code.

You're understimating it... :)

> Its unlikely to be the ideal fs for a small appliance or a
> desktop at home even if it kicks butt as a server fs.
> 
> Alan

Quite the contrary. The fewer disk spindles on a system, the
greater the performance gains from XFS' very sophisticated
i/o scheduling. In addition, XFS code is layered neatly
enough that unwanted features/options can be left out if
one so wants.

thx,


Dan Koren                                        Dan.Koren@sgi.com
Engineering Manager, File Systems        phone: (USA) 650-933-3678
Silicon Graphics, Inc.                   pager: (USA) 888-769-0874
1600 Amphiteatre Pkwy. M/S 08U-500       or dkoren_p@pager.sgi.com
Mountain View, CA 94043-1351               fax: (USA) 650-933-3542

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
