Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278584AbRKAIoB>; Thu, 1 Nov 2001 03:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278589AbRKAInv>; Thu, 1 Nov 2001 03:43:51 -0500
Received: from tartu-gw.cv.ee ([213.168.20.162]:6273 "EHLO tartu.cv.ee")
	by vger.kernel.org with ESMTP id <S278582AbRKAInn>;
	Thu, 1 Nov 2001 03:43:43 -0500
Date: Thu, 1 Nov 2001 10:43:44 +0200 (EET)
From: Janek Hiis <janek@tartu.cv.ee>
X-X-Sender: <janek@cat.cvo>
To: <linux-kernel@vger.kernel.org>
Subject: general protection fault: 0000
Message-ID: <Pine.LNX.4.33.0111011034010.8576-100000@cat.cvo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have kernel 2.2.19, one 3Com nic. 32 MB memory. This is a small mail
server.
After these messages are received the system is still usable ...
What do these messages mean and could this be a hardware problem ?

Oct 26 14:40:24 mail kernel: Unable to handle kernel paging request at virtual address 40d505e3
Oct 26 14:40:24 mail kernel: current->tss.cr3 = 01b71000, %%cr3 = 01b71000
Oct 26 14:40:24 mail kernel: *pde = 00000000
Oct 26 14:40:24 mail kernel: Oops: 0002
Oct 26 14:40:24 mail kernel: CPU:    0
Oct 26 14:40:24 mail kernel: EIP:    0010:[3c509:__insmod_3c509_O/lib/modules/2.2.19/net/3c509.o_M3B4054B3_V+-8511361/76]
Oct 26 14:40:24 mail kernel: EFLAGS: 00010256
Oct 26 14:40:24 mail kernel: eax: c01306e3   ebx: c1fa8860   ecx: 0000000c   edx: c1ff0058
Oct 26 14:40:24 mail kernel: esi: c1fa4060   edi: c1337005   ebp: c1ff2928   esp: c1491f00
Oct 26 14:40:24 mail kernel: ds: 0018   es: 0018   ss: 0018
Oct 26 14:40:24 mail kernel: Process ipop3d (pid: 531, process nr: 20, stackpage=c1491000)
Oct 26 14:40:24 mail kernel: Stack: c1491f54 c1491f54 00000000 c1337005 0000000b c1ff2928 c1337001 00006223
Oct 26 14:40:24 mail kernel:        00000003 c012b7f4 c1fa4060 c1491f54 c1491f54 c012ba6f c1fa4060 c1491f54
Oct 26 14:40:24 mail kernel:        0000000b c19275c0 ffffffe9 00000001 bfffe874 c1337001 00000003 00006223
Oct 26 14:40:24 mail kernel: Call Trace: [cached_lookup+16/84] [lookup_dentry+275/488] [open_namei+102/748] [filp_open+68/240] [sys_open+54/148] [system_call+52/56]
Oct 26 14:40:24 mail kernel: Code: c1 80 00 ff c1 80 00 ff c1 88 00 ff c1 88 00 ff c1 90 00 ff Oc

Oct 26 15:10:55 mail kernel: general protection fault: 0000
Oct 26 15:10:55 mail kernel: CPU:    0
Oct 26 15:10:55 mail kernel: EIP:    0010:[3c509:__insmod_3c509_O/lib/modules/2.2.19/net/3c509.o_M3B4054B3_V+-8511374/76]
Oct 26 15:10:55 mail kernel: EFLAGS: 00010256
Oct 26 15:10:55 mail kernel: eax: c01306e3   ebx: c1fa8860   ecx: 0000000c   edx: c1ff0058
Oct 26 15:10:55 mail kernel: esi: c1fa4060   edi: c1285005   ebp: c1ff2928   esp: c1451f00
Oct 26 15:10:55 mail kernel: ds: 0018   es: 0018   ss: 0018
Oct 26 15:10:55 mail kernel: Process ipop3d (pid: 781, process nr: 21, stackpage=c1451000)
Oct 26 15:10:55 mail kernel: Stack: c1451f54 c1451f54 00000000 c1285005 0000000b c1ff2928 c1285001 00006223
Oct 26 15:10:55 mail kernel:        00000003 c012b7f4 c1fa4060 c1451f54 c1451f54 c012ba6f c1fa4060 c1451f54
Oct 26 15:10:55 mail kernel:        0000000b c1fa2860 ffffffe9 00000001 bfffe874 c1285001 00000003 00006223
Oct 26 15:10:55 mail kernel: Call Trace: [cached_lookup+16/84] [lookup_dentry+275/488] [open_namei+102/748] [filp_open+68/240] [sys_open+54/148] [system_call+52/56]
Oct 26 15:10:55 mail kernel: Code: 2e c1 18 42 2e c1 78 00 ff c1 78 00 ff c1 80 00 ff c1 80 00


TIA,
Janek Hiis

