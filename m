Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281503AbRKHKFy>; Thu, 8 Nov 2001 05:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281501AbRKHKFo>; Thu, 8 Nov 2001 05:05:44 -0500
Received: from mail.spylog.com ([194.67.35.220]:28839 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S281497AbRKHKFh>;
	Thu, 8 Nov 2001 05:05:37 -0500
Date: Thu, 8 Nov 2001 13:05:30 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: {bug} tcp v4 hash - 2.4.14pre6aa1
Message-ID: <20011108130530.A1006@spylog.ru>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

 kernel 2.4.14pre6aa1, web server apache 1.3.20

...
Nov  8 00:21:14 emerald kernel: sending pkt_too_big to self
Nov  8 12:19:43 emerald kernel: KERNEL: assertion (sk->pprev==NULL) failed at
tcp_ipv4.c(345):__tcp_v4_hash
Nov  8 12:23:01 emerald kernel: KERNEL: assertion (sk->pprev==NULL) failed at
tcp_ipv4.c(345):__tcp_v4_hash
Nov  8 12:24:08 emerald kernel: KERNEL: assertion (sk->pprev==NULL) failed at
tcp_ipv4.c(345):__tcp_v4_hash
Nov  8 12:25:27 emerald kernel: KERNEL: assertion (sk->pprev==NULL) failed at
tcp_ipv4.c(345):__tcp_v4_hash
Nov  8 12:26:27 emerald kernel: KERNEL: assertion (sk->pprev==NULL) failed at
tcp_ipv4.c(345):__tcp_v4_hash
Nov  8 12:26:55 emerald kernel: KERNEL: assertion (sk->pprev==NULL) failed at
tcp_ipv4.c(345):__tcp_v4_hash
Nov  8 12:28:28 emerald kernel: KERNEL: assertion (sk->pprev==NULL) failed at
tcp_ipv4.c(345):__tcp_v4_hash
Nov  8 12:30:04 emerald kernel: KERNEL: assertion (sk->pprev==NULL) failed at
tcp_ipv4.c(345):__tcp_v4_hash
Nov  8 12:30:35 emerald last message repeated 4 times
Nov  8 12:31:05 emerald kernel: KERNEL: assertion (sk->pprev==NULL) failed at
tcp_ipv4.c(345):__tcp_v4_hash
Nov  8 12:32:14 emerald kernel: KERNEL: assertion (sk->pprev==NULL) failed at
tcp_ipv4.c(345):__tcp_v4_hash
N

 and server dead.

-- 
bye.
Andrey Nekrasov, SpyLOG.
