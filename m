Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQLCCjx>; Sat, 2 Dec 2000 21:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbQLCCjn>; Sat, 2 Dec 2000 21:39:43 -0500
Received: from CPE-61-9-148-163.vic.bigpond.net.au ([61.9.148.163]:7943 "HELO
	halfway.linuxcare.com.au") by vger.kernel.org with SMTP
	id <S129352AbQLCCjd>; Sat, 2 Dec 2000 21:39:33 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Roger Crandell <rwc@lanl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multiprocessor kernel problem 
In-Reply-To: Your message of "Fri, 01 Dec 2000 09:41:58 PDT."
             <3A27D4D6.4DA47346@lanl.gov> 
Date: Sun, 03 Dec 2000 13:08:53 +1100
Message-Id: <20001203020904.31A2C813F@halfway.linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3A27D4D6.4DA47346@lanl.gov> you write:
> 
> I have 2.4.0  test 10 and test 11 installed on a multiprocessor (Intel)
> machine.  I have tried both test versions of the kernel.  I configured
> the kernel for single
> and multi processor.  When I boot single processor, iptables will run
> fine.  When I boot the machine with the multiprocessor kernel and run
> iptables, the kernel dumps several pages of hex and the final two lines
> of output are:
> 
> Killing interrupt handler
> scheduling in interrupt

My development box (running test10pre5) is SMP, and it works fine.  I
haven't updated to the latest kernel version because I like my
filesystems in one piece, and the netfilter code hasn't changed.

What is your kernel configuration, and iptables version?  Have you
patched the kernel?

Thanks for the report,
Rusty.
--
Hacking time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
