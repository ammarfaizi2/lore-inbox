Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264951AbRFUNXF>; Thu, 21 Jun 2001 09:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264953AbRFUNW4>; Thu, 21 Jun 2001 09:22:56 -0400
Received: from ns.viventus.no ([195.18.200.139]:25606 "EHLO viventus.no")
	by vger.kernel.org with ESMTP id <S264951AbRFUNWp>;
	Thu, 21 Jun 2001 09:22:45 -0400
From: Rafael Martinez <rafael@viewpoint.no>
To: linux-kernel@vger.kernel.org
Reply-To: rafael@viewpoint.no
Subject: Unable to handle kernel NULL pointer dereference at virtual address - 2.4.5
Date: Thu, 21 Jun 2001 15:21:13 +0100 (CEST)
X-Mailer: XCmail 1.2 - with PGP support, PGP engine version 0.5 (Linux)
X-Mailerorigin: http://www.fsai.fh-trier.de/~schmitzj/Xclasses/XCmail/
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Message-ID: <auto-000000272718@viventus.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have got a error in my syslog about a Null pointer in the kernel:

Kernel 2.4.5
glibc 2.2.12
gcc version 2.96 20000731 (Red Hat Linux 7.0)

Modell: ISP2150 
Motherboard: L440GX+ DP 
CPU: 2 x Intel Pentium III (Coppermine) 850 MHz L2 cache: 256K / Bus: 100 MHz 
RAM: 256 MB 
SCSI controller: Adaptec AIC-7896/7 Ultra2

*******************************************************************
Error log
*******************************************************************
Unable to handle kernel NULL pointer dereference at virtual address
00000015
 printing eip:
c014db72
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c014db72>]
EFLAGS: 00010206
eax: 00000005   ebx: cc870440   ecx: 00000020   edx: c1c12000
esi: c0287140   edi: 0000000c   ebp: c0287490   esp: c63e7e6c
ds: 0018   es: 0018   ss: 0018
Process top (pid: 21710, stackpage=c63e7000)
Stack: c0149366 cc870440 c1c12000 00000000 c014ee0c cc870440 c1c12000
0000000c 
       c023b269 c014f096 c144f000 c1c12000 0000000c c1c12000 ffffffea
cf6190e0 
       c01470d6 c1445060 00000007 c63e6000 fffffff4 cf6190e0 cc80b260
c013e403 
Call Trace: [<c0149366>] [<c014ee0c>] [<c014f096>] [<c01470d6>]
[<c013e403>] [<c013ec85>] [<c013f5a2>] 
       [<c0132f26>] [<c013e08b>] [<c013322a>] [<c0106df7>] [<c010002b>] 

Code: f0 ff 48 10 8b 42 24 83 48 14 08 52 e8 dd fe ff ff 5a c3 8d 
Unable to handle kernel NULL pointer dereference at virtual address
00000015
 printing eip:
c014db72
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c014db72>]
EFLAGS: 00010206
eax: 00000005   ebx: cfbf1080   ecx: 00000020   edx: ca546000
esi: c0287140   edi: 0000000c   ebp: c0287490   esp: cb817e6c
ds: 0018   es: 0018   ss: 0018
Process top (pid: 25765, stackpage=cb817000)
Stack: c0149366 cfbf1080 ca546000 00000000 c014ee0c cfbf1080 ca546000
0000000c 
       c023b269 c014f096 c144f000 ca546000 0000000c ca546000 ffffffea
cfbf1260 
       c01470d6 c1445060 00000007 cb816000 fffffff4 cfbf1260 cd9075a0
c013e403 
Call Trace: [<c0149366>] [<c014ee0c>] [<c014f096>] [<c01470d6>]
[<c013e403>] [<c013ec85>] [<c013f5a2>] 
       [<c0132f26>] [<c013e08b>] [<c013322a>] [<c0106df7>] [<c010002b>] 

Code: f0 ff 48 10 8b 42 24 83 48 14 08 52 e8 dd fe ff ff 5a c3 8d
*******************************************************************

Sincerely
Rafael Martinez



