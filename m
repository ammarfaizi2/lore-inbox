Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264608AbRFYO6j>; Mon, 25 Jun 2001 10:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264594AbRFYO63>; Mon, 25 Jun 2001 10:58:29 -0400
Received: from smtp9.xs4all.nl ([194.109.127.135]:2266 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S264608AbRFYO6R>;
	Mon, 25 Jun 2001 10:58:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dirk Bonenkamp <dirk@bean-it.nl>
Organization: Bean IT
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.5 crash
Date: Mon, 25 Jun 2001 16:58:16 +0200
X-Mailer: KMail [version 1.2]
Cc: rene@nf.tv
MIME-Version: 1.0
Message-Id: <0106251658160L.00965@dirk.intern.bean-it.nl>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Haven't been on this list for a while, and don't really know if this is the 
right place for this message... If not, pls let me know.

The thing is that I had some crashes with kernel 2.4.5. I'm pretty sure that 
the hardware is OK. These are the messages in the syslog / console when 
locking up:

Jun 25 14:51:00 bizon kernel: kernel BUG at page_alloc.c:73!
Jun 25 14:51:00 bizon kernel: invalid operand: 0000
Jun 25 14:51:00 bizon kernel: CPU:    1
Jun 25 14:51:00 bizon kernel: EIP:    0010:[<c012ba83>]
Jun 25 14:51:00 bizon kernel: EFLAGS: 00010282
Jun 25 14:51:00 bizon kernel: eax: 0000001f   ebx: c121cd54   ecx: 00000086   
edx: 01000000
Jun 25 14:51:00 bizon kernel: esi: c121cd54   edi: 00000000   ebp: c127a420   
esp: c36bdea8
Jun 25 14:51:00 bizon kernel: ds: 0018   es: 0018   ss: 0018
Jun 25 14:51:00 bizon kernel: Process sa1 (pid: 15977, stackpage=c36bd000)
Jun 25 14:51:00 bizon kernel: Stack: c02131ac c0213260 00000049 c119bb4c 
c1044010 c0254004 00000207 fffffffe
Jun 25 14:51:00 bizon kernel:        c121cd54 00000002 00000000 c71ce050 
c01201e8 00000013 00000000 00016000
Jun 25 14:51:00 bizon kernel:        c60d2400 00000000 40016000 c60d2400 
c0144d4c c7f902c0 c0254df8 bffffd78
Jun 25 14:51:00 bizon kernel: Call Trace: [<c01201e8>] [<c0144d4c>] 
[<c01100bc>] [<c0122bc9>] [<c0124572>] [<c01121e7>] [<c0116605>]
Jun 25 14:51:00 bizon kernel:        [<c0131bb2>] [<c0106e0b>]
Jun 25 14:51:00 bizon kernel:
Jun 25 14:51:00 bizon kernel: Code: 0f 0b 83 c4 0c 8b 5e 08 85 db 74 16 6a 4b 
68 60 32 21 c0 68

It's an intel based 2 cpu machine, used as an apache webserver. The load is 
low.

Hope you guys can do something with this message!

Tia,

Dirk
