Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272829AbRIGTBg>; Fri, 7 Sep 2001 15:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272828AbRIGTB1>; Fri, 7 Sep 2001 15:01:27 -0400
Received: from yaghut.morva.net ([213.29.54.3]:23965 "HELO morva.net")
	by vger.kernel.org with SMTP id <S272826AbRIGTBR>;
	Fri, 7 Sep 2001 15:01:17 -0400
From: "Hamid Hashemi Golpayegani" <hamid@morva.net>
To: <linux-kernel@vger.kernel.org>
Subject: What is error means ?! 
Date: Fri, 7 Sep 2001 23:36:01 +0330
Message-ID: <001001c137d8$84f77cc0$0100a8c0@hashemi>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
In-Reply-To: <20010907182839Z272819-760+10730@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi , 

I got this error in my messages sometimes and my network services ( TCP
Services ) stop responding but when I ping this machine the pings works
cool and the routing also works . But I can't login to the machine . 
Any idea that what is this message means ?! 

Sep  7 17:48:00 marmar4 kernel: Unable to handle kernel paging request
at virtual address 85bd6bcc Sep  7 17:48:00 marmar4 kernel:
current->tss.cr3 = 00101000, %cr3 = 00101000 Sep  7 17:48:00 marmar4
kernel: *pde = 00000000 Sep  7 17:48:00 marmar4 kernel: Oops: 0002
Sep  7 17:48:00 marmar4 kernel: CPU:    0
Sep  7 17:48:00 marmar4 kernel: EIP:
0010:[remove_from_queues+238/324]
Sep  7 17:48:00 marmar4 kernel: EFLAGS: 00010217
Sep  7 17:48:00 marmar4 kernel: eax: c0a00250   ebx: c173ab30   ecx:
c173ab30   edx: 85bd6bb0
Sep  7 17:48:00 marmar4 kernel: esi: c173ab30   edi: 00000000   ebp:
c03564e8   esp: cff2df78
Sep  7 17:48:00 marmar4 kernel: ds: 0018   es: 0018   ss: 0018
Sep  7 17:48:00 marmar4 kernel: Process kswapd (pid: 5, process nr: 5,
stackpage=cff2d000) Sep  7 17:48:00 marmar4 kernel: Stack: c173ab30
c01299d1 c173ab30 c03564e8 000007fc 00000001 00000030 fffffffc
Sep  7 17:48:00 marmar4 kernel:        c011df6c c03564e8 00000001
cff2c000 0000001a 00000006 00000001 00000001
Sep  7 17:48:00 marmar4 kernel:        c0123518 00000006 00000030
cff2c000 c020297a cff2c2bd 00000e00 cff2c000
Sep  7 17:48:00 marmar4 kernel: Call Trace: [try_to_free_buffers+61/236]
[shrink_mmap+356/384] [do_try_to_free_pages+88/232] [tvecs+7418/14048]
[kswapd+102/156] [get_options+0/112] [kernel_thread+35/48] Sep  7
17:48:00 marmar4 kernel: Code: 89 42 1c 8b 51 1c 8b 41 38 89 42 38 8b 79
28 8d 14 bd 00 00 Sep  7 17:56:47 marmar4 kernel: Unable to handle
kernel paging request at virtual address 4173a0fc Sep  7 17:56:47
marmar4 kernel: current->tss.cr3 = 0b7fb000, %cr3 = 0b7fb000 Sep  7
17:56:47 marmar4 kernel: *pde = 00000000 Sep  7 17:56:47 marmar4 kernel:
Oops: 0002
Sep  7 17:56:47 marmar4 kernel: CPU:    0
Sep  7 17:56:47 marmar4 kernel: EIP:
0010:[remove_from_queues+238/324]
Sep  7 17:56:47 marmar4 kernel: EFLAGS: 00010217
Sep  7 17:56:47 marmar4 kernel: eax: c33b0620   ebx: c173a8b0   ecx:
c173a8b0   edx: 4173a0e0
Sep  7 17:56:47 marmar4 kernel: esi: c173a8b0   edi: 00000000   ebp:
c03b38f0   esp: cbc2dee4
Sep  7 17:56:47 marmar4 kernel: ds: 0018   es: 0018   ss: 0018
Sep  7 17:56:47 marmar4 kernel: Process squid (pid: 2652, process nr:
47, stackpage=cbc2d000) Sep  7 17:56:47 marmar4 kernel: Stack: c173a8b0
c01299d1 c173a8b0 c03b38f0 000007fd 00000001 00000015 fffffffc
Sep  7 17:56:47 marmar4 kernel:        c011df6c c03b38f0 00000001
cbc2c000 0000000f 00000006 00000001 00000001
Sep  7 17:56:47 marmar4 kernel:        c0123518 00000006 00000015
cbc2c000 00000015 000000ff bffefabc cbc2c000
Sep  7 17:56:47 marmar4 kernel: Call Trace: [try_to_free_buffers+61/236]
[shrink_mmap+356/384] [do_try_to_free_pages+88/232]
[try_to_free_pages+20/28] [__get_free_pages+159/748] [alloc_wait+20/156]
[sys_poll+153/376]
Sep  7 17:56:47 marmar4 kernel:        [system_call+52/56]
[startup_32+43/164]
Sep  7 17:56:47 marmar4 kernel: Code: 89 42 1c 8b 51 1c 8b 41 38 89 42
38 8b 79 28 8d 14 bd 00 0

--
Regards

    =================================================================
   /  Seyyed Hamid Reza    /        WINDOWS FOR NOW  !!            /
  /  Hashemi Golpayegani  /  Linux for future , FreeBSD for ever  /
 /    Morva System Co.   / ------------------------------------- /
/  Network Administrator/ hamid@morva.net   ,   ICQ# : 42209876 /
================================================================
 


