Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130307AbRAUX0G>; Sun, 21 Jan 2001 18:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131004AbRAUXZ5>; Sun, 21 Jan 2001 18:25:57 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:35307 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S130307AbRAUXZp>; Sun, 21 Jan 2001 18:25:45 -0500
Message-ID: <3A6B6FDE.93AF69CC@Home.net>
Date: Sun, 21 Jan 2001 18:25:18 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.x and 2.4.1-preX - Higher latency then 2.2.xkernels?
In-Reply-To: <186870000.980100593@tiny>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, but Im not sure what to test ;)
If you've got any special patches for 2.4 lemme know and I'll apply them I've
got all night heh

Shawn.

Chris Mason wrote:

> On Saturday, January 20, 2001 02:59:24 PM -0500 Gregory Maxwell
> <greg@linuxpower.cx> wrote:
>
> > On Sat, Jan 20, 2001 at 02:50:16PM -0500, Shawn Starr wrote:
> >> It just seems that since using 2.4 ive noticed my poor Pentium 200Mhz
> >> slow down whether being in X or otherwise. It just seems that the system
> >> is sluggish.
> >>
> >> I am using the new ReiserFS filesystem and I do know its still in heavy
> >> development perhaps my latency is due to this (?)
> >
> > Reiserfs uses much more complex data structures then ext2 (trees..). I
> > don't think that latency has ever been a design criteria and all of the
> > benchmarks they use are pretty much pure throughput tests.
> >
> > So it wouldn't be really surprising if reiserfs had very bad latency. You
> > should apply the timepegs patch and profile your kernel latency to see
> > where it's coming from.
>
> I'm actually very interested in fixing any latency problems.  If you do
> these tests, please send the results along.
>
> -chris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
