Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbVISTgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVISTgD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbVISTgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:36:03 -0400
Received: from pop-borzoi.atl.sa.earthlink.net ([207.69.195.70]:57068 "EHLO
	pop-borzoi.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S932559AbVISTgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:36:01 -0400
Message-ID: <432F131D.60604@earthlink.net>
Date: Mon, 19 Sep 2005 15:35:57 -0400
From: Stephen Clark <stephen.clark@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: process terminations
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

Recently - around Sept 9 I started seeing messages like the following in 
my messages file. The
only thing consistent is the code at nnnnnnnn: is always c3 00 00 00 00 
00 00 00 00 00 00 00 00
00 00 00

I ran memtest86 one pass and it showed no errors - Any ideas?

Thanks,
Steve


Sep 19 12:52:38 joker kernel: trivial-rewrite/28148: potentially 
unexpected fatal signa
l 9.
Sep 19 12:52:38 joker kernel: code at 0033f402: c3 00 00 00 00 00 00 00 
00 00 00 00 00
00 00 00
Sep 19 12:52:38 joker kernel:
Sep 19 12:52:38 joker kernel: Pid: 28148, comm:      trivial-rewrite
Sep 19 12:52:38 joker kernel: EIP: 0073:[<0033f402>] CPU: 0
Sep 19 12:52:38 joker kernel: EIP is at 0x33f402
Sep 19 12:52:38 joker kernel:  ESP: 007b:bffa62fc EFLAGS: 00000246    
Not tainted  (2.6
.12-1.1447_FC4)
Sep 19 12:52:38 joker kernel: EAX: fffffdfe EBX: 0000000a ECX: bffa6454 
EDX: bffa63d4
Sep 19 12:52:38 joker kernel: ESI: bffa6354 EDI: bffa64d4 EBP: bffa64e8 
DS: 007b ES: 00
7b
Sep 19 12:52:38 joker kernel: CR0: 8005003b CR2: 00bec950 CR3: 21928000 
CR4: 000006d0
Sep 19 12:52:41 joker smartd[2557]: smartd received signal 15: Terminated
Sep 19 12:52:41 joker smartd[2557]: smartd is exiting (exit status 0)
Sep 19 12:52:41 joker xinetd[2674]: Exiting...
Sep 19 12:52:42 joker kernel: mDNSResponder/2547: potentially unexpected 
fatal signal 9
.
Sep 19 12:52:42 joker kernel: code at 003b8402: c3 00 00 00 00 00 00 00 
00 00 00 00 00
00 00 00
Sep 19 12:52:42 joker kernel:
Sep 19 12:52:42 joker kernel: Pid: 2547, comm:        mDNSResponder
Sep 19 12:52:42 joker kernel: EIP: 0073:[<003b8402>] CPU: 0
Sep 19 12:52:42 joker kernel: EIP is at 0x3b8402
Sep 19 12:52:42 joker kernel:  ESP: 007b:bf94f5c4 EFLAGS: 00000246    
Not tainted  (2.6

