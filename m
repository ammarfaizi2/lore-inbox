Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270381AbRHSNDG>; Sun, 19 Aug 2001 09:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270385AbRHSNC5>; Sun, 19 Aug 2001 09:02:57 -0400
Received: from cabal.xs4all.nl ([213.84.101.140]:15335 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S270381AbRHSNCl>;
	Sun, 19 Aug 2001 09:02:41 -0400
Date: Sun, 19 Aug 2001 15:02:48 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: strace-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: strace 4.4 released
Message-ID: <20010819150248.B1021@wiggy.net>
Mail-Followup-To: strace-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is strace?
---------------
strace is a system call tracer, i.e. a debugging tool which prints out a
trace of all the system calls made by a another process/program.  The
program to be traced need not be recompiled for this, so you can use it
on binaries for which you don't have source.

System calls and signals are events that happen at the user/kernel
interface. A close examination of this boundary is very useful for bug
isolation, sanity checking and attempting to capture race conditions.


What has changed?
-----------------
A fair number of things have been changed since the last announced
release which was version 4.2. For a complete list of changes please see
the ChangeLog file in the source. The highlights are:

* Linux hppa, ia64 and s390 ports added
* The usual Linux syscall updates (includes 32bit uid/gid support),
* Linux ioctl handling code rewritten to be simpler as well as decode
  more ioctls
* Supports IPv6 scope ids
* FreeBSD/i386 port added
* UnixWare and Solaris updates
* Better support for tracing multithreaded processes in Linux. Please note
  that programs using pthread will still hang under strace due to signal
  games they want to play.


Where can I get it?
-------------------
If you are running Debian unstable strace 4.4 source and i386 packages
will appear on mirrors later today. You can also download it directly
from the sourceforge project page, there is a link to that on the strace
homepage (http://www.liacs.nl/~wichert/strace/)

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
