Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbRE3XlJ>; Wed, 30 May 2001 19:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262903AbRE3Xk7>; Wed, 30 May 2001 19:40:59 -0400
Received: from coruscant.franken.de ([193.174.159.226]:34322 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S262901AbRE3Xk4>; Wed, 30 May 2001 19:40:56 -0400
Date: Wed, 30 May 2001 20:37:25 -0300
From: Harald Welte <laforge@gnumonks.org>
To: linux-kernel@vger.kernel.org
Subject: How to know HZ from userspace?
Message-ID: <20010530203725.H27719@corellia.laforge.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-Operating-System: Linux corellia.laforge.distro.conectiva 2.4.3
X-Date: Today is Setting Orange, the 4th day of Confusion in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Is there any way to read out the compile-time HZ value of the kernel?

I had a brief look at /proc/* and didn't find anything.

The background, why it is needed:

There are certain settings, for example the icmp rate limiting values,
which can be set using sysctl. Those setting are basically derived from
HZ values (1*HZ, for example).

If you now want to set those values from a userspace program / script in
a portable manner, you need to be able to find out of HZ of the currently
running kernel.

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
