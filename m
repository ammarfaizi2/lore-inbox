Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154185AbQBAMyT>; Tue, 1 Feb 2000 07:54:19 -0500
Received: by vger.rutgers.edu id <S154232AbQBAMyE>; Tue, 1 Feb 2000 07:54:04 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:1335 "EHLO sgi.com") by vger.rutgers.edu with ESMTP id <S154249AbQBAMwh>; Tue, 1 Feb 2000 07:52:37 -0500
From: slurn@griffin.engr.sgi.com (Scott Lurndal)
Message-Id: <200002011703.JAA66461@griffin.engr.sgi.com>
Subject: [PATCH]  kdb v1.0 for 2.3.29 
To: linux-kernel@vger.rutgers.edu
Date: Tue, 1 Feb 2000 09:03:23 -0800 (PST)
Cc: kdb@oss.sgi.com
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu


I've placed a pre-release of kdb v1.0 (restructured to support 
additional architectures) for ia32 on 

http://oss.sgi.com/projects/kdb/download

--

This release restructures the code a bit and adds breakpoint
instruction style (int 03) breakpoints.   They don't completely
work yet at this time, so as a workaround, the 'bph' command
which uses the hardware debug registers should be used to
establish breakpoints.

There is some debug code present to save and display the contents of the
last branch register MSR on page-fault entry to the kernel.

A list of changes and features can be found on

http://oss.sgi.com/projects/kdb/news.html

--

I'll be in NYC for linuxworld expo this week, so I won't be able
to move this forward to 2.3.41 until next week.

--

scott lurndal
sgi


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
