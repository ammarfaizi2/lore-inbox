Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283758AbRL1Aq1>; Thu, 27 Dec 2001 19:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283786AbRL1AqS>; Thu, 27 Dec 2001 19:46:18 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:33800 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S283758AbRL1AqH>; Thu, 27 Dec 2001 19:46:07 -0500
Date: Thu, 27 Dec 2001 16:48:58 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Victor Yodaiken <yodaiken@fsmlabs.com>
cc: Mike Kravetz <kravetz@us.ibm.com>, Momchil Velikov <velco@fadata.bg>,
        george anzinger <george@mvista.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <20011227170550.F8660@hq2>
Message-ID: <Pine.LNX.4.40.0112271648170.1558-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Victor Yodaiken wrote:

> On Thu, Dec 27, 2001 at 09:41:33AM -0800, Davide Libenzi wrote:
> > > No: we've measured. The time in our system, which does not follow any
> > > Linux kernel paths, is dominated by motherboard bus delays.
> >
> > 17us of bus delay ?!
> > UP or SMP ?
> > Under which kind of bus load ?
>
> Try
> 	cli
> 	read cycle timer
> 	inb from some isa port
> 	read cycle timer
> 	repeat for a while
> 	sti
> 	print worst case and weep

No need to test, i've a positive guess from ISA :)



- Davide


