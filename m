Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbRATURW>; Sat, 20 Jan 2001 15:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130271AbRATURM>; Sat, 20 Jan 2001 15:17:12 -0500
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:12420 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129780AbRATURG>; Sat, 20 Jan 2001 15:17:06 -0500
Message-ID: <3A69F220.B16F2B1C@Home.net>
Date: Sat, 20 Jan 2001 15:16:32 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Gregory Maxwell <greg@linuxpower.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.x and 2.4.1-preX - Higher latency then 2.2.x kernels?
In-Reply-To: <3A69EBF8.B35A3B80@Home.net> <20010120145924.A22169@xi.linuxpower.cx>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where can i get the patch?

I can apply it right now.

Gregory Maxwell wrote:

> On Sat, Jan 20, 2001 at 02:50:16PM -0500, Shawn Starr wrote:
> > It just seems that since using 2.4 ive noticed my poor Pentium 200Mhz
> > slow down whether being in X or otherwise. It just seems that the system
> > is sluggish.
> >
> > I am using the new ReiserFS filesystem and I do know its still in heavy
> > development perhaps my latency is due to this (?)
>
> Reiserfs uses much more complex data structures then ext2 (trees..). I don't
> think that latency has ever been a design criteria and all of the benchmarks
> they use are pretty much pure throughput tests.
>
> So it wouldn't be really surprising if reiserfs had very bad latency. You
> should apply the timepegs patch and profile your kernel latency to see where
> it's coming from.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
