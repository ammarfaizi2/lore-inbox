Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268057AbRGVUpS>; Sun, 22 Jul 2001 16:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268059AbRGVUpI>; Sun, 22 Jul 2001 16:45:08 -0400
Received: from mailgate3.cinetic.de ([212.227.116.80]:39335 "EHLO
	mailgate3.cinetic.de") by vger.kernel.org with ESMTP
	id <S268057AbRGVUpA>; Sun, 22 Jul 2001 16:45:00 -0400
Date: Sun, 22 Jul 2001 22:33:54 +0200
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: loopback mount doesn't work with files on shm filesystem
Message-ID: <20010722223354.A10830@lithium.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux lithium 2.4.7 
From: Jonathan Picht <jonathan.picht@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello,

if I try to mount a file which resides on shm with '-o loop',
I get this output:

ioctl: LOOP_SET_FD: Invalid argument

cat /proc/version:
Linux version 2.4.7 (root@lithium) (gcc version 2.95.4 20010703 (Debian prerelease)) #1 Sam Jul 21 19:23:47 CEST 2001

sh scripts/ver_linux:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux lithium 2.4.7 #1 Sam Jul 21 19:23:47 CEST 2001 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.24
util-linux             2.11g
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.22
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded

I'm running Debian/unstable on a Athlon 600 with 192MB ram.
If you need more information, don't hesitate to ask.

Thank you,

Jonathan

ps: Please cc to me in replies, since I'm not subscribed to the list.
