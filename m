Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282064AbRLOJyH>; Sat, 15 Dec 2001 04:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282067AbRLOJx6>; Sat, 15 Dec 2001 04:53:58 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:31008 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S282064AbRLOJxr> convert rfc822-to-8bit; Sat, 15 Dec 2001 04:53:47 -0500
Date: Sat, 15 Dec 2001 07:57:28 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Peter Bornemann <eduard.epi@t-online.de>
cc: Jens Axboe <axboe@suse.de>, Kirk Alexander <kirkalx@yahoo.co.nz>,
        <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <Pine.LNX.4.33.0112150136390.5849-100000@eduard.t-online.de>
Message-ID: <20011215073941.J645-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 Dec 2001, Peter Bornemann wrote:

> On Fri, 14 Dec 2001, [ISO-8859-1] Gérard Roudier wrote:
>
> >
> >
> > On Fri, 14 Dec 2001, Peter Bornemann wrote:
> > > Ahemm -- well,
> > > maybe I'm the first one. I have a symbios card, which is recognized by
> > > lspci:  SCSI storage controller: LSI Logic Corp. / Symbios Logic Inc.
> > > (formerly NCR) 53c810 (rev 23).
> > Could you, please,  report me more accurate information.
> > TIA,
> >
>
> Well, it seems I made my intention not very clear: I do not want You to
> fix something in the driver, I just wanted from You to leave the old
> ncr-driver in the kernel, just for the situation of a first install. I
> think no newbie with little knowledge will be able to install Linux (or,
> maybe, FreeBSD), when he happens to own such an controller. First, he
> won't be able to read very much on the screen, for the loop runs much too
> fast and second, he will not understand when he reads something about a
> sym53c8xx. Exactly for this case I think the old driver should be left in.
> If You want, You can tell him "Attention! Use of this driver deprecated.
> Contact Your support." or whatever seems appropriate. It is just about the
> first step to linuxland :-)
>
> Hope I managed to make myself clear tris time

I have limited time and am very bad in politics. I do prefer to have to
deal with accurate technical issues. My english is also limited to this
field.

You would have been clear if you had reported:

1) Which of the mpar= spar= and/or corresponding compiled-in options made
   your broken hardware works (with high risks of silent corruption).

2) If using the corresponding compiled-in option worked with sym-2.

3) Optionnaly, relevant messages printed by sym-2, even taken by hand,
   when the problem occurs.

+ any other pertinent information I cannot guess about you thought can
  help.

About FreeBSD, the only information I have is that the (sad) work-around I
implemented and that is incorporated in sym-2 _did_ work around the
problem of PCI parity error for people that did report results.

Could you be clear, as expected by technical group of discussions, please.

  Gérard.

PS: The ncr53c8xx may just work since it does trust POST software to
    enable PCI parity checking bit in PCI config space. But it seems that
    most POST shits donnot do so, leaving systems with the risk of silent
    data corruption in contradiction with either PCI specifications and user
    expectation.

