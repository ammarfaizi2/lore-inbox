Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272008AbRHVNZN>; Wed, 22 Aug 2001 09:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272002AbRHVNZA>; Wed, 22 Aug 2001 09:25:00 -0400
Received: from mhub-c5.tc.umn.edu ([160.94.128.51]:15288 "EHLO
	mhub-c5.tc.umn.edu") by vger.kernel.org with ESMTP
	id <S271641AbRHVNYq>; Wed, 22 Aug 2001 09:24:46 -0400
Date: Wed, 22 Aug 2001 08:24:52 -0500 (CDT)
From: Jason Michaelson <micha044@tc.umn.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7-ac10 hangs while compiling 2.4.9
Message-Id: <Pine.SOL.4.20.0108220754270.19071-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm currently in the process of trying to build a 2.4.9 kernel on a
2.4.7-ac10 system. at seemingly random times, the system comes to a halt
during the middle of a compile, to a point where the cursor no longer even
flashes. when this happens, tapping the atx power switch has no effect; it
must be held for the 4 or 5 seconds to get a response from the system. my
first suspicion was the ram, but all 512mb checks out with
memtest86. what's worse about this is that there's no sign of an oops, no
kernel panics, nothing. just a screen with a non-functioning cursor.

while, admittedly, this is the first kernel i've attempted to build on
this system while running 2.4.7ac10, i did add an 80 gb western digital
7200rpm disc to the system over the weekend.

scripts/ver_linux output:

Linux mercury 2.4.7-ac10 #4 SMP Sun Aug 12 15:55:44 CDT 2001 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.24
util-linux             2.11g
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.22
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         st appletalk mousedev hid input ipt_REJECT ipt_LOG
iptable_filter ipt_MASQUERADE ip_nat_ftp iptable_nat ip_tables 
ip_conntrack_ftp ip_conntrack printer acm 3c59x

if there's anything else i can provide to help diagnose the problem, i'll
be more than happy to provide it.

any help in regards to this would be much appreciated.

thanks,

jdm

--------
Jason D. Michaelson          | Debian GNU/      o http://www.debian.org
micha044@tc.umn.edu          |         __
ares0@geocities.com          |        / /    __  _  _  _  _ __  __
Jason.Michaelson@veritas.com |       / /__  / / / \// //_// \ \/ /
(651)746-7263                |      /____/ /_/ /_/\/ /___/  /_/\_\
                             |
                             |   ...because lockups are for convicts...

http://www.jason.the-four-horsemen.org/

Converting Oxygen into Carbon Dioxide since 1977.

Getting a SCSI chain working is perfectly simple if you remember that
there must be exactly three terminations: one on one end of the cable, one
on the other end, and the goat, terminated over the SCSI chain with
a silver-handled knife whilst burning *black* candles. --- Anthony
DeBoer

