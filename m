Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129554AbQKTVe3>; Mon, 20 Nov 2000 16:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129550AbQKTVeT>; Mon, 20 Nov 2000 16:34:19 -0500
Received: from pC19F0954.dip.t-dialin.net ([193.159.9.84]:17140 "EHLO
	mail.linsoft.de") by vger.kernel.org with ESMTP id <S129544AbQKTVeE> convert rfc822-to-8bit;
	Mon, 20 Nov 2000 16:34:04 -0500
From: Oliver Poths <oliver.poths@linsoft.de>
Date: Mon, 20 Nov 2000 21:03:45 GMT
Message-ID: <20001120.21034500@rock.>
Subject: kernel-2.4.0-test11 crashed again; this time i send you the
 Oops-message 
To: linux-kernel@vger.kernel.org
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

I Tried again to built my soft-raid by the same way, with the same 
result. But this time i sent you that nice message the kernel has shown 
me:

Unable to handle kernel NULL pointer dereference at virtual address 
00000010 printing eip:
c01c8e66
*pde = 00000000
Oops: 0000
CPU:	0
EIP:	0010:[<c01c8e66>]
EFLAGS: 00010246
eax: 00000000	ebx: c7f5f000	ecx: c7f61000	edx: c7fe1e64
esi: c7f58000	edi: c7f6abc0	ebp: 00001000	esp: c7fe1e18
ds: 0018	es: 0018	ss: 0018
Process swapper (pid:1, stackpage=c7fe1000)
Stack: 00001000 c7f58000 c7f5f000 c7f61000 c7fe1e64 00000003 c7f6abc0 
00000003
	 c01cbda5 00000003 c7fe1e64 00000003 00000003 c1249bc0 c1240400 c7fe1e78
	 00000000 c7f6abc0 c1240400 c7f6abc0 c7f75340 c7f752c0 00000000 00000000
Call Trace: [<c01cbda5>] [<c01cbe7c>] [<c01cc274>] [<c01c448c>] 
[<c011ad30>] [<c01c47e1>] [<c024174f>]
	[<c01c49f2>] [<c0107007>] [<c0108d58>]
Code: 8b 40 10 ff d0 83 c4 10 eb 3b 8b 42 0c 8b 78 34 83 7c 24 14
Kernel panic: Attempted to kill init!



looks fascinating...

Do you need the kernel-config?

Best regards
Oliver Poths
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
