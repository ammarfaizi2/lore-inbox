Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314266AbSEMQjK>; Mon, 13 May 2002 12:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314243AbSEMQjJ>; Mon, 13 May 2002 12:39:09 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27522 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S314325AbSEMQie>; Mon, 13 May 2002 12:38:34 -0400
Date: Mon, 13 May 2002 12:40:52 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: rpm <rajendra.mishra@timesys.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: c++ program reboots system.
In-Reply-To: <200205131540.g4DFcI601617@localhost.localdomain>
Message-ID: <Pine.LNX.3.95.1020513123900.28859A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, rpm wrote:

> > }
> > Script started on Mon May 13 07:51:12 2002
> > # gdb xxx
> > GDB is free software and you are welcome to distribute copies of it
> >  under certain conditions; type "show copying" to see the conditions.
> > There is absolutely no warranty for GDB; type "show warranty" for details.
> > GDB 4.15 (i586-unknown-linux), Copyright 1995 Free Software Foundation,
> > Inc... (gdb) run
> > Starting program: /root/xxx
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > ostream::flush (this=0x8c224) at iostream.cc:864
> > 864	    if (_strbuf->sync())
> > (gdb) quit
> > The program is running.  Quit anyway (and kill it)? (y or n) y
> > # exit
> > exit
> > Script done on Mon May 13 07:51:49 2002
> >
> > On Linux 2.4.18, the program just seg-faults (as it should).
> > On the version you are using, you should write a 'C' program
> > that does lseek() beyond EOF. There could be a bug there, but
> > otherwise I can't tell from the program presented.
> 
> I executed the same C++ code on iPAQ , on the 2.4.7 kernel and it works fine !
> no seg faults no reboots,
> I also tried the C program you suggested , but that too works fine,  no 
> reboots no seg faults!   :(
> 

This is the file I used...
`cp /dev/zero input.out` ^C after a second.

-rw-------   1 root     root     117010432 May 13 07:47 input.out

It seg-faults every time..


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

