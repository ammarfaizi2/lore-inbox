Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbTF1HTb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 03:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265090AbTF1HTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 03:19:31 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:12183 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S265089AbTF1HTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 03:19:30 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Joshua Penix <jpenix@binarytribe.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sat, 28 Jun 2003 00:33:31 -0700 (PDT)
Subject: Re: bkbits.net is down
In-Reply-To: <1056773286.10255.5.camel@granite>
Message-ID: <Pine.LNX.4.44.0306280031560.2345-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LTO drives are probably a lot more expensive then the entire computers he
is useing as a backup (one source listed the individual drives at ~$10K,
I'll bet Larry's backup systems are under $5K probably under 3K)

David Lang

 On 27 Jun
2003, Joshua Penix wrote:

> Date: 27 Jun 2003 21:08:06 -0700
> From: Joshua Penix <jpenix@binarytribe.com>
> To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: bkbits.net is down
>
> On Fri, 2003-06-27 at 20:19, Larry McVoy wrote:
> > On Fri, Jun 27, 2003 at 08:51:40PM -0400, Scott McDermott wrote:
> > > Larry McVoy on Fri 27/06 17:16 -0700:
> > > > I don't know if you all realize this but at one point we
> > > > had corrupted data in several repositories and the backups
> > > > were also shot.
> > >
> > > ever hear of tapes?
> >
> > bkbits is 45GB of data and growing.  Tapes are completely impractical,
> > that's why we have hot spares.
>
> Boy you do need a good admin :)  Done correctly, tapes are quite
> practical for that amount of data.  A LTO or SDLT drive would back the
> entire 45GB thing up on a single tape, with room for at least one to two
> more full backups.  Granted, you're not going to have tape act as your
> hot backup, but it is a good third line of defense.  Plus data backed up
> to tape is immune from human or software error that may otherwise affect
> the hard-drive based data.
>
> 45GB of code is very compressible and I'm sure good chunks of that don't
> change on a weekly basis.  I'd imagine you could get a weekly or
> bi-weekly full backup to tape in the span of about two hours, and then
> do nightly differentials which would probably be only 15 minutes in
> length.  A filesystem capable of doing snapshots would ensure
> consistency of the repositories on tape and would prevent you from
> having to shutdown bkbits while backing up.
>
> --Josh
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
