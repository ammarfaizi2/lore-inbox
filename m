Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbRLBMPv>; Sun, 2 Dec 2001 07:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282849AbRLBMPn>; Sun, 2 Dec 2001 07:15:43 -0500
Received: from mailhost.terra.es ([195.235.113.151]:7958 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id <S282843AbRLBMP1>;
	Sun, 2 Dec 2001 07:15:27 -0500
Date: Sun, 2 Dec 2001 13:16:31 +0100
From: Diego Calleja <grundig@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: perhaps a bug in 2.4.17-pre2??
Message-ID: <20011202131631.A741@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I was writing a form in Opera browser(6.0TP1, a beta release), in the

spanish clone of slashdot.org (barrapunto.org)
when suddenly the window dissapeared, and when i looked into syslog, it
said 
this:


Dec  1 18:22:38 diego kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000008e
Dec  1 18:22:38 diego kernel:  printing eip:
Dec  1 18:22:38 diego kernel: c0138078
Dec  1 18:22:38 diego kernel: *pde = 00000000
Dec  1 18:22:38 diego kernel: Oops: 0000
Dec  1 18:22:38 diego kernel: CPU:    0
Dec  1 18:22:38 diego kernel: EIP:    0010:[sys_select+0/1156]    Tainted:
PF
Dec  1 18:22:38 diego kernel: EFLAGS: 00010287
Dec  1 18:22:38 diego kernel: eax: 0000008e   ebx: c0cc2000   ecx: bffff3b4
  edx: 00000018
Dec  1 18:22:38 diego kernel: esi: bffff2b4   edi: bffff2ac   ebp: 085a5530
  esp: c0cc3fc0
Dec  1 18:22:38 diego kernel: ds: 0018   es: 0018   ss: 0018
Dec  1 18:22:38 diego kernel: Process opera (pid: 2473, stackpage=c0cc3000)
Dec  1 18:22:38 diego kernel: Stack: c0106b63 0000001a bffff3b4 bffff334
bffff2b4 bffff2ac 085a5530 0000008e
Dec  1 18:22:38 diego kernel:        c010002b 0000002b 0000008e 406e5e1e
00000023 00000203 bffff244 0000002b
Dec  1 18:22:38 diego kernel: Call Trace: [system_call+51/64]
Dec  1 18:22:38 diego kernel:
Dec  1 18:22:38 diego kernel: Code: 00 00 00 00 00 00 00 00 20 00 00 00 20
00 00 00 00 00 00 00

I don't know if this is because due to Opera, or it's the kernel itself. So

if this mail should not be in this mailing list, please ignore. 

(I'm running 2.4.17-pre2 in a cyrix 6x86MX 200Mhz 32MB machine, motherboard
is a MSI-5146 with a SiS 5571 Trinity chipset, gcc version 2.95.4)

This is the second time I send this message, but i've not seen it in the
list.....so please forgive me if you see it twice


