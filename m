Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264363AbRFOL7k>; Fri, 15 Jun 2001 07:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264375AbRFOL7a>; Fri, 15 Jun 2001 07:59:30 -0400
Received: from be02.imake.com ([151.200.87.11]:26892 "EHLO be02.tfsm.com")
	by vger.kernel.org with ESMTP id <S264363AbRFOL7V>;
	Fri, 15 Jun 2001 07:59:21 -0400
Message-ID: <3B29F965.750B3DFE@247media.com>
Date: Fri, 15 Jun 2001 08:02:45 -0400
From: Russell Leighton <russell.leighton@247media.com>
X-Mailer: Mozilla 4.51 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 data corruption
In-Reply-To: <E15Abiw-00056O-00@the-village.bc.nu> <9gbdoa$cpi$1@pccross.average.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nuther anecdote:

I was creating a big swapfile on ext2 (because 2.4.5 needs too much swap)
with dd (SCSI disk on Sym53c8-something controller) and corrupted
the partition THEN fsck would cause the kernel to panic. I thought
I had some bad hw ... the box sits on my office floor waiting resurrection.

Eugene Crosser wrote:

> In article <E15Abiw-00056O-00@the-village.bc.nu>,
>         Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> >> Folks, I believe I have a reproducible test case which corrupts data in
> >> 2.4.5.
> >
> > 2.4.5 has an out of date 3ware driver that is short
>
> These days I observed massive FS curruption on vanilla 2.4.5,
> SCSI disk on Sym53c8-something controller (UW).  I did not notice
> any problems since 2.4.5 was published, they seem to have surfaced
> immediately after I created a rather big file capturing video with
> broadcast2000 (video card is bt848).  Filesystem is ext2.
>
> Eugene
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
---------------------------------------------------
Russell Leighton    russell.leighton@247media.com
---------------------------------------------------


