Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281562AbRLDSGm>; Tue, 4 Dec 2001 13:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283253AbRLDSFQ>; Tue, 4 Dec 2001 13:05:16 -0500
Received: from pigeon.verisign.com ([65.205.251.71]:39835 "EHLO
	pigeon.verisign.com") by vger.kernel.org with ESMTP
	id <S281147AbRLDSET>; Tue, 4 Dec 2001 13:04:19 -0500
From: slurn@verisign.com
Message-Id: <200112041804.KAA20982@slurndal-lnx.verisign.com>
Subject: Re: [Linux-ia64] Announce: kdb v1.9 is available for kernel 2.4.16
To: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 4 Dec 2001 10:04:23 -0800 (PST)
Cc: kaos@melbourne.sgi.com (Keith Owens),
        hyoshiok@miraclelinux.com (Hiro Yoshioka), kdb@oss.sgi.com,
        linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
In-Reply-To: <14342.1007465769@redhat.com> from "David Woodhouse" at Dec 04, 2001 11:36:09 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> 
> While I sort of see Linus' point, there are two cases where it falls down 
> most often for me.

Actually, I don't see any part of Linus' point.   Kdb is a tool, just as
much as vi or cscope are tools that aid in kernel development.   Anyone
who would throw away a useful tool because he doesn't think it is pretty
(or that a tool should be used at all) is a fool.

The biggest advantage to kdb is its ability to help understand code 
more quickly than just reading it.   The ability to stop at a particular
point and see how you got there can aid in the process of learning the 
source and the multitude of pathways through the code. 

Additionally, one can often repair a defect by modifying a register
and continuing, thus increasing productivity over debug techniques that
include printk() and reboot.

scott

> 
> Firstly, roughly half the bugs which I track by poking around with GDB are
> caused by toolchain/compiler problems, not by bogus code. Looking at the
> code and thinking hard does _not_ help you here. You have to see what's
> buggered, compare the code with the asm and slowly find out what went wrong.
> If BUG() contains a breakpoint and you can poke at it all immediately,
> that's a _lot_ easier than forty-five recompilations and reboots with extra
> printks in random places, the final one of which changes the compiler's
> output so it no longer exhibits the same bug.
> 
> Secondly, the point about not having a debugger making you more careful may
> be true - but half the time I track bugs, they're not in my own code. In
> fact, I'd go as far as to say the 99% of the bugs I actually use GDB for
> aren't in my own code. Some _other_ bugger has been careless, and I'm here
> trying to pick up the pieces. 
> 
> (Sorry for taking the bait - but anything's better than the evolution thread)
> 
> --
> dwmw2
> 

