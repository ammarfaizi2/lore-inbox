Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155058AbPFOX1G>; Tue, 15 Jun 1999 19:27:06 -0400
Received: by vger.rutgers.edu id <S154813AbPFOX04>; Tue, 15 Jun 1999 19:26:56 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:8671 "EHLO pneumatic-tube.sgi.com") by vger.rutgers.edu with ESMTP id <S155031AbPFOXYV>; Tue, 15 Jun 1999 19:24:21 -0400
From: sfoehner@illini.engr.sgi.com (Scott Foehner)
Message-Id: <199906100556.WAA22464@illini.engr.sgi.com>
Subject: [PATCH] gdb w/early connect
To: linux-kernel@vger.rutgers.edu
Date: Wed, 9 Jun 1999 22:56:51 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

This patch allows a the linux kernel to be debugged with gdb over a
serial line. There are other patches that allow similar functionality. The
advantage of this patch is that it allows gdb to begin communicating
with the kernel during the boot process. In this version, the kernel waits
for a connection from gdb over the serial port as soon as the IRQs have
been initialized. In the future I will try to make this connection point
even earlier in the boot process.

The patch can be found at:
http://reality.sgi.com/sfoehner_engr/gdb/

I can be reached at:
sfoehner@engr.sgi.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
