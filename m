Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265984AbUAEWdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265976AbUAEWcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:32:14 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:4074 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265983AbUAEWad
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:30:33 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>, wrlk@riede.org
Subject: Re: The survival of ide-scsi in 2.6.x
Date: Mon, 5 Jan 2004 23:33:26 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
References: <200401052201.i05M1her002460@harpo.it.uu.se>
In-Reply-To: <200401052201.i05M1her002460@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200401052333.26085.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 of January 2004 23:01, Mikael Pettersson wrote:
> On Mon, 29 Dec 2003 08:07:28 -0500, Willem Riede wrote:
> >> Based on my expirience with ide-tape, I would rather have it
> >> killed instead. One neat trick to appease enemies of ide-scsi
> >> might be to rename it into ide-scsi into ide-tape-bis.
> >> Might even add DSC bit handling... But the ide-tape is too
> >> ugly to live for sure.
> >
> >I would agree, but would that get any people in trouble? That is,
> >are there any IDE tape drives currently supported by ide-tape,
> >that are not compatble with ide-scsi plus st?
>
> My Seagate STT8000A works better with ide-scsi+st than with ide-tape.
> As long as a working ide-scsi is around, I couldn't care less about
> the ide-tape abomination.

>From your previous mail:
"I use ide-scsi + st for my Seagate ATAPI tape drive, so I welcome
your initiative. ide-tape has had many reliability problems in the
2.4 kernels, and the 2.5 bio changes left it broken from 2.5.12 or
so to 2.6.0-test<late>. It may have been repaired lately, but I for
one don't trust that code base any more."

So how do you know that ide-scsi+st is better? ;-)

Both ide-tape and ide-scsi are to stay in 2.6.x and die in 2.7.x.

--bart

