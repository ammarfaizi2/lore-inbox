Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313938AbSDZM5z>; Fri, 26 Apr 2002 08:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313943AbSDZM5y>; Fri, 26 Apr 2002 08:57:54 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:50447 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313938AbSDZM5w>; Fri, 26 Apr 2002 08:57:52 -0400
Date: Fri, 26 Apr 2002 14:57:36 +0200
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: gdb stopped working in 2.5.10 - works fine in 2.4.x
Message-ID: <20020426125736.GA6775@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ALPHA :gdb ./angband
GNU gdb 5.1.1
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "alpha-linux"...
(gdb) run
Starting program: /usr/local/games/angband-2.9.7-alpha1/./angband
warning: Cannot insert breakpoint -2:
Cannot access memory at address 0xcc1088a823d9d62c
(gdb) q
The program is running.  Exit anyway? (y or n) y
ALPHA :

the breakpoint with a negative number, followed by the message 'Cannot
access memory at ...' happens on any executable I try with gdb.

This didn't happen with the 2.4.x kernels, so I suspect something in
2.5.x. Any ideas?

Thanks,
Jurriaan
-- 
After penetrating your skull the decibel storm of raucous riffs and
blistering glissandos starts rearranging the synapses in your brain.
You have arrived on the territory of Tribe Apocalyptica.
	Apocalyptica, liner notes to 'Cult'
GNU/Linux 2.5.10 on Debian/Alpha 990 bogomips load:0.15 0.53 0.66
