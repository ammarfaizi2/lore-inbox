Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314082AbSEMQA1>; Mon, 13 May 2002 12:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSEMQA0>; Mon, 13 May 2002 12:00:26 -0400
Received: from [202.88.159.197] ([202.88.159.197]:59630 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S314083AbSEMP77>; Mon, 13 May 2002 11:59:59 -0400
Message-Id: <200205131540.g4DFcI601617@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII
From: rpm <rajendra.mishra@timesys.com>
Reply-To: rajendra.mishra@timesys.com
Organization: Timesys
To: root@chaos.analogic.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: c++ program reboots system.
Date: Mon, 13 May 2002 21:08:18 +0530
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.3.95.1020513075608.19504A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> }
> Script started on Mon May 13 07:51:12 2002
> # gdb xxx
> GDB is free software and you are welcome to distribute copies of it
>  under certain conditions; type "show copying" to see the conditions.
> There is absolutely no warranty for GDB; type "show warranty" for details.
> GDB 4.15 (i586-unknown-linux), Copyright 1995 Free Software Foundation,
> Inc... (gdb) run
> Starting program: /root/xxx
>
> Program received signal SIGSEGV, Segmentation fault.
> ostream::flush (this=0x8c224) at iostream.cc:864
> 864	    if (_strbuf->sync())
> (gdb) quit
> The program is running.  Quit anyway (and kill it)? (y or n) y
> # exit
> exit
> Script done on Mon May 13 07:51:49 2002
>
> On Linux 2.4.18, the program just seg-faults (as it should).
> On the version you are using, you should write a 'C' program
> that does lseek() beyond EOF. There could be a bug there, but
> otherwise I can't tell from the program presented.

I executed the same C++ code on iPAQ , on the 2.4.7 kernel and it works fine !
no seg faults no reboots,
I also tried the C program you suggested , but that too works fine,  no 
reboots no seg faults!   :(

rpm
 
