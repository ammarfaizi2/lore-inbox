Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136159AbRAJSX1>; Wed, 10 Jan 2001 13:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136175AbRAJSXT>; Wed, 10 Jan 2001 13:23:19 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:43794 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S136159AbRAJSXK>; Wed, 10 Jan 2001 13:23:10 -0500
Date: Wed, 10 Jan 2001 18:23:08 +0000 (GMT)
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org, linuxperf@nl.linux.org
Subject: [ANNOUNCE] oprofile profiler
Message-ID: <Pine.LNX.4.21.0101101813160.4135-100000@mrworry.compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oprofile is a low-overhead statistical profiler capable of
instruction-grain profiling of the kernel (including interrupt handlers),
modules, and user-space libraries and binaries.

It uses the Intel P6 performance counters as a source of interrupts to
trigger the accounting handler in a manner similar to that of Digital's
DCPI. All running processes, and the kernel, are profiled by default. The
profiles can be extracted at any time with a simple utility. The system 
consists of a kernel module and a simple background daemon.

Typical overhead is around 3 or 4 percent. Worst case overhead on a
Pentium II 350 UP system is around 10-15%

You can read a little more about oprofile, and download a very alpha
version at :

http://oprofile.sourceforge.net/

oprofile is released under the GNU GPL. 

thanks
john

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
