Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271550AbRIJSH7>; Mon, 10 Sep 2001 14:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271529AbRIJSHj>; Mon, 10 Sep 2001 14:07:39 -0400
Received: from gate.web2010.com ([216.157.79.250]:63624 "EHLO
	archimedes.garrettm.com") by vger.kernel.org with ESMTP
	id <S271520AbRIJSHg>; Mon, 10 Sep 2001 14:07:36 -0400
Message-Id: <200109101807.f8AI7sv01955@archimedes.garrettm.com>
Content-Type: text/plain; charset=US-ASCII
From: Garrett Marone <garrett@garrettm.com>
Reply-To: garrett@garrettm.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.8 kernel oops
Date: Mon, 10 Sep 2001 14:07:54 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More then how to fix this, I would like to know why this is happening, If you 
need more information then this, I can easily recreate the screen.

md: stopping all md devices.
Unable to handle kernel paging request at virtual address a03d8000
 printing eip:
a03d8000
*pde=00000000
Oops: 0000
CPU: 	0
EIP: 	0010:[<a03d8000>}
EFLAGS:	0010282
eax: a03d8000	ebx: cc805504	ecx: 00789ec	edx: 00000000
esi: 00000000	edi: 00000001	ebp: bffffd94	esp: c984de88
ds: 0018	es: 0018	ss: 0018
Process reboot (pid: 928, stackpage=c984d000)
Stack: c012022a cc805504 00000001 00000000 c984c000 c984c000 c984c000 c012053e
	c02e9a08 00000001 00000000 c984c000 bffffee7 fee1dead c903aee0 400bf000
	00000000 4001900 cbdcabd0 400bfa60 00000000 c0124a2e cbdcabd0 c903aee0
Call Trace: [<c012022a>] [<c012053e>] [<c0124a2e>] [<c01d638d>] [<c0148f3f>] 
[<c0147cd9>] [<c0134f23>]
	[<c0133cbf>] [<c0133d23>] [<c0106fdb>]
Code: Bad EIP value.

Machine is a Celeron 500, NCR scsi controller, 196MB ram, 9.1GB hd, SiS 
Chipset.

This same kernel runs just fine on a different machine, the 2.2.19 kernel 
works fine on both machines, this is an SMP kernel, but the machines are 
single processor.  this only happens on reboot, or shutdown, Otherwise, the 
machine runs fine. 
Thank you for your time.

Garrett Marone
Systems Administration
Hostcentric.com
