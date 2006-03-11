Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWCKWkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWCKWkl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 17:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWCKWkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 17:40:41 -0500
Received: from xenotime.net ([66.160.160.81]:59330 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750897AbWCKWkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 17:40:41 -0500
Date: Sat, 11 Mar 2006 14:42:26 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MCE Errors, Bad CPU, Memory or Motherboard?
Message-Id: <20060311144226.0edef452.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0603100642220.1165@p34>
References: <Pine.LNX.4.64.0603100642220.1165@p34>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2006 06:44:46 -0500 (EST) Justin Piszcz wrote:

> This is the first time I have seen an MCE error, googling the EIP value at 
> the time of the panic does not return any useful results.
> 
> Does anyone know whether it is the CPU or MEMORY that is bad in this 
> machine?  As it shows some problems with BANK4; however, if the CPU is 
> bad, then it is possible to get all sorts of unpredictable results, right?
> 
> Dec  9 23:21:25 box  CPU 0: Machine Check Exception
> Dec  9 23:21:25 box  Bank 4: f62ba001c0080813 at 00000000a6e6c2c0
> Dec  9 23:21:25 box  Kernel panic: CPU context corrupt
> Dec  9 23:21:25 box kernel: CPU 0
> Dec  9 23:21:25 box kernel: CPU 0
> Dec  9 23:21:25 box kernel: Bank 4
> Dec  9 23:21:25 box kernel: Bank 4
> Dec  9 23:21:25 box kernel: Kernel panic
> Dec  9 23:21:25 box kernel: Kernel panic
> Dec  9 23:21:26 box  kernel BUG at panic.c:66!
> Dec  9 23:21:26 box  invalid operand: 0000
> Dec  9 23:21:26 box  CPU:    0
> Dec  9 23:21:26 box  EIP:    0010
> Dec  9 23:21:26 box  EFLAGS: 00010282
> Dec  9 23:21:26 box  eax: f895c1d0   ebx
> Dec  9 23:21:26 box  esi: 00000415   edi
> Dec  9 23:21:26 box  ds: 0018   es
> Dec  9 23:21:26 box  Process java (pid: 6852, stackpage=e0ec5000)
> Dec  9 23:21:26 box  Stack: 04000000 e0ec5fa4 c010fc28 c02942b8 00000005 
> c0080813 00000417 00000416
> Dec  9 23:21:26 box         00000005 00000000 00000004 e0ec4000 00000000 
> c010fd00 e0ec5fb4 c010fd11
> Dec  9 23:21:26 box         e0ec5fc4 00000000 bfffc090 c0108ed4 e0ec5fc4 
> 00000000 00000023 44841510
> Dec  9 23:21:26 box  Call Trace:    [<c010fc28>] [<c010fd00>] [<c010fd11>] 
> [<c0108ed4>]
> Dec  9 23:21:26 box
> Dec  9 23:21:26 box  Code: 0f 0b 42 00 28 6a 29 c0 b9 00 e0 ff ff 21 e1 8b 
> 51 30 c1 e2

I suppose you tried the obvious tools (parsemce and maybe mcelog)...

http://www.codemonkey.org.uk/projects/parsemce/
ftp://ftp.x86-64.org/pub/linux-x86_64/tools/mcelog/

---
~Randy
Please use an email client that implements proper (compliant) threading.
(You know who you are.)
