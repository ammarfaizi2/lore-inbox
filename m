Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289337AbSAOBCw>; Mon, 14 Jan 2002 20:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289342AbSAOBCn>; Mon, 14 Jan 2002 20:02:43 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:33551 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S289337AbSAOBCf>;
	Mon, 14 Jan 2002 20:02:35 -0500
Date: Mon, 14 Jan 2002 17:59:31 -0700
From: yodaiken@fsmlabs.com
To: george anzinger <george@mvista.com>
Cc: yodaiken@fsmlabs.com, Roman Zippel <zippel@linux-m68k.org>,
        Rob Landley <landley@trommello.org>, Robert Love <rml@tech9.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020114175931.A27147@hq.fsmlabs.com>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there> <20020111220051.A2333@hq.fsmlabs.com> <3C4023A2.8B89C278@linux-m68k.org> <20020112052802.A3734@hq.fsmlabs.com> <3C40392F.C4E1EFF3@linux-m68k.org> <20020112075638.A5098@hq.fsmlabs.com> <3C4367EA.A52D6360@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C4367EA.A52D6360@mvista.com>; from george@mvista.com on Mon, Jan 14, 2002 at 03:21:14PM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 03:21:14PM -0800, george anzinger wrote:
> > > How is that changed? AFAIK inserting more schedule points does not
> > > change the behaviour of the scheduler. The niced app will still get its
> > > time.
> > 
> > How many times can an app be preempted? In a non preempt kernel
> > is can be preempted during user mode at timer frequency and no more
> 
> Uh, it can be and is preempted in user mode by ANY interrupt, be it
> keyboard, serial, lan, disc, etc.  The kernel looks for need_resched at
> the end of ALL interrupts, not just the timer interrupt.


Ouch.




