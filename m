Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbRGIOuH>; Mon, 9 Jul 2001 10:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265472AbRGIOt6>; Mon, 9 Jul 2001 10:49:58 -0400
Received: from sammy.netpathway.com ([208.137.139.2]:12045 "EHLO
	sammy.netpathway.com") by vger.kernel.org with ESMTP
	id <S264954AbRGIOtr>; Mon, 9 Jul 2001 10:49:47 -0400
Message-ID: <3B49C487.455681FC@netpathway.com>
Date: Mon, 09 Jul 2001 09:49:44 -0500
From: "Gary White (Network Administrator)" <admin@netpathway.com>
Organization: Internet Pathway
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VMWare crashes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realize this may be a VMWare problem, but I just waited to
bring this to the attention of the developers in case it was related
to the kernel and to also see if anyone else is having the same
problem. VMWare dies under load with all kernel versions up to and
including ac versions after 2.4.6. Kernel version up to and including
2.4.5-ac15 I know all run fine. Somewhere between 2.4.5-ac15 and 2.4.6
is where the problem started. I have backed up to 2.4.5 now and VMWare
is rock solid.

Running VMWare Version 2.0.4 Build-1142
Asus K7V KT133 Chipset
Athlon 1000Mhz w/512MB Memory

Unable to handle kernel NULL pointer dereference at virtual address 00000070
 printing eip:
e1af85e1
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<e1af85e1>]
EFLAGS: 00013282
eax: 00000000   ebx: 00000000   ecx: c243e000   edx: 00000000
esi: d6b2f480   edi: dfe24df4   ebp: dfe24dc0   esp: c243feb0
ds: 0018   es: 0018   ss: 0018
Process vmware (pid: 487, stackpage=c243f000)
Stack: de7aac04 00000000 de7aac00 d6b2fd80 de7aac3c 00000001 dfe212c0 dfe4d400
       dfe212c0 dfe212c0 d6b2fd80 e1af6f9e dfe24e14 c76f1e00 00003202 de7aac04
       00000000 de7aac00 d6b2fd80 e1af74e6 de7aac04 c76f1e00 c76f1e00 c0203fe4
Call Trace: [<c0203fe4>] [<c0203fe4>] [<c011722f>] [<c012eb26>] [<c0106dc3>]

Code: 8b 42 70 83 f8 01 74 0a ff 4a 70 0f 94 c0 84 c0 74 0c 83 c4









-- 
Gary White               Network Administrator
admin@netpathway.com          Internet Pathway
Voice 601-776-3355            Fax 601-776-2314

