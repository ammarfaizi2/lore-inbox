Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262434AbREUJ6N>; Mon, 21 May 2001 05:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262433AbREUJ6D>; Mon, 21 May 2001 05:58:03 -0400
Received: from cs.columbia.edu ([128.59.16.20]:18052 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S262432AbREUJ5x>;
	Mon, 21 May 2001 05:57:53 -0400
Date: Mon, 21 May 2001 05:57:52 -0400 (EDT)
From: Hua Zhong <huaz@cs.columbia.edu>
To: <linux-kernel@vger.kernel.org>
Subject: CRAK: a process checkpoint/restart kernel module
Message-ID: <Pine.LNX.4.33.0105210555220.20626-100000@razor.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This project has been there for over one year, and I've got quite a few
emails asking about it.  Before it becomes more reliable, I think letting
more people know about it is a good idea.  Thanks to those who ever
pushed me on it :-)

I guess many of you have already known about epckpt, a patch written
by Eduardo Pinheiro that adds process checkpoint/restart capability to the
Linux kernel.  CRAK does the similar thing - in fact, I started this
project based on epckpt's code, but now they have been very different.

The major differences are:

* CRAK is a kernel module (!!)
* CRAK doesn't do any bookkeeping (thus no run time overhead)
* CRAK uses different strategy to checkpoint parallel processes (user
space vs kernel space, and signal vs semaphore)

Moreover, I've successfully (in the sense of working for simple cases such
as telnet) added network socket support.  Due to some academic reasons I
have not put this portion of code online, but I'll do so as soon as
possible.

The main website is at http://www.cs.columbia.edu/~huaz/research/crak.htm.
It works for 2.2.19 and 2.4.4 (the latter is still beta).  You can also
learn more about checkpointing at http://www.checkpointing.org (maintained
by Eduardo Pinheiro).

Speaking of reliability, it's not 100% reliable.  Originally I wanted to
make it more reliable before annoucing it, and now I realized (and was
convinced) that letting people know about it earlier could make this goal
happen sooner.

All comments/praise/criticism are welcome.  Thanks.

----------------------------------------------------------------
Hua Zhong

Central Research Facilities	Department of Computer Science
Columbia University		New York, NY 10027
Email: huaz@cs.columbia.edu	http://www.cs.columbia.edu/~huaz
----------------------------------------------------------------



