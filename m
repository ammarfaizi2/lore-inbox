Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129797AbQLHDBR>; Thu, 7 Dec 2000 22:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129967AbQLHDBH>; Thu, 7 Dec 2000 22:01:07 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:13517 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S129797AbQLHDAx>; Thu, 7 Dec 2000 22:00:53 -0500
Date: Fri, 8 Dec 2000 02:28:49 +0000 (GMT)
From: davej@suse.de
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: Rainer Mager <rmager@vgkk.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11
In-Reply-To: <3A303852.790E3CE4@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0012080217400.12383-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Jeff V. Merkey wrote:

> It's related to some change in 2.4 vs. 2.2.  There are other programs
> affected other than X, SSH also get's spurious signal 11's now and again
> with 2.4 and glibc <= 2.1 and it does not occur on 2.2.

<AOL>

I've begun to get a bit paranoid about my K6-2 500 box.

Various processes have been getting random signals after heavy CPU usage.
Playing an MPEG movie, kernel compile, or even just some small apps
compiling sometimes. Just for the record, this isn't an OOM situation,
I've watched this box with half its memory free or in buffers left
unattended, and suddenly a compile will just die.

I replaced the CPU with a brand new K6-2. Problem remained.
Next suspect was faulty RAM. Despite having passed a memtest, I
swapped out the DIMMs for some known good ones.
Suspecting cooling problems, I added some case fans.
Next came a bigger power supply. Still the problems.
The latest last ditch attempt to make this box stable has been
to attach the biggest fan I could find that would fit a socket 7 CPU.

And still the problems are there.
The only remaining suspect would be a flaky motherboard.
But then comes the real killer : This box is rock solid under 2.2

*boggle*

I'm not sure exactly when this started, but I think I first noticed
it around test5 or so, but didn't suspect the kernel at the time.

I've tried kernels compiled with everything from 2.91.66 when this
was a Redhat box, to gcc 2.95.2 (from Debian woody) when I installed
debian on it.  If this is a compiler bug, it's one that no compiler
I've tried seems to be immune from.

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
