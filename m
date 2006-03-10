Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWCJLos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWCJLos (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 06:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWCJLos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 06:44:48 -0500
Received: from lucidpixels.com ([66.45.37.187]:54924 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932111AbWCJLor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 06:44:47 -0500
Date: Fri, 10 Mar 2006 06:44:46 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: MCE Errors, Bad CPU, Memory or Motherboard?
Message-ID: <Pine.LNX.4.64.0603100642220.1165@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first time I have seen an MCE error, googling the EIP value at 
the time of the panic does not return any useful results.

Does anyone know whether it is the CPU or MEMORY that is bad in this 
machine?  As it shows some problems with BANK4; however, if the CPU is 
bad, then it is possible to get all sorts of unpredictable results, right?

Dec  9 23:21:25 box  CPU 0: Machine Check Exception
Dec  9 23:21:25 box  Bank 4: f62ba001c0080813 at 00000000a6e6c2c0
Dec  9 23:21:25 box  Kernel panic: CPU context corrupt
Dec  9 23:21:25 box kernel: CPU 0
Dec  9 23:21:25 box kernel: CPU 0
Dec  9 23:21:25 box kernel: Bank 4
Dec  9 23:21:25 box kernel: Bank 4
Dec  9 23:21:25 box kernel: Kernel panic
Dec  9 23:21:25 box kernel: Kernel panic
Dec  9 23:21:26 box  kernel BUG at panic.c:66!
Dec  9 23:21:26 box  invalid operand: 0000
Dec  9 23:21:26 box  CPU:    0
Dec  9 23:21:26 box  EIP:    0010
Dec  9 23:21:26 box  EFLAGS: 00010282
Dec  9 23:21:26 box  eax: f895c1d0   ebx
Dec  9 23:21:26 box  esi: 00000415   edi
Dec  9 23:21:26 box  ds: 0018   es
Dec  9 23:21:26 box  Process java (pid: 6852, stackpage=e0ec5000)
Dec  9 23:21:26 box  Stack: 04000000 e0ec5fa4 c010fc28 c02942b8 00000005 
c0080813 00000417 00000416
Dec  9 23:21:26 box         00000005 00000000 00000004 e0ec4000 00000000 
c010fd00 e0ec5fb4 c010fd11
Dec  9 23:21:26 box         e0ec5fc4 00000000 bfffc090 c0108ed4 e0ec5fc4 
00000000 00000023 44841510
Dec  9 23:21:26 box  Call Trace:    [<c010fc28>] [<c010fd00>] [<c010fd11>] 
[<c0108ed4>]
Dec  9 23:21:26 box
Dec  9 23:21:26 box  Code: 0f 0b 42 00 28 6a 29 c0 b9 00 e0 ff ff 21 e1 8b 
51 30 c1 e2

Thanks,

Justin.
