Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153867AbPFAJJa>; Tue, 1 Jun 1999 05:09:30 -0400
Received: by vger.rutgers.edu id <S153851AbPFAJJN>; Tue, 1 Jun 1999 05:09:13 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:18228 "EHLO sgi.com") by vger.rutgers.edu with ESMTP id <S153863AbPFAJI6>; Tue, 1 Jun 1999 05:08:58 -0400
Message-ID: <3753B2AC.4C832DAC@engr.sgi.com>
Date: Tue, 01 Jun 1999 03:15:08 -0700
From: Dan Koren <dkoren@cthulhu.engr.sgi.com>
Reply-To: Dan.Koren@sgi.com
Organization: Silicon Graphics Computer Systems
X-Mailer: Mozilla 4.51C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: sam.vilain@nz.unisys.com, mostek@sgi.com, linux-kernel@vger.rutgers.edu
Subject: Re: XFS and journalling filesystems
References: <76D8782817C5D211A37400104B0C84B029C52F@nz-wlg-exch-1.nz.unisys.com> <3753A4A5.C2A4FE91@engr.sgi.com> <199906010928.CAA04308@pizda.davem.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

"David S. Miller" wrote:
> 
>    Date:        Tue, 01 Jun 1999 02:15:17 -0700
>    From: Dan Koren <dkoren@cthulhu.engr.sgi.com>
> 
>    I'm afraid your concerns about kernel code size eating into buffer
>    cache or user memory are slightly out of date. These days it seems
>    damn near impossible to buy anything with less than 32 MB memory!
> 
> There are third world countries where Linux is used heavily where a
> 486 with 16MB of ram is a "big computer".  These concerns are by no
> means out of date at all.

Even at 16 MB the extra 100 kB or so taken by XFS will have no
visible effect on the system's performance. On the other hand the
performance, and more important the reliability, gained by using
XFS will make a very big difference.

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
