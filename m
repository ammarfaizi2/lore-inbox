Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbTILVOb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTILVOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:14:31 -0400
Received: from web10407.mail.yahoo.com ([216.136.130.99]:40047 "HELO
	web10407.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261878AbTILVO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:14:28 -0400
Message-ID: <20030912211427.18693.qmail@web10407.mail.yahoo.com>
Date: Sat, 13 Sep 2003 07:14:27 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: 2.6.0-test5  Compile error
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry if this has been reported.

drivers/built-in.o(.text+0x5f34f): In function
`atkbd_interrupt':
: undefined reference to `serio_rescan'
drivers/built-in.o(.text+0x5f92e): In function
`atkbd_disconnect':
: undefined reference to `serio_close'
drivers/built-in.o(.text+0x5fa52): In function
`atkbd_connect':
: undefined reference to `serio_open'
drivers/built-in.o(.text+0x5fa90): In function
`atkbd_connect':
: undefined reference to `serio_close'
drivers/built-in.o(.init.text+0x5d4a): In function
`atkbd_init':
: undefined reference to `serio_register_device'
drivers/built-in.o(.exit.text+0x3a6): In function
`atkbd_exit':
: undefined reference to `serio_unregister_device'
make: *** [.tmp_vmlinux1] Error 1

Build with gcc-2.95.3  . With gcc-3.3.1 it failled
right the starting point and I forgot to remember :-)



=====
S.KIEU

http://search.yahoo.com.au - Yahoo! Search
- Looking for more? Try the new Yahoo! Search
