Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263923AbRFDIr5>; Mon, 4 Jun 2001 04:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263946AbRFDIrh>; Mon, 4 Jun 2001 04:47:37 -0400
Received: from [212.150.138.2] ([212.150.138.2]:16646 "EHLO
	ntserver.voltaire.com") by vger.kernel.org with ESMTP
	id <S263923AbRFDIr0>; Mon, 4 Jun 2001 04:47:26 -0400
Message-ID: <20083A3BAEF9D211BDB600805F8B14F3F68F62@NTSERVER>
From: Alon Ronen <alonr@voltaire.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: unresolved symbol on tcp_proxy_sendmsg()
Date: Mon, 4 Jun 2001 11:43:57 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="windows-1255"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I wrote a function under 2.4.4 which simply mimics the behaviour of
tcp_sendmsg() but with zerocopy (uses do_tcp_send_pages()).
I also added the function to the netsyms.c file & then compiled the kernel &
booted from it.
when I try to insmod a module which simply makes a call to my function, I
get an unresolved symbol.

help will be mostly appreciated.

Thanks in advance,

--Alon


