Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264851AbUE2NTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbUE2NTj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 09:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUE2NTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 09:19:38 -0400
Received: from h2.prohosting.com.ua ([217.16.18.181]:64933 "EHLO
	h2.prohosting.com.ua") by vger.kernel.org with ESMTP
	id S264798AbUE2NTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 09:19:25 -0400
From: Artemio <theman@artemio.net>
To: "Linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: error compiling linux-2.6.6
Date: Sat, 29 May 2004 16:21:47 +0300
User-Agent: KMail/1.6.1
References: <200405291424.43982.theman@artemio.net>
In-Reply-To: <200405291424.43982.theman@artemio.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405291620.49602.theman@artemio.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - h2.prohosting.com.ua
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - artemio.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am continuing my tries...

GCC 2.96, linux-2.6.6.

<make_output>
LD      .tmp_vmlinux1
drivers/built-in.o: In function `hpsb_alloc_packet':
drivers/built-in.o(.text+0x76921): undefined reference to `alloc_skb'
drivers/built-in.o: In function `hpsb_free_packet':
drivers/built-in.o(.text+0x769cc): undefined reference to `__kfree_skb'
drivers/built-in.o: In function `hpsb_packet_sent':
drivers/built-in.o(.text+0x770a2): undefined reference to `skb_unlink'
drivers/built-in.o: In function `hpsb_send_packet':
drivers/built-in.o(.text+0x77250): undefined reference to `skb_queue_tail'
drivers/built-in.o: In function `abort_requests':
drivers/built-in.o(.text+0x77cd6): undefined reference to `skb_dequeue'
drivers/built-in.o: In function `queue_packet_complete':
drivers/built-in.o(.text+0x77d9b): undefined reference to `skb_queue_tail'
drivers/built-in.o: In function `hpsbpkt_thread':
drivers/built-in.o(.text+0x77e00): undefined reference to `skb_dequeue'
make: *** [.tmp_vmlinux1] Error 1
</make_output>

Am I doing something wrong? :-(


Artemio.
-- 
A-Man ::: new music from Artemio ::: http://a-man.artemio.net
[local time 16:19:25 (GMT +3) 29 May 2004] [system uptime 3 hr 07 min]


