Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269975AbRHJTUl>; Fri, 10 Aug 2001 15:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269976AbRHJTUb>; Fri, 10 Aug 2001 15:20:31 -0400
Received: from freya.cs.umass.edu ([128.119.240.41]:18444 "EHLO
	freya.cs.umass.edu") by vger.kernel.org with ESMTP
	id <S269975AbRHJTUN>; Fri, 10 Aug 2001 15:20:13 -0400
Date: Fri, 10 Aug 2001 15:20:24 -0400 (EDT)
From: Xianglong Huang <xlhuang@cs.umass.edu>
To: <linux-kernel@vger.kernel.org>
cc: Xianglong Huang <xlhuang@freya.cs.umass.edu>
Subject: About signal stack
Message-ID: <Pine.OSF.4.31.0108101513400.17807-100000@freya.cs.umass.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Now I am implementing sigaltstack() system call in a simulator. What
confused me is that I thought the signal stack is pointed by the register
sp. I mean, while the signal handler is running, it will use the address
of signal stack as its stack pointer and run the function on this stack.
But I found by GDB that it is not the case. After I use sigaltstack() in
the program and invoked the signal handler, the sp is not changed by the
value I gave to signal stack by sigaltstack().

My question is: What is the signal stack used for if it is not to replace
the stack pointer? How can I check the value of signal stack by GDB?
Thanks a lot!

Regards,
Long

ps: Please cc the answer to my email address because I am not on the
list. Thanks

