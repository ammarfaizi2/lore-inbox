Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283310AbRL1AND>; Thu, 27 Dec 2001 19:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283311AbRL1AMy>; Thu, 27 Dec 2001 19:12:54 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:53000 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S283310AbRL1AMq>;
	Thu, 27 Dec 2001 19:12:46 -0500
Date: Thu, 27 Dec 2001 17:05:51 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>, Mike Kravetz <kravetz@us.ibm.com>,
        Momchil Velikov <velco@fadata.bg>, george anzinger <george@mvista.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
Message-ID: <20011227170550.F8660@hq2>
In-Reply-To: <20011226200124.A566@hq2> <Pine.LNX.4.40.0112270931520.1558-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0112270931520.1558-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.23i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 09:41:33AM -0800, Davide Libenzi wrote:
> > No: we've measured. The time in our system, which does not follow any
> > Linux kernel paths, is dominated by motherboard bus delays.
> 
> 17us of bus delay ?!
> UP or SMP ?
> Under which kind of bus load ?

Try
	cli
	read cycle timer
	inb from some isa port
	read cycle timer
	repeat for a while
	sti
	print worst case and weep

