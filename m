Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278170AbRJLWJb>; Fri, 12 Oct 2001 18:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278171AbRJLWJU>; Fri, 12 Oct 2001 18:09:20 -0400
Received: from mel-rti21.wanadoo.fr ([193.252.19.94]:12504 "EHLO
	mel-rti21.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S278170AbRJLWJG>; Fri, 12 Oct 2001 18:09:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: xine pauses with recent (not -ac) kernels
Date: Sat, 13 Oct 2001 00:08:56 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01101208552800.00838@baldrick> <20011012161052.R714@athlon.random>
In-Reply-To: <20011012161052.R714@athlon.random>
MIME-Version: 1.0
Message-Id: <01101300085600.00832@baldrick>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 October 2001  4:10 pm, Andrea Arcangeli wrote:
> On Fri, Oct 12, 2001 at 08:55:28AM +0200, Duncan Sands wrote:
> > Subject: xine pauses with recent (not -ac) kernels
> >
> > Problem: using xine to view an (encrypted) DVD, xine is slow to move
> > on to the second .vob file: at the end of the first file, it at best
> > waits a few seconds with a black screen and consuming no CPU, before
> > moving on to the second file, but sometimes it waits for a long time.
> >
> > Correct behaviour: the second .vob file starts playing at once.
> >
> > I think this is a kernel problem because it did not occur up to
> > 2.4.9.  The problem appeared between 2.4.10-pre10 and 2.4.10-pre13.
> > It is present in 2.4.12.  It doesn't seem to occur in any -ac kernels.
> >
> > linux-2.4.9 : correct
> > ...
> > linux-2.4.10-pre10 : correct
> > linux-2.4.10-pre11 : fails to compile
> > linux-2.4.10-pre12 : oops during system init
> > linux-2.4.10-pre13 : problem present
> > ...
> > linux-2.4.12 : problem present
> >
> > If I replay the DVD several times, the length of the pause varies, and
> > sometimes it does not occur at all.
> >
> > Any ideas?
>
> can you reproduce also on 2.4.12aa1?
>
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.12
>aa1.bz2
>
> Andrea

Yes, it seems to have the same problem.  It even seems a bit worse
(just my impression, I didn't do any statistics).

Duncan.
