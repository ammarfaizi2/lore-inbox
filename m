Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130032AbRAQGIO>; Wed, 17 Jan 2001 01:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131231AbRAQGHy>; Wed, 17 Jan 2001 01:07:54 -0500
Received: from [129.94.172.186] ([129.94.172.186]:34041 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130032AbRAQGHs>; Wed, 17 Jan 2001 01:07:48 -0500
Date: Sat, 13 Jan 2001 14:23:41 -0500 (EST)
From: Burton Windle <burton@fint.org>
To: Rik van Riel <riel@conectiva.com.br>
Subject: VM: Undead swap messages at shutdown
Message-ID: <Pine.LNX.4.21.0101131417320.2087-100000@fint.staticky.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Loop: duckman
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux VM God :)

I think I started seeing this about 2.4.0-ac6...when I shutdown my
machine, I see tons of 'VM: Undead swap entry #######', where ####### is
some memory address.  I can also reproduce this 100% by (for
example) going into X, loading a lot of crap so that my 112mb ram is full
and it starts to swap, then get out of X, and do a 'swapoff -a'. 

Is this just debugging info, or would you like to see the output of it? My
machine is currently a Debian Unstable, with 112mb RAM and about 190mb
swap, running 2.4.0-ac8.

I have the following kernels installed, so if you need me to see exactly
which kernel started this, it'll be easy:

toy:/etc# grep label /etc/lilo.conf
  label = 240ac8
  label = 240ac7
#  label = 240ac6
#  label = 240ac2
#  label = 240prac6
#  label = 240prac4
#  label = 240t13p7
#  label = 240t12
#  label = 240t12p6
#  label = 240t12p5
#  label = 240t12p3
#  label = 240t12p2
#  label = 240t11
#  label = 240t11p7
  label = k2218p15
  label = win98

-- 
Burton Windle				burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux/init/main.c:1384

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
