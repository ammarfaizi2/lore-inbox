Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135170AbRDLMqx>; Thu, 12 Apr 2001 08:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135173AbRDLMqn>; Thu, 12 Apr 2001 08:46:43 -0400
Received: from www.fibrespeed.net ([216.168.105.33]:43771 "HELO
	mail.fibrespeed.net") by vger.kernel.org with SMTP
	id <S135170AbRDLMq3>; Thu, 12 Apr 2001 08:46:29 -0400
Message-ID: <3AD5A399.71065F90@fibrespeed.net>
Date: Thu, 12 Apr 2001 08:46:20 -0400
From: "Michael T. Babcock" <mbabcock@fibrespeed.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Digi Xem Problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm wondering if anyone in the Linux kernel development community has
any ideas about some problems I'm having with Digi Xem boards.

We've got a Digi Xem board (two different PCI boards and an ISA board
were tested) in a Linux 2.2.19 machine to provide logins to Wyse
terminals.  When logged into the Linux machine, the Wyse terminals
operate fine.  If we telnet anywhere, however (including localhost), and

then generate over about 1k of screen output, the output pauses until we

generate input.  If enter or space, etc. is hit on the Wyse keyboard,
the output continues.  With 2.2.5, this behaviour does not happen.

We are using the epca.c driver from Digi's website (which is
substantially newer than the one included in the kernel distribution).
We have been unable to determine the cause of this pause.  The delay is
very consistent (if we generate output that causes the delay, the same
output will always pause at the same point) but our driver modifications

haven't helped us any.

Digi's engineering staff _may_ look at this problem but since they don't

officially support kernels not released by RedHat, we have no
guarantees.  Any ideas out there?

Please CC me on replies.  Thank-you.

--
Michael T. Babcock (PGP: 0xBE6C1895)
http://www.fibrespeed.net/~mbabcock/



