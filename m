Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262327AbSJKC6j>; Thu, 10 Oct 2002 22:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262328AbSJKC6j>; Thu, 10 Oct 2002 22:58:39 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:25607 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S262327AbSJKC6i>;
	Thu, 10 Oct 2002 22:58:38 -0400
Date: Thu, 10 Oct 2002 23:04:24 -0400 (EDT)
Message-Id: <200210110304.g9B34OT359438@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] procps 3.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Contrary to popular belief, procps is maintained.
Craig Small, Jim Warner, and I have kept it up to date
for several years now. Now I see that keeping a low
profile is really bad, so here goes...

Changes that you may be unaware of and/or need:

top:    windows, color, sort any field, 2.5.xx kernel support
sysctl: supports the VLAN interfaces
ps:     runs 2x faster than procps-2.x.x did
vmstat: 2.5.xx kernel support

Get it here:
http://procps.sf.net/

We use procps-feedback@lists.sf.net for feedback
and procps-news@lists.sf.net for announcements.

---------- full change listing ----------

Version 3.0.1

sysctl handles net/ipv4/conf/eth1.0123/tag (VLAN interface)
sysctl handles net.ipv4.conf.eth1/0123.tag (VLAN interface)
"ps" is now about 2x faster than in procps-2.x.x
"ps -F" now documented
w works in KOI8-R locale
vmstat documentation update
"skill -n blah blah blah" lets you test options
simple "make && make install" now

Version 3.0.0

new top, with optional: color, windowing, SMP stats
designed to support Linux 2.0 through 2.5.41 and beyond
runs faster
more "it crashes" bugs fixed
top shows IO-wait time
vmstat can show active/inactive memory stats
real-time info supported in ps
correct "ps -o size" and "ps --sort size"
reduced memory usage for ps
allow large PIDs to be specified
SELINUX support is just a recompile away
the "F" column shrank, so "ps -l" has more command name room
64-bit time reduces the overflow problem
support S/390, IA-64 emulator, and user-mode Linux
oldps is gone
configure script -- use "make -f Makefile.noam" as a backup
"w" program better at determining what a user is doing
more stable
code at http://procps.sf.net/ now (SourceForge)
uptime give help if you use invalid chars
/proc/tty/drivers correctly parsed. (Thanks russell*AT*coker.com.au)

Prior changes, seen in Debian:

more stable
runs faster
-F format option
better error reporting in ps for unknown format specifiers
BSD's sysctl options -b and -X
top displays well on large-memory systems
old BSD-style select-by-PID ("ps l$$")
15-character user names
ps 'f' ASCII art forest fixed
add SIGSYS on i386
top reports real RSS value
large-memory systems work
minimal ps program for embedded systems (minimal.c)
BSD personality process selection fixed
support locale (French) with ',' and '.' mixed up
new maintainers
pgrep program
includes the "kill" and "nice" programs
don't chop non-tty ps output at 80 columns
-------------------------------------------------------
