Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUGQPhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUGQPhT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 11:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUGQPhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 11:37:19 -0400
Received: from bay2-f1.bay2.hotmail.com ([65.54.247.1]:36365 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S265196AbUGQPhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 11:37:17 -0400
X-Originating-IP: [213.16.186.86]
X-Originating-Email: [sta_tzani7@hotmail.com]
From: "stavros tzanidakis" <sta_tzani7@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: arch/i386/kernel/traps.o error
Date: Sat, 17 Jul 2004 15:37:16 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F1WuoHWh7qdDZ70006accb@hotmail.com>
X-OriginalArrivalTime: 17 Jul 2004 15:37:16.0862 (UTC) FILETIME=[F084A5E0:01C46C13]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi ! I tried to build kernel 2.6.6 on a SUSE 9 system (kernel 2.4.X) but I 
faced up the problem below. I have made make mrproper, make xconfig and I 
have the minimum software requirements. Could anybody help me? Thanks a lot. 
Stavros
CC      arch/i386/kernel/traps.o
arch/i386/kernel/traps.c: In function `die':
arch/i386/kernel/traps.c:331: warning: implicit declaration of function 
`CHK_REMOTE_DEBUG'
arch/i386/kernel/traps.c:331: error: parse error before ')' token
arch/i386/kernel/traps.c: In function `do_int3':
arch/i386/kernel/traps.c:436: error: parse error before "return"
arch/i386/kernel/traps.c: In function `do_overflow':
arch/i386/kernel/traps.c:437: error: parse error before "return"
arch/i386/kernel/traps.c: In function `do_bounds':
arch/i386/kernel/traps.c:438: error: parse error before "return"
arch/i386/kernel/traps.c: In function `do_coprocessor_segment_overrun':
arch/i386/kernel/traps.c:440: error: parse error before ')' token
arch/i386/kernel/traps.c: In function `do_invalid_TSS':
arch/i386/kernel/traps.c:441: error: parse error before ')' token
arch/i386/kernel/traps.c: In function `do_segment_not_present':
arch/i386/kernel/traps.c:442: error: parse error before ')' token
arch/i386/kernel/traps.c: In function `do_stack_segment':
arch/i386/kernel/traps.c:443: error: parse error before ')' token
arch/i386/kernel/traps.c: In function `do_general_protection':
arch/i386/kernel/traps.c:469: error: parse error before ')' token
arch/i386/kernel/traps.c: In function `do_debug':
arch/i386/kernel/traps.c:681: error: parse error before ')' token
make[1]: *** [arch/i386/kernel/traps.o] Error 1
make: *** [arch/i386/kernel] Error 2

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail

