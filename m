Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261211AbSIPNBm>; Mon, 16 Sep 2002 09:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261415AbSIPNBm>; Mon, 16 Sep 2002 09:01:42 -0400
Received: from cibs9.sns.it ([192.167.206.29]:21515 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S261211AbSIPNBl>;
	Mon, 16 Sep 2002 09:01:41 -0400
Date: Mon, 16 Sep 2002 15:06:35 +0200 (CEST)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: oops at bot with 2.5.35, gcc 3.2 (sched.c bug)
Message-ID: <Pine.LNX.4.43.0209161500030.4963-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,

I am just having an oops immediatelly at boot
with kernel 2.5.35.

I get a message saying
kernel BUG at sched.c: 944

eip code point to:

c0117810 T schedule

The process that caused the oops is "swapper".

Obviously syslogd was not running, so I had not a message
to pass trought ksymoops, but if you need, I can write the
oops by hand, and then use ksymoops.

This pc is a PIII 933 Mhz, with 512 MB RAM.
MotherBoard has an Intel 810 chipset.

Kernel had been compiled with gcc 3.2 and binutils 2.13.90.0.4.


Hope this helps

Luigi




