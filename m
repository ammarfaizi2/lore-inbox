Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318263AbSHKJky>; Sun, 11 Aug 2002 05:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318264AbSHKJky>; Sun, 11 Aug 2002 05:40:54 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:11913 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S318263AbSHKJkx>; Sun, 11 Aug 2002 05:40:53 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivangurdiev@attbi.com>
Reply-To: ivangurdiev@attbi.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.31
Date: Sat, 10 Aug 2002 05:51:46 -0400
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208100551.46142.ivangurdiev@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.31
	+ system.c missing include patch
	+ devfs console patch (wrong one...Simmons' patch is still not in the kernel)
====================

drivers/built-in.o: In function `parport_pc_probe_port':
drivers/built-in.o(.text+0x2dbf6): undefined reference to `request_dma'
drivers/built-in.o(.text+0x2dc98): undefined reference to `free_dma'
drivers/built-in.o: In function `parport_pc_unregister_port':
drivers/built-in.o(.text+0x2df94): undefined reference to `free_dma'
drivers/built-in.o(.data+0x4c20): undefined reference to `request_dma'
drivers/built-in.o(.data+0x4c24): undefined reference to `free_dma'
make: *** [vmlinux] Error 1


