Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264262AbUE2LWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbUE2LWT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 07:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbUE2LWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 07:22:18 -0400
Received: from h2.prohosting.com.ua ([217.16.18.181]:1946 "EHLO
	h2.prohosting.com.ua") by vger.kernel.org with ESMTP
	id S264262AbUE2LWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 07:22:15 -0400
From: Artemio <theman@artemio.net>
To: linux-kernel@vger.kernel.org
Subject: error compiling linux-2.6.6
Date: Sat, 29 May 2004 14:24:43 +0300
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405291424.43982.theman@artemio.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - h2.prohosting.com.ua
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - artemio.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all!

I am trying to compile a clean, non-patched 2.6.6 kernel from right from 
kernel.org, using gcc 3.3.2. I have tried both gcc 3.3.2 in uclibc i386 root 
distribution and gcc 3.3.2-6mdk in mandrake 10.0. With both gcc's, at the end 
of all, I get:

[make output]
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x6ef62): In function `hpsb_alloc_packet':
: undefined reference to `alloc_skb'
drivers/built-in.o(.text+0x6f68f): In function `hpsb_packet_sent':
: undefined reference to `skb_unlink'
drivers/built-in.o(.text+0x6f82d): In function `hpsb_send_packet':
: undefined reference to `skb_queue_tail'
drivers/built-in.o(.text+0x70199): In function `abort_requests':
: undefined reference to `skb_dequeue'
drivers/built-in.o(.text+0x7025b): In function `queue_packet_complete':
: undefined reference to `skb_queue_tail'
drivers/built-in.o(.text+0x702bf): In function `hpsbpkt_thread':
: undefined reference to `skb_dequeue'
drivers/built-in.o(.text+0x6f006): In function `hpsb_free_packet':
: undefined reference to `__kfree_skb'
make: *** [.tmp_vmlinux1] Error 1
[/make output]

Could someone please tell me what to do? :-/

I'd really appreciate any help. 


Thanks and good luck!


Artemio.
-- 
A-Man ::: new music from Artemio ::: http://a-man.artemio.net
[local time 14:21:11 (GMT +3) 29 May 2004] [system uptime 1 hr 09 min]
