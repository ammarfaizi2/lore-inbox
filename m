Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314409AbSDRShZ>; Thu, 18 Apr 2002 14:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314410AbSDRShY>; Thu, 18 Apr 2002 14:37:24 -0400
Received: from smtp2.libero.it ([193.70.192.52]:33711 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S314409AbSDRShX> convert rfc822-to-8bit;
	Thu, 18 Apr 2002 14:37:23 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Andrea Aime <aaime@libero.it>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre6+preempt problem...
Date: Thu, 18 Apr 2002 14:26:30 +0200
User-Agent: KMail/1.4.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200204181426.30823.aaime@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,
while exiting from X windows yesterday I got the following error (the system 
didn't crash, thought):

waiting for X server to shut down kernel BUG at page_alloc.c:108!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131c90>]    Tainted: P
EFLAGS: 00013282
eax: 00000000   ebx: c10c77a8   ecx: c10c77a8   edx: c528a9b0
esi: 0016f000   edi: 00000000   ebp: 08048000   esp: c387feb8
ds: 0018   es: 0018   ss: 0018
Process X (pid: 15554, stackpage=c387f000)
Stack: c6418b40 c68f12c0 c01286bf c6418b40 c68f12c0 0805fd5c 00000000 00041000
       0016f000 c4e14224 08048000 c012737e c10c77a8 00000029 00000000 081b7000
       c3f30080 00000000 081b7000 c3f30080 c0115fb3 c6418b40 c68f12c0 0805fd5c
Call Trace: [<c01286bf>] [<c012737e>] [<c0115fb3>] [<c0129df8>] [<c011833a>]
   [<c011ce16>] [<c0107f00>] [<c0108a9b>]

Code: 0f 0b 6c 00 5a 49 28 c0 89 d8 2b 05 10 02 33 c0 69 c0 a3 8b
 <3>X[15554] exited with preempt_count 1

To be sure I restarted the system, but I haven't notice any other problem so 
far... (btw, I'm using NVidia latest drivers, compiled the kernel on a 
Mandrake 8.2 with gcc 2.96 compiler).
Best regards
Andrea Aime


