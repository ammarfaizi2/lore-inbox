Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTILVQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTILVQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:16:13 -0400
Received: from [203.97.122.100] ([203.97.122.100]:897 "HELO skieu.myftp.org")
	by vger.kernel.org with SMTP id S261890AbTILVQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:16:07 -0400
Date: Sat, 13 Sep 2003 09:14:56 +0000 (UTC)
From: haiquy@yahoo.com
X-X-Sender: sk@darkstar.example.net
Reply-To: caoquy@free.net.nz
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5 compile error
Message-ID: <Pine.LNX.4.58.0309130913590.10446@darkstar.example.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry if this has been reported.

drivers/built-in.o(.text+0x5f34f): In function `atkbd_interrupt':
: undefined reference to `serio_rescan'
drivers/built-in.o(.text+0x5f92e): In function `atkbd_disconnect':
: undefined reference to `serio_close'
drivers/built-in.o(.text+0x5fa52): In function `atkbd_connect':
: undefined reference to `serio_open'
drivers/built-in.o(.text+0x5fa90): In function `atkbd_connect':
: undefined reference to `serio_close'
drivers/built-in.o(.init.text+0x5d4a): In function `atkbd_init':
: undefined reference to `serio_register_device'
drivers/built-in.o(.exit.text+0x3a6): In function `atkbd_exit':
: undefined reference to `serio_unregister_device'
make: *** [.tmp_vmlinux1] Error 1

Build with gcc-2.95.3  . With gcc-3.3.1 it failled right the starting point and I forgot to remember :-)



Steve Kieu

PGP Key http://skieu.myftp.org/pub/steve-pub.key

