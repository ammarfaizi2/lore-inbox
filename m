Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287440AbSALUnM>; Sat, 12 Jan 2002 15:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287464AbSALUnC>; Sat, 12 Jan 2002 15:43:02 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:15369 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287440AbSALUmu>; Sat, 12 Jan 2002 15:42:50 -0500
Message-ID: <3C409FB2.8D93354F@linux-m68k.org>
Date: Sat, 12 Jan 2002 21:42:26 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: yodaiken@fsmlabs.com, Rob Landley <landley@trommello.org>,
        Robert Love <rml@tech9.net>, nigel@nrg.org,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PTB7-0002rC-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan Cox wrote:

> > Because the IRIX implementation sucks, every implementation has to suck?
> > Somehow I have the suspicion you're trying to discourage everyone from
> > even trying, because if he'd succeeded you'd loose a big chunk of
> > potential RTLinux customers.
> 
> Victor has had the same message for years, as have others like Larry McVoy
> (in fact if Larry and Victor agree on something its unusual enough to
>  remember). So I can vouch for the fact Victor hasn't changed his tune from
> before rtlinux was ever any real commercial toy. I think you owe him an
> apology.

Did I really say something that bad? I would be actually surprised, if
Victor wouldn't act in the best interest of his company. The other
possibility is that Victor must have had such a terrible experience with
IRIX, so that he thinks any attempts to add better soft realtime or even
hard realtime capabilities (not just as addon) must be doomed to fail.

> RtLinux isn't going to help you one bit when it comes to smooth movie playback
> because the DVD playback is dependant on the Linux file system layers and a
> whole pile of other code. Low-latency does this quite nicely, and it takes
> you to the point where hardware becomes the biggest latency cause for the
> general case. Pre-empt doesn't buy you anything more. You can spend a
> millisecond locked in an I/O instruction to an irritating device.

Preemption doesn't solve of course every problem. It's mainly useful to
get an event as fast as possible from kernel to user space. This can be
the mouse click or the buffer your process is waiting for. Latencies can
quickly sum up here to be sensible.

bye, Roman
