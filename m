Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282688AbRLOOyH>; Sat, 15 Dec 2001 09:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282695AbRLOOx5>; Sat, 15 Dec 2001 09:53:57 -0500
Received: from sushi.toad.net ([162.33.130.105]:63430 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S282688AbRLOOxu>;
	Sat, 15 Dec 2001 09:53:50 -0500
Subject: RE: Oops - 2.4.17rc1 (with iptables 2.4.6)
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 15 Dec 2001 09:53:47 -0500
Message-Id: <1008428030.4859.36.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's interesting that you have the closed-source lt_modem
driver loaded (and appears to have caused the oops) yet your
oops log says "Not tainted".

--
Thomas Hood

"Edward Killips" <ekillips@skyenet.net> wrote:
[...]
> EIP: 0010:[c0216e84>] Not tainted
[...]
> I just upgraded to rc1 and get the following oops
> in with the netfilter code.
[...]
> Using defaults from ksymoops -t elf32-i386 -a i386
> Trace; c02193a0 <ip_rcv_finish+0/1e0>
> Trace; d88919e8 <[lt_modem]UART_CopyDteTxData+44/dc>



