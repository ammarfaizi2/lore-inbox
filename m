Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130983AbRAKK2p>; Thu, 11 Jan 2001 05:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130913AbRAKK2j>; Thu, 11 Jan 2001 05:28:39 -0500
Received: from relay02.valueweb.net ([216.219.253.236]:30477 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S130337AbRAKK2Z>; Thu, 11 Jan 2001 05:28:25 -0500
Message-ID: <3A5D8B10.D244D58F@opersys.com>
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test10 ppc)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: John Levon <moz@compsoc.man.ac.uk>
CC: linux-kernel@vger.kernel.org, linuxperf@nl.linux.org
Subject: Re: [ANNOUNCE] oprofile profiler
In-Reply-To: <Pine.LNX.4.21.0101101813160.4135-100000@mrworry.compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 11 Jan 2001 05:27:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello John,

This is really interesting. Great stuff.

As Alan had once suggested, it would be very interesting to have this
information correlated with the content of the traces collected using
the Linux Trace Toolkit (www.opersys.com/LTT). For instance, you could see
how many cache faults the read() or write() operation of your application
generated and other unique info. It would also be possible to enhance
the post-mortem analysis done by LTT to take in account this data.
You could also use LTT's dynamic event creation mechanism to log the
profiling data as part of the trace.

There are definitely opportunities for interfacing/integrating here.

Let me know what you think.

Best regards

Karim

John Levon wrote:
> 
> oprofile is a low-overhead statistical profiler capable of
> instruction-grain profiling of the kernel (including interrupt handlers),
> modules, and user-space libraries and binaries.
> 
> It uses the Intel P6 performance counters as a source of interrupts to
> trigger the accounting handler in a manner similar to that of Digital's
> DCPI. All running processes, and the kernel, are profiled by default. The
> profiles can be extracted at any time with a simple utility. The system
> consists of a kernel module and a simple background daemon.
> 
> Typical overhead is around 3 or 4 percent. Worst case overhead on a
> Pentium II 350 UP system is around 10-15%
> 
> You can read a little more about oprofile, and download a very alpha
> version at :
> 
> http://oprofile.sourceforge.net/
> 
> oprofile is released under the GNU GPL.
> 
> thanks
> john
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
===================================================
                 Karim Yaghmour
               karym@opersys.com
          Operating System Consultant
 (Linux kernel, real-time and distributed systems)
===================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
