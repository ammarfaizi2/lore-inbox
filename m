Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSIPJQn>; Mon, 16 Sep 2002 05:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261264AbSIPJQm>; Mon, 16 Sep 2002 05:16:42 -0400
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.232.94]:516
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S261206AbSIPJQm>; Mon, 16 Sep 2002 05:16:42 -0400
Date: Mon, 16 Sep 2002 05:23:49 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: BUG(): sched.c: Line 944 - 2.5.35
Message-ID: <Pine.LNX.4.44.0209160521480.18927-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Machine: Athlon MP 2000+ 512MB DDR Registered
Motherboard: A7M266-D

Kernel 2.5.35:

code resides in main schedule() function:

if (unlikely(in_atomic()))
   BUG();

:(

--
Shawn Starr, sh0n.net, <spstarr@sh0n.net>
Maintainer: -shawn kernel patches: http://xfs.sh0n.net/2.4/


