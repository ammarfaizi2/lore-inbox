Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273364AbRI0Pd0>; Thu, 27 Sep 2001 11:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273361AbRI0PdR>; Thu, 27 Sep 2001 11:33:17 -0400
Received: from mail1-gui.server.ntli.net ([194.168.222.13]:46762 "EHLO
	mail1-gui.server.ntli.net") by vger.kernel.org with ESMTP
	id <S273364AbRI0PdI>; Thu, 27 Sep 2001 11:33:08 -0400
Date: Thu, 27 Sep 2001 16:33:33 +0100 (BST)
From: Ben <linux-kernel@slimyhorror.com>
X-X-Sender: <ben@baphomet.bogo.bogus>
To: <linux-kernel@vger.kernel.org>
Subject: -1M RSS with 2.4.10
Message-ID: <Pine.LNX.4.33.0109271628200.16824-100000@baphomet.bogo.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My machine has been running 2.4.10 (+preemptive kernel patches) happily.
But then, running top and sorting by memory usage, I notice at the top:

 16:30:47 up 2 days,  3:36, 22 users,  load average: 1.34, 1.62, 1.78
140 processes: 135 sleeping, 4 running, 0 zombie, 1 stopped
CPU states:   3.8% user,  22.4% system,  73.8% nice,   0.0% idle
Mem:    239900K total,   235376K used,     4524K free,      888K buffers
Swap:   262576K total,    24512K used,   238064K free,    88884K cached

  PID USER     PRI  NI  SIZE SWAP  RSS SHARE STAT LC %CPU %MEM   TIME COMMAND
32139 ben        9   0  4440 3556  -1M   420 S     0  0.0 99.9   0:01 xterm

This looks bad! But is it a bug in the kernel, or with 'top'? There are no
dmesg errors.  Has anyone got advice on what I could do to track down what
the problem is?


Thanks,
Ben

