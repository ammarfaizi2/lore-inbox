Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286393AbRLJVMK>; Mon, 10 Dec 2001 16:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286394AbRLJVMB>; Mon, 10 Dec 2001 16:12:01 -0500
Received: from geneva.vmware.com ([63.93.12.3]:19997 "EHLO geneva.vmware.com")
	by vger.kernel.org with ESMTP id <S286393AbRLJVLs>;
	Mon, 10 Dec 2001 16:11:48 -0500
Message-ID: <2CC5AC63B162D4119DE400B0D0215318023A32D9@pa-exch1.vmware.com>
From: Tech Info <tech_info@vmware.com>
To: "'Gregoire Favre'" <greg@ulima.unil.ch>, Tech Info <tech_info@vmware.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Unable to handle kernel NULL pointer dereference at virtual a
	ddress 00000004 (VMWARE,2.4.16 and 2.4.17-pre7)
Date: Mon, 10 Dec 2001 13:11:35 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Gregoire,

Thanks for your message. Please be advised that VMware Workstation 3.0 only
officially supports up to the Linux kernel 2.4.6 (see
http://www.vmware.com/support/ws3/doc/ws30_intro2.html#1006095) . Anything
higher than that may or may not work. You might have to downgrade to a lower
kernel in order to continue using VMware. We plan to support the higher
kernels in a future release but there is no timeframe when that will happen.
My only suggestion is to stay tuned to our website for further details. 

Regards,

Paul Yujuico
VMware Sales Support 

-----Original Message-----
From: Gregoire Favre [mailto:greg@ulima.unil.ch]
Sent: Monday, December 10, 2001 7:45 AM
To: Tech Info
Cc: linux-kernel@vger.kernel.org
Subject: Unable to handle kernel NULL pointer dereference at virtual
address 00000004 (VMWARE,2.4.16 and 2.4.17-pre7)


Hello,

I try to use VMWARE 3.0 under 2.4.16 and had problems, so I try under
2.4.17-pre7, with same results:

ble to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c011427d
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011427d>]    Tainted: GF
EFLAGS: 00010046
eax: d6275d24   ebx: 00000000   ecx: cec7a014   edx: cec7a00c
esi: 00000246   edi: 00000000   ebp: ce951f64   esp: ce951efc
ds: 0018   es: 0018   ss: 0018
Process vmnet-dhcpd (pid: 3209, stackpage=ce951000)
Stack: d6275ca0 cf7cd7e0 d9106be2 cf7cd7e0 d6275d24 ce951f50 00000000
d91053d6 
       d6275ca0 cf7cd7e0 ce951f50 c013e1b8 cf7cd7e0 ce951f50 00000145
00000040 
       ce950000 7fffffff 00000006 ce951f50 00000007 00000000 cec7a000
00000000 
Call Trace: [<d9106be2>] [<d91053d6>] [<c013e1b8>] [<c013e595>] [<c01318c3>]

   [<c0106d3b>] 

Code: 89 4b 04 89 5a 08 89 41 04 89 08 56 9d 5b 5e c3 8d 76 00 56 
 <1>Unable to handle kernel NULL pointer dereference at virtual address
00000004
 printing eip:
c011427d
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011427d>]    Tainted: GF
EFLAGS: 00010046
eax: d6275524   ebx: 00000000   ecx: cf076014   edx: cf07600c
esi: 00000246   edi: ceed8000   ebp: 00000000   esp: ce957ef4
ds: 0018   es: 0018   ss: 0018
Process vmnet-natd (pid: 3208, stackpage=ce957000)
Stack: d62754a0 00000145 d9106be2 cf7cd260 d6275524 ce957fa8 cf7cd260
d91053d6 
       d62754a0 cf7cd260 ce957fa8 c013e7f5 cf7cd260 ce957fa8 00000000
00000003
       00000003 7fffffff c013e8d6 00000003 ceed8000 ce957f54 ce957f58
ce956000 
Call Trace: [<d9106be2>] [<d91053d6>] [<c013e7f5>] [<c013e8d6>] [<c013eb87>]

   [<c0106d3b>] 

Code: 89 4b 04 89 5a 08 89 41 04 89 08 56 9d 5b 5e c3 8d 76 00 56 
 <7>/dev/vmnet: open called by PID 3317 (t-netifup)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 3348 (t-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c011427d
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011427d>]    Tainted: GF
EFLAGS: 00010046
eax: d6275c24   ebx: 00000000   ecx: cf060014   edx: cf06000c
esi: 00000246   edi: 00000000   ebp: ce9a7f64   esp: ce9a7efc
ds: 0018   es: 0018   ss: 0018
Process vmnet-dhcpd (pid: 3350, stackpage=ce9a7000)
Stack: d6275ba0 d22d8240 d9106be2 d22d8240 d6275c24 ce9a7f50 00000000
d91053d6 
       d6275ba0 d22d8240 ce9a7f50 c013e1b8 d22d8240 ce9a7f50 00000145
00000040
       ce9a6000 7fffffff 00000006 ce9a7f50 00000007 00000000 cf060000
00000000 
Call Trace: [<d9106be2>] [<d91053d6>] [<c013e1b8>] [<c013e595>] [<c01318c3>]

   [<c0106d3b>] 

Code: 89 4b 04 89 5a 08 89 41 04 89 08 56 9d 5b 5e c3 8d 76 00 56 

I have put the System-map of the 2.4.17-pre7 kernel under
http://ulima.unil.ch/greg/linux/System.map-2.4.17-pre7 in case it's needed
;-)
And the config of that kernel under
http://ulima.unil.ch/greg/linux/2.4.17-pre7

Thanks,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
