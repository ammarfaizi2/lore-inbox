Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317430AbSGTPxV>; Sat, 20 Jul 2002 11:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317432AbSGTPxU>; Sat, 20 Jul 2002 11:53:20 -0400
Received: from ping-viini.at.home.telekarelia.fi ([195.197.199.46]:1920 "HELO
	ping-viini.at.home.telekarelia.fi") by vger.kernel.org with SMTP
	id <S317430AbSGTPxU>; Sat, 20 Jul 2002 11:53:20 -0400
Message-ID: <000b01c23005$fef760f0$0200a8c0@eero>
From: "Eero Volotinen" <ev@kernel.ping-viini.org>
To: <linux-kernel@vger.kernel.org>
Subject: crash 2.4.19-rc3 on smp machine.
Date: Sat, 20 Jul 2002 18:56:22 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jul 20 15:02:06 gw kernel: kernel BUG at page_alloc.c:220!
Jul 20 15:02:06 gw kernel: invalid operand: 0000
Jul 20 15:02:06 gw kernel: CPU:    1
Jul 20 15:02:06 gw kernel: EIP:    0010:[<c013147e>]    Not tainted
Jul 20 15:02:06 gw kernel: EFLAGS: 00010202
Jul 20 15:02:06 gw kernel: eax: 00000040   ebx: c149d2f8   ecx: 00001000
edx: 0001ad85
Jul 20 15:02:06 gw kernel: esi: c02968d4   edi: 0001effd   ebp: 0001effd
esp: dad8fe3c
Jul 20 15:02:06 gw kernel: ds: 0018   es: 0018   ss: 0018
Jul 20 15:02:06 gw kernel: Process run (pid: 30135, stackpage=dad8f000)
Jul 20 15:02:06 gw kernel: Stack: 00001000 00019d85 00000296 00000000
c02968d4 c0296a60 000001ff 00000000
Jul 20 15:02:06 gw kernel:        c149d63c c0131711 c02968d4 c0296a5c
000001d2 dad8e000 00000000 00000000
Jul 20 15:02:06 gw kernel:        00000001 c149d63c c0126602 c0126c1d
dcdffd40 08074000 00000000 dbae76c0
Jul 20 15:02:06 gw kernel: Call Trace:    [<c0131711>] [<c0126602>]
[<c0126c1d>] [<c0126e0d>] [<c01211e6>]
Jul 20 15:02:06 gw kernel:   [<c0113a6a>] [<c01272ca>] [<c01138b0>]
[<c0108c0c>]
Jul 20 15:02:06 gw kernel:
Jul 20 15:02:06 gw kernel: Code: 0f 0b dc 00 e3 84 25 c0 8b 43 18 a9 80 00
00 00 74 08 0f 0b
Jul 20 15:02:07 gw kernel:  kernel BUG at page_alloc.c:220!
Jul 20 15:02:07 gw kernel: invalid operand: 0000
Jul 20 15:02:07 gw kernel: CPU:    1
Jul 20 15:02:07 gw kernel: EIP:    0010:[<c013147e>]    Not tainted
Jul 20 15:02:07 gw kernel: EFLAGS: 00010202

..

--
Eero

