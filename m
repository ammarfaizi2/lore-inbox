Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbUBVVqc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 16:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbUBVVqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 16:46:32 -0500
Received: from 176-92.SPEEDe.golden.net ([216.75.176.92]:9918 "EHLO
	tdot-uw.dyndns.org") by vger.kernel.org with ESMTP id S261754AbUBVVqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 16:46:30 -0500
Message-ID: <33757.192.168.0.200.1077486389.squirrel@tdot-uw.dyndns.org>
Date: Sun, 22 Feb 2004 16:46:29 -0500 (EST)
Subject: Kernel 2.6.3 detects Mobile P2-400 CPU speed wrong?
From: "Tim Carr" <tdot@fuzzymunchkin.com>
To: linux-kernel@vger.kernel.org
Reply-To: tdot@fuzzymunchkin.com
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

First off, as this is my first post to the Kernel mailing list, I wanted
to ensure everyone that I spent a few days "Googling" first, both the web
in general and the kernel list itself. I haven't seen any posts pertaining
to my problem.

I'm an intermediate linux user, not a kernel-hacker nor a n00b.  I have
just procured an older Toshiba laptop (Satellite 4100XDVD), and it has an
Intel Mobile Pentium II 400mhz.  But, this is what I see when I boot
kernel 2.6.3 (compiled by yours truly):

...
Detected 204.861 MHz processor.
...
Calibrating delay loop... 397.31 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0183f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0183f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Mobile Pentium II stepping 0a
...

Unless I miss my guess, shouldn't it detect the CPU as 400mhz, and set the
delay as 800 bogoMIPS?

I've put my kernel .config file up for anyone who needs to view it, at
http://tdot-uw.dyndns.org/dotconfig-2.6.3 .

All help much appreciated, but as my email server cannot handle the
volume, *** I AM NOT SUBSCRIBED TO THE KERNEL LIST *** -- therefore,
please PLEASE cc this back to me.

Many thanks!

Tim Carr
