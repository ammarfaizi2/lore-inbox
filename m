Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135659AbREIVa6>; Wed, 9 May 2001 17:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135655AbREIVat>; Wed, 9 May 2001 17:30:49 -0400
Received: from idiom.com ([216.240.32.1]:13327 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S135636AbREIVah>;
	Wed, 9 May 2001 17:30:37 -0400
Message-ID: <3AF9546C.4B45FDA7@namesys.com>
Date: Wed, 09 May 2001 07:30:04 -0700
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14cl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        " =?iso-8859-1?Q?Mart=EDn=20Marqu=E9s?=" <martin@bugs.unl.edu.ar>,
        linux-kernel@vger.kernel.org, yura@namesys.com
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <200105092125.f49LPew13300@jen.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:

> >
> > XFS is very fast most of the time (deleting a file is sooooo slow its like us
> > ing
> > old BSD systems). Im not familiar enough with its behaviour under Linux yet.
>
> Hmm, I just removed 2.2 Gbytes of data in 30000 files in 37 seconds (14.4
> seconds system time), not tooo slow. And that is on a pretty vanilla 2 cpu
> linux box with a not very exciting scsi drive.
>
> >
> > What you might want to do is to make a partition for 'mystery journalling fs'
> > and benchmark a bit.
> >
> > Alan
> >
>
> I agree with Alan here, the only sure fire way to find out which filesystem
> will work best for your application is to try it out. I have found reiserfs
> to be very fast in some tests, especially those operating on lots of small
> files, but contrary to some peoples, belief XFS is good for a lot more than
> just messing with Gbyte long data files.
>
> Steve Lord
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

XFS used to have the performance problems that Alan described but fixed them in
the linux port, yes?

Hans

