Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280967AbRKLUW3>; Mon, 12 Nov 2001 15:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280968AbRKLUWU>; Mon, 12 Nov 2001 15:22:20 -0500
Received: from [213.235.52.105] ([213.235.52.105]:54535 "EHLO
	morpheus.streamgroup.co.uk") by vger.kernel.org with ESMTP
	id <S280967AbRKLUWA>; Mon, 12 Nov 2001 15:22:00 -0500
Date: Mon, 12 Nov 2001 22:22:38 +0000 (GMT)
From: "mike@morpheus" <mike@morpheus.streamgroup.co.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Frank de Lange <lkml-frank@unternet.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Abysmal interactive performance on 2.4.linus
In-Reply-To: <3BF02BA4.D7E2D70E@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0111122221340.24139-100000@morpheus.streamgroup.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have tried both 2.4.13ac6 and 2.4.15-pre2, and am getting
the same behaviour in 2.4.15-pre2, but not in the ac kernel.

mike


--

My Operat~1 System supports long filena~1, does yours?

On Mon, 12 Nov 2001, Jeff Garzik wrote:

> Frank de Lange wrote:
> >
> > On a 768 MB SMP box (2x466 MHz Celeron), I see some weird problems with
> > interactive performance on 2.4.15pre{1,2}. A good example of this is the
> > following scenario:
> >
> >  - copy a large file (eg. an iso image file) to a directory on the same
> >    (reiserfs in this case) filesystem, or...
> >  - do a filesystem comparison between a CD and the original file (with cmp
> >    /mnt/cdrom/<filename> /mnt/reiserfs/1/data/<original_file_location>, using a
> >    PLEXTOR Model: CD-ROM PX-40TS SCSI CD-ROM drive),
> >
> >  - and THEN (while the copy or comparison runs) try any simple command (like
> >    'ls /mnt/reiserfs/1/data' or 'top' or anything else...).
> >
> > Response time is abysmal, a simple 'ls /some/dir' takes tens of seconds to
> > start. Once the command is running, performance is normal. Try this when a
> > cdrecord session is running and you'll get a buffer underrun.
>
> Can you try 2.4.13ac6 (not 7/8), and 2.2.20, and post a comparison?
>
> --
> Jeff Garzik      | Only so many songs can be sung
> Building 1024    | with two lips, two lungs, and one tongue.
> MandrakeSoft     |         - nomeansno
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

