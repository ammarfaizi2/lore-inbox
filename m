Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSCUE6B>; Wed, 20 Mar 2002 23:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293314AbSCUE5v>; Wed, 20 Mar 2002 23:57:51 -0500
Received: from bdsl.66.13.20.142.gte.net ([66.13.20.142]:5000 "EHLO
	gatey.bluegum.com") by vger.kernel.org with ESMTP
	id <S293344AbSCUE5g>; Wed, 20 Mar 2002 23:57:36 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/char/pcwd.c - 2.4.19-pre3
Date: Wed, 20 Mar 2002 20:57:30 -0800
From: Lindsay Harris <lindsay@bluegum.com>
Message-Id: <20020321045735.A61BD1DED5@duel.bluegum.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds PCI support to Berkshire Products PC Watchdog card,
drivers/char/pcwd.c.  Also reviewed the existing code, and fixed a
number of "things done wrong", especially when dealing with hardware.

This is a large patch - about 30kb (or 50% bigger than driver source).
The module size has grown by about 900 bytes (to 4772, according to lsmod).

I have tested it with a PCI card and an ISA card (REV C, the newer ISA
model),  both used as a module, and hardwired into the kernel.

The patch is against 2.4.19-pre3, but the changelog shows no changes
to this code in pre4.

Introducing Me:  This is my first linux kernel patch, but I have been mucking
about with unix kernel drivers since AT&T's 6th Edition Unix, in about
1980.  Next goal is to achieve antique status.

The patch:
http://www.bluegum.com/patch/pcwd-patch.gz

A slightly different version of this email:-
http://www.bluegum.com/patch/



Lindsay
lindsay@bluegum.com
