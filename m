Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131848AbRAVDMt>; Sun, 21 Jan 2001 22:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130405AbRAVDMj>; Sun, 21 Jan 2001 22:12:39 -0500
Received: from web11604.mail.yahoo.com ([216.136.172.56]:28935 "HELO
	web11604.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131848AbRAVDM0>; Sun, 21 Jan 2001 22:12:26 -0500
Message-ID: <20010122031225.81962.qmail@web11604.mail.yahoo.com>
Date: Sun, 21 Jan 2001 19:12:25 -0800 (PST)
From: Tom <freyason@yahoo.com>
Subject: coprocessor_segment_overrun
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I received the following kernel dump. I was in X, running xmms and
netscape and a few terms.... not sure if this is a problem in the
kernel but I thought I'd post it.

Kernel: 2.4.0 (final release)
GCC Version 2.95.3
Debian 2.2

Please reply via e-mail rather than to mailing list.

Thanks!

Tom

Kernel msgs:

kernel:  printing eip:
kernel: c0108f75
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[coprocessor_segment_overrun+5/16]
kernel: EFLAGS: 00010297
kernel: eax: 58060001   ebx: c0193a0c   ecx: 0009b932   edx: 00000010
kernel: esi: 08dd9800   edi: 08dd9000   ebp: 40001c26   esp: c4a23fe8
kernel: ds: 002b   es: 002b   ss: 0018
kernel: Process netscape (pid: 4856, stackpage=c4a23000)
kernel: Stack: c0108f68 4010ada2 00000023 00010202 bfffe3c8 0000002b
kernel: Call Trace: [invalid_op+8/16]
kernel:
kernel: Code: 8b 10 ff 75 10 ff 75 0c 50 8b 42 68 9c 95 10 c0 e9 c6 fe
ff
kernel:  printing eip:
kernel: c0108f75
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[coprocessor_segment_overrun+5/16]
kernel: EFLAGS: 00210297
kernel: eax: 00000000   ebx: c0193a0c   ecx: 081f27f8   edx: 0000004c
kernel: esi: 08143440   edi: 08142f00   ebp: 400007ca   esp: c545ffe8
kernel: ds: 002b   es: 002b   ss: 0018
kernel: Process xmms (pid: 5694, stackpage=c545f000)
kernel: Stack: c0108f68 4021eda2 00000023 00210206 bffff824 0000002b
kernel: Call Trace: [invalid_op+8/16]
kernel:
kernel: Code: 8b 10 ff 75 10 ff 75 0c 50 8b 42 68 9c 95 10 c0 e9 c6 fe
ff



__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices. 
http://auctions.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
