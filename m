Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284903AbRLPXE0>; Sun, 16 Dec 2001 18:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284905AbRLPXEQ>; Sun, 16 Dec 2001 18:04:16 -0500
Received: from harddata.com ([216.123.194.198]:48648 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S284903AbRLPXEH>;
	Sun, 16 Dec 2001 18:04:07 -0500
Date: Sun, 16 Dec 2001 16:04:04 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17-rc1 does not boot my Alphas
Message-ID: <20011216160404.A2945@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just happen to have an access right now to two Alpha machines,
UP1100 and UP1500, both with Nautilus chipset.  Neither of these
can be booted with 2.4.16 or 2.4.17rc1. On an attempt to boot
I can see only messages from a boot loader (aboot):
.....
zero-filling 155872 bytes at 0xffffc0000ad1308
starting kernel vmlinux.......

and that is it.  The only thing which works now is a power switch.
The same happens if I try 2.4.17aa1rc1 (Andrea patches).

A kernel with the highest version which I managed to boot so far,
on both machines, is 2.4.13-ac8.  Anybody with a handly on what is
going on?  I did not check yet if various Alpha specific patches
which were present in "ac" were merged into mainline.  But so
far things seem to be quite thorougly broken for Alpha (or at
least Nautilus).

  Michal
  michal@harddata.com
