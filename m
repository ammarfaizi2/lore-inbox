Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312419AbSDSKst>; Fri, 19 Apr 2002 06:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312420AbSDSKss>; Fri, 19 Apr 2002 06:48:48 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:3590 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S312419AbSDSKsr>; Fri, 19 Apr 2002 06:48:47 -0400
Message-Id: <200204191045.g3JAjpX04243@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrea Aime <aaime@libero.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre6+preempt problem...
Date: Fri, 19 Apr 2002 13:48:09 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200204181426.30823.aaime@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 April 2002 10:26, Andrea Aime wrote:
> while exiting from X windows yesterday I got the following error (the
> system didn't crash, thought):
>
> waiting for X server to shut down kernel BUG at page_alloc.c:108!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0131c90>]    Tainted: P
> EFLAGS: 00013282
> eax: 00000000   ebx: c10c77a8   ecx: c10c77a8   edx: c528a9b0
> esi: 0016f000   edi: 00000000   ebp: 08048000   esp: c387feb8
> ds: 0018   es: 0018   ss: 0018
> Process X (pid: 15554, stackpage=c387f000)
> Stack: c6418b40 c68f12c0 c01286bf c6418b40 c68f12c0 0805fd5c 00000000
> 00041000 0016f000 c4e14224 08048000 c012737e c10c77a8 00000029 00000000
> 081b7000 c3f30080 00000000 081b7000 c3f30080 c0115fb3 c6418b40 c68f12c0
> 0805fd5c Call Trace: [<c01286bf>] [<c012737e>] [<c0115fb3>] [<c0129df8>]
> [<c011833a>] [<c011ce16>] [<c0107f00>] [<c0108a9b>]
>
> Code: 0f 0b 6c 00 5a 49 28 c0 89 d8 2b 05 10 02 33 c0 69 c0 a3 8b
>  <3>X[15554] exited with preempt_count 1

Please decode it with ksymoops.
It not that important for BUGs but for real dirty oopses
ksumoops is a must.
--
vda
