Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbQLARQN>; Fri, 1 Dec 2000 12:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQLARQD>; Fri, 1 Dec 2000 12:16:03 -0500
Received: from mailhost.lanl.gov ([128.165.3.12]:26952 "EHLO mailhost.lanl.gov")
	by vger.kernel.org with ESMTP id <S129532AbQLARPu>;
	Fri, 1 Dec 2000 12:15:50 -0500
Message-ID: <3A27D4D6.4DA47346@lanl.gov>
Date: Fri, 01 Dec 2000 09:41:58 -0700
From: Roger Crandell <rwc@lanl.gov>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: multiprocessor kernel problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have 2.4.0  test 10 and test 11 installed on a multiprocessor (Intel)
machine.  I have tried both test versions of the kernel.  I configured
the kernel for single
and multi processor.  When I boot single processor, iptables will run
fine.  When I boot the machine with the multiprocessor kernel and run
iptables, the kernel dumps several pages of hex and the final two lines
of output are:

Killing interrupt handler
scheduling in interrupt

The kernel logs nothing and you must reset the machine to bring it back
up.  I believe this is a kernel issue rather than an iptables
issue.

Does anyone have experience with iptables on a multiprocessor machine?

I am not currently subscribed to this list, so may I please be
personally CC'ed with the
answers/comments posted to the list?  I have also submitted this to the
netfilter list of which I am
a member.


Roger Crandell

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
