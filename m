Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750859AbWFEXrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWFEXrR (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 19:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWFEXrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 19:47:17 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:2827 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750858AbWFEXrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 19:47:16 -0400
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2FFC6FA0-510F-421F-8D66-AD93EFED10C2@oxley.org>
Cc: akpm@osdl.org
Content-Transfer-Encoding: 7bit
From: Felix Oxley <lkml@oxley.org>
Subject: [2.6.17-rc5-mm3] Fails to compile on PowerBook
Date: Tue, 6 Jun 2006 00:47:14 +0100
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.17-rc5 is ok, but mm3 gives the following error:

   KLIBCCC usr/kinit/ipconfig/netdev.o
   KLIBCCC usr/kinit/ipconfig/packet.o
   KLIBCCC usr/kinit/ipconfig/dhcp_proto.o
   KLIBCCC usr/kinit/ipconfig/bootp_proto.o
   LD      usr/kinit/ipconfig/lib.a
   KLIBCLD usr/kinit/ipconfig/static/ipconfig
   KLIBCLD usr/kinit/ipconfig/shared/ipconfig
usr/kinit/ipconfig/main.o: In function `parse_proto':
main.c:(.text+0x30): relocation truncated to fit: R_PPC_REL24 against  
symbol `strcmp' defined in .text section in /usr/src/linux-2.6.17-rc5/ 
usr/klibc/libc.so
main.c:(.text+0x48): relocation truncated to fit: R_PPC_REL24 against  
symbol `strcmp' defined in .text section in /usr/src/linux-2.6.17-rc5/ 
usr/klibc/libc.so
main.c:(.text+0x60): relocation truncated to fit: R_PPC_REL24 against  
symbol `strcmp' defined in .text section in /usr/src/linux-2.6.17-rc5/ 
usr/klibc/libc.so
main.c:(.text+0x7c): relocation truncated to fit: R_PPC_REL24 against  
symbol `strcmp' defined in .text section in /usr/src/linux-2.6.17-rc5/ 
usr/klibc/libc.so
main.c:(.text+0x98): relocation truncated to fit: R_PPC_REL24 against  
symbol `strcmp' defined in .text section in /usr/src/linux-2.6.17-rc5/ 
usr/klibc/libc.so
main.c:(.text+0xb4): relocation truncated to fit: R_PPC_REL24 against  
symbol `strcmp' defined in .text section in /usr/src/linux-2.6.17-rc5/ 
usr/klibc/libc.so
main.c:(.text+0xd0): relocation truncated to fit: R_PPC_REL24 against  
symbol `strcmp' defined in .text section in /usr/src/linux-2.6.17-rc5/ 
usr/klibc/libc.so
main.c:(.text+0xe8): relocation truncated to fit: R_PPC_REL24 against  
symbol `strcmp' defined in .text section in /usr/src/linux-2.6.17-rc5/ 
usr/klibc/libc.so
main.c:(.text+0x100): relocation truncated to fit: R_PPC_REL24  
against symbol `strcmp' defined in .text section in /usr/src/ 
linux-2.6.17-rc5/usr/klibc/libc.so
main.c:(.text+0x128): relocation truncated to fit: R_PPC_REL24  
against symbol `fprintf' defined in .text section in /usr/src/ 
linux-2.6.17-rc5/usr/klibc/libc.so
main.c:(.text+0x138): additional relocation overflows omitted from  
the output
make[3]: *** [usr/kinit/ipconfig/shared/ipconfig] Error 1
make[2]: *** [usr/kinit/ipconfig] Error 2
make[1]: *** [_usr_kinit] Error 2
make: *** [usr] Error 2

//Felix
