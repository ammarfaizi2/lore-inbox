Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbUKEQYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbUKEQYZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbUKEQYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:24:12 -0500
Received: from alog0372.analogic.com ([208.224.222.148]:15488 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262710AbUKEQYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:24:05 -0500
Date: Fri, 5 Nov 2004 11:22:04 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
       Adam Heath <doogie@debian.org>, Chris Wedgwood <cw@f00f.org>,
       Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
In-Reply-To: <1099669670.2814.19.camel@laptop.fenrus.org>
Message-ID: <Pine.LNX.4.61.0411051105020.15468@chaos.analogic.com>
References: <41894779.10706@techsource.com>  <20041103211353.GA24084@infradead.org>
  <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com> 
 <20041103233029.GA16982@taniwha.stupidest.org> 
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com> 
 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org> 
 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com> 
 <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org> 
 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com> 
 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org>  <20041105014146.GA7397@pclin040.win.tue.nl>
  <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> <1099669670.2814.19.camel@laptop.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004, Arjan van de Ven wrote:

> On Fri, 2004-11-05 at 07:41 -0800, Linus Torvalds wrote:
>>> -rw-r--r--   1 root     root       281572 Jul 30  1995 zImage-1.2.11
>>> -rw-r--r--   1 root     root       277476 Apr  1  1995 zImage-1.2.2
>>
>> Ok, you da man. What do you use it for? Or is it just lying around for
>> nostalgic reasons?
>
> some people are just a bit stubborn in accepting elf binaries perhaps ;)

Most of the tools on this machine were built on this machine:

Script started on Fri 05 Nov 2004 11:02:59 AM EST
# ls -la
total 112
drwxr-xr-x   2 root root  4096 Nov  5 11:02 .
drwxr-xr-x  12 root root  4096 Oct 22  1997 ..
-rw-r--r--   1 root root  7433 Aug 23  1994 lpr.1
-rw-r--r--   1 root root 16776 Oct 22  1997 lpr.c
-rw-r--r--   1 root root 16614 Jul 29  1996 lpr.c~
-rw-r--r--   1 root root 16712 Nov 24  1996 lpr.c.orig
-rw-r--r--   1 root root 31948 Dec 17  1993 lpr.termios
-rw-r--r--   1 root root   188 Oct 25  1994 Makefile
# pwd
/home/project/usr/src/lpr-5.9/lpr
# exit
exit
Script done on Fri 05 Nov 2004 11:03:12 AM EST

I would modify the BSD source so it would compile and run
on Linux, then I would submit it. You can see, above that
`lpr` had to get modified in 1996 to accommodate some
changes (probably GCC changes).

I save all this to show that there isn't a GNU/Linux, really
a BSD/Linux.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
