Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTFTFBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 01:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbTFTFBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 01:01:20 -0400
Received: from mail.wavecomputers.net ([208.18.50.6]:21263 "EHLO teamorb.net")
	by vger.kernel.org with ESMTP id S261180AbTFTFAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 01:00:55 -0400
Message-ID: <005501c336ea$cc5733e0$0106a8c0@Laptop>
Reply-To: "Greg Thompson" <greg@grinc.org>
From: "Greg Thompson" <greg@grinc.org>
To: <linux-kernel@vger.kernel.org>
Subject: Error repeating endlessly in the log
Date: Fri, 20 Jun 2003 00:14:17 -0500
Organization: Grinc
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi group,

Please excuse my ignorance, but I can not find a useful article about this
on the web. I'm definitely no kernel expert, so I figured I'd post to this
group about a strange error I just started seeing on my Linux machine today
for no apparent reason (meaning, I didn't do anything odd that would
logically make the problem happen).
When I go to an event viewer, the following (copied and pasted below) is
constantly being written to the log. What is this and how would one go about
fixing it? I didn't do anything except reboot and now all of a sudden it is
doing this. Nothing seems messed up or anything but obviously something is
very wrong here...its writing thousands of log entries per minute!
The following is a snippit of the log; any help on this matter would be MUCH
appreciated...this is a very important computer (yes, it is an SMP machine)
please CC or send me any replies directly to greg@grinc.org:

06/19 16:43:14 Kernel Warning kernel 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000
06/19 16:43:14 Kernel Warning kernel cfb6ef35 00000a3a 00000020
c21e0000 c0109003 0000000b bfffc85c cfb6d99c
06/19 16:43:14 Kernel Warning kernel Stack: ffffffff ffffffff
ffffffff 00000000 00000013 00000282 bffffde4 00000000
06/19 16:43:14 Kernel Warning kernel Process netserv (pid: 30409,
stackpage=c21e1000)
06/19 16:43:14 Kernel Warning kernel ds: 0018 es: 0018 ss: 0018
06/19 16:43:14 Kernel Warning kernel esi: c0109003 edi: 0000000b ebp:
c21e1fb8 esp: c21e1f80
06/19 16:43:14 Kernel Warning kernel eax: bffffde4 ebx: c21e0000 ecx:
c1312000 edx: 00000000
06/19 16:43:14 Kernel Warning kernel EFLAGS: 00010202
06/19 16:43:14 Kernel Warning kernel EIP: 0010:
[serial:__insmod_serial_O/lib/modules/2.4.19-x1-smp/kernel/drivers/+-
15062950/96] Tainted: P
06/19 16:43:14 Kernel Warning kernel CPU: 0
06/19 16:43:14 Kernel Warning kernel Oops: 0000
06/19 16:43:14 Kernel Warning kernel cfb6d85a
06/19 16:43:14 Kernel Warning kernel printing eip:
06/19 16:43:14 Kernel Warning kernel <1>Unable to handle kernel NULL
pointer dereference at virtual address 00000000
06/19 16:43:14 Kernel Warning kernel Code: 8a 02 84 c0 75 ef e8 9c ec
ff ff 89 c2 80 3a 00 0f 84 bb 00
06/19 16:43:14 Kernel Warning kernel
06/19 16:43:14 Kernel Warning kernel Call Trace: [system_call+51/64]
06/19 16:43:14 Kernel Warning kernel 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000
06/19 16:43:14 Kernel Warning kernel Call Trace: [<0b bfffc85c
cfb6d99c
06/19 16:43:14 Kernel Warning kernel 00000000 00000000 00000000
00000000 00000000 00000000 00000000 00000000
06/19 16:43:14 Kernel Warning kernel cfb6ef35 00000a3a 00000020
c21e0000 c0109003 0000000b bfffc85c cfb6d99c
06/19 16:43:14 Kernel Warning kernel Stack: ffffffff ffffffff
ffffffff 00000000 00000013 00000282 bffffde4 00000000
06/19 16:43:14 Kernel Warning kernel Process netserv (pid: 30316,
stackpage=c21e1000)
06/19 16:43:14 Kernel Warning kernel ds: 0018 es: 0018 ss: 0018
06/19 16:43:14 Kernel Warning kernel esi: c0109003 edi: 0000000b ebp:
c21e1fb8 esp: c21e1f80
06/19 16:43:14 Kernel Warning kernel eax: bffffde4 ebx: c21e0000 ecx:
c1312000 edx: 00000000
06/19 16:43:14 Kernel Warning kernel EFLAGS: 00010202
06/19 16:43:14 Kernel Warning kernel EIP: 0010:
[serial:__insmod_serial_O/lib/modules/2.4.19-x1-smp/kernel/drivers/+-
15062950/96] Tainted: P
06/19 16:43:14 Kernel Warning kernel CPU: 1
06/19 16:43:14 Kernel Warning kernel Oops: 0000

