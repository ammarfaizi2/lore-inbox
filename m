Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbSALLxq>; Sat, 12 Jan 2002 06:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285878AbSALLxh>; Sat, 12 Jan 2002 06:53:37 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:52754 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S285850AbSALLxb>; Sat, 12 Jan 2002 06:53:31 -0500
Message-ID: <3C4023A2.8B89C278@linux-m68k.org>
Date: Sat, 12 Jan 2002 12:53:06 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Rob Landley <landley@trommello.org>, Robert Love <rml@tech9.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there> <20020111220051.A2333@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yodaiken@fsmlabs.com wrote:

> I believe that the preempt path leads inexorably to
> mutex-with-stupid-priority-trick and that would be very unfortunate indeed.
> It's unavoidable because sooner or later someone will find that preempt +
> SCHED_FIFO leads to
>                 niced app 1 in K mode gets Sem A
>                 SCHED_FIFO app prempts and blocks on  Sem A
>                 whoops! app 2 in K more preempts niced app 1

Please explain what's different without the preempt patch.

>         Hey my DVD player has stalled, lets add sem_with_revolting_priority_trick!
>         Why the hell is UP Windows XP3 blowing away my Linux box on DVD playing while
>         Linux now runs with the grace and speed of IRIX?

Because the IRIX implementation sucks, every implementation has to suck?
Somehow I have the suspicion you're trying to discourage everyone from
even trying, because if he'd succeeded you'd loose a big chunk of
potential RTLinux customers.

bye, Roman
