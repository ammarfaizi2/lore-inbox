Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSGEGCr>; Fri, 5 Jul 2002 02:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSGEGCq>; Fri, 5 Jul 2002 02:02:46 -0400
Received: from ns1.yifansoft.com ([64.61.26.50]:11734 "HELO mail.yifansoft.com")
	by vger.kernel.org with SMTP id <S315437AbSGEGCq>;
	Fri, 5 Jul 2002 02:02:46 -0400
Subject: StackPages errors (CALLTRACE)
From: Pablo Fischer <exilion@yifan.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 05 Jul 2002 01:06:56 -0500
Message-Id: <1025849217.2921.34.camel@pablo.fischer.com.mx>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi..

I have MDK 8.2 and I get this error with: MDK 8.2, RH 7.2, RH 7.3.. but
just with ONE COMPUTER, the other computers works fine.

Ok.. I have a SpeedTouch, but to get it work I need to

1) modprobe the module
2) Then.. call the speedmgmt (a binary)

When I call the speedmgmt, I get:


Process speedmgmt (pid: 1748, stackpage=c1827000)
Stack: c0263a10 c1040000 c0263a4c 00000212 00000000 00000000 c4c10f60
c4d79c9e
c11e4e60 00000001 00000000 00000000 00000001 00000001 00000000 bffff752
c3430460 fffffdfd c398cde0 c0312ae0 c4d79f97 c3430460 bffff758 bffff758
Call Trace:
[af_packet:__insmod_af_packet_O/lib/modules/2.4.18-6mdk/kernel/net/pac+-1548448/96] [af_packet:__insmod_af_packet_O/lib/modules/2.4.18-6mdk/kernel/net/pac+-70498/96] [af_packet:__insmod_af_packet_O/lib/modules/2.4.18-6mdk/kernel/net/pac+-69737/96] [file_ioctl+340/368] [sys_ioctl+546/608]
Call Trace: [<c4c10f60>] [<c4d79c9e>] [<c4d79f97>] [<c01413b4>]
[<c01415f2>]
[system_call+51/64]
[<c0106f23>]
Code: 0f 44 c2 8b 57 04 0d 80 00 00 c0 89 42 18 8b 07 8b 57 04 8b

Why I get that error?

I have a Compaq (AMD K6 - 500mhz) and 64 of Memory.

Paul fischer



